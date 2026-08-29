// 角色移动系统核心函数，每帧调用一次，负责处理所有移动物理计算、根运动、网络同步和状态更新
void UCharacterMovementComponent::PerformMovement(float DeltaSeconds)
{
    // 性能统计：标记该函数执行时间用于Profiler分析
    SCOPE_CYCLE_COUNTER(STAT_CharacterMovementPerformMovement);

#if UE_WITH_REMOTE_OBJECT_HANDLE && UE_AUTORTFM
    // 自动事务内存优化：假设移动期间只碰撞静态几何体，避免跨服务器推测执行的开销
    UE::RemoteExecutor::FSpeculationExecutionScope AssumeNoCrossServerHits;
#endif

    // 获取世界上下文并检查数据有效性
    const UWorld* MyWorld = GetWorld();
    if (!HasValidData() || MyWorld == nullptr)
    {
        return; // 数据无效时直接返回，避免崩溃
    }

    // 检测角色是否在上次更新后发生了传送（例如复活时传送到重生点）
    bTeleportedSinceLastUpdate = UpdatedComponent->GetComponentLocation() != LastUpdateLocation;
    
    // 如果移动模式为None、组件不可移动或正在物理模拟，则跳过移动逻辑
    if (MovementMode == MOVE_None || UpdatedComponent->Mobility != EComponentMobility::Movable || UpdatedComponent->IsSimulatingPhysics())
    {
        // 仅在非客户端更新且不忽略根运动时处理根运动消耗
        if (!CharacterOwner->bClientUpdating && !CharacterOwner->bServerMoveIgnoreRootMotion)
        {
            // 消耗动画根运动：即使不移动也要Tick动画姿态
            if (CharacterOwner->IsPlayingRootMotion() && CharacterOwner->GetMesh())
            {
                TickCharacterPose(DeltaSeconds);
                RootMotionParams.Clear(); // 清空动画根运动参数
            }
            // 清空其他根运动源（如GAS技能触发的根运动）
            if (CurrentRootMotion.HasActiveRootMotionSources())
            {
                CurrentRootMotion.Clear();
            }
        }
        // 清除所有累积的物理力（如LaunchCharacter的弹射力）
        ClearAccumulatedForces();
        return; // 跳过后续所有移动逻辑
    }

    // 如果角色在地面移动且发生了传送，强制下一帧检查地面（防止传送后卡在地里）
    bForceNextFloorCheck |= (IsMovingOnGround() && bTeleportedSinceLastUpdate);

    // 更新叠加型根运动的速度基准值
    // 关键点：GAS技能中的AdditiveVelocity根运动需要正确累加外部速度变化
    if( CurrentRootMotion.HasAdditiveVelocity() )
    {
        const FVector Adjustment = (Velocity - LastUpdateVelocity);
        CurrentRootMotion.LastPreAdditiveVelocity += Adjustment; // 累积速度变化到基准值

#if ROOT_MOTION_DEBUG
        // 调试信息：显示叠加速度调整
        if (RootMotionSourceDebug::CVarDebugRootMotionSources.GetValueOnGameThread() == 1)
        {
            if (!Adjustment.IsNearlyZero())
            {
                FString AdjustedDebugString = FString::Printf(TEXT("PerformMovement HasAdditiveVelocity LastUpdateVelocityAdjustment LastPreAdditiveVelocity(%s) Adjustment(%s)"),
                    *CurrentRootMotion.LastPreAdditiveVelocity.ToCompactString(), *Adjustment.ToCompactString());
                RootMotionSourceDebug::PrintOnScreen(*CharacterOwner, AdjustedDebugString);
            }
        }
#endif
    }

    // 保存移动前的速度和位置，用于后续计算和网络同步
    FVector OldVelocity;
    FVector OldLocation;

    // 使用作用域胶囊体移动更新，优化多次MoveComponent调用的性能
    // 重要：这减少了不必要的碰撞检测开销，在复杂移动场景下性能提升明显
    {
        FScopedCapsuleMovementUpdate ScopedMovementUpdate(UpdatedComponent, bEnableScopedMovementUpdates);

        // 更新基于物体的移动（如站在移动平台上）
        MaybeUpdateBasedMovement(DeltaSeconds);

        // 清理无效的根运动源（包括自然结束的根运动）
        // 注意：必须在ApplyAccumulatedForces之前清理，因为根运动源可能包含速度限制或覆盖逻辑
        const bool bHasRootMotionSources = HasRootMotionSources();
        if (bHasRootMotionSources && !CharacterOwner->bClientUpdating && !CharacterOwner->bServerMoveIgnoreRootMotion)
        {
            SCOPE_CYCLE_COUNTER(STAT_CharacterMovementRootMotionSourceCalculate);

            const FVector VelocityBeforeCleanup = Velocity;
            CurrentRootMotion.CleanUpInvalidRootMotion(DeltaSeconds, *CharacterOwner, *this);

#if ROOT_MOTION_DEBUG
            // 调试：显示清理根运动源后的速度变化
            if (RootMotionSourceDebug::CVarDebugRootMotionSources.GetValueOnGameThread() == 1)
            {
                if (Velocity != VelocityBeforeCleanup)
                {
                    const FVector Adjustment = Velocity - VelocityBeforeCleanup;
                    FString AdjustedDebugString = FString::Printf(TEXT("PerformMovement CleanUpInvalidRootMotion Velocity(%s) VelocityBeforeCleanup(%s) Adjustment(%s)"),
                        *Velocity.ToCompactString(), *VelocityBeforeCleanup.ToCompactString(), *Adjustment.ToCompactString());
                    RootMotionSourceDebug::PrintOnScreen(*CharacterOwner, AdjustedDebugString);
                }
            }
#endif
        }

        // 保存移动前的状态
        OldVelocity = Velocity;
        OldLocation = UpdatedComponent->GetComponentLocation();

        // 应用累积的物理力（如重力、弹射力等）
        ApplyAccumulatedForces(DeltaSeconds);

        // 在移动前更新角色状态（如蹲伏、攀爬等）
        UpdateCharacterStateBeforeMovement(DeltaSeconds);

        // 导航移动模式特殊处理：如果角色想要离开导航移动，尝试切换到普通移动
        if (MovementMode == MOVE_NavWalking && bWantsToLeaveNavWalking)
        {
            TryToLeaveNavWalking();
        }

        // 处理之前缓存的弹射请求（LaunchCharacter的延迟执行）
        // 关键点：GAS技能中的LaunchCharacter调用在这里生效
        HandlePendingLaunch();
        ClearAccumulatedForces(); // 清空已处理的累积力

#if ROOT_MOTION_DEBUG
        // 调试：显示应用物理力后的速度变化
        if (RootMotionSourceDebug::CVarDebugRootMotionSources.GetValueOnGameThread() == 1)
        {
            if (OldVelocity != Velocity)
            {
                const FVector Adjustment = Velocity - OldVelocity;
                FString AdjustedDebugString = FString::Printf(TEXT("PerformMovement ApplyAccumulatedForces+HandlePendingLaunch Velocity(%s) OldVelocity(%s) Adjustment(%s)"),
                    *Velocity.ToCompactString(), *OldVelocity.ToCompactString(), *Adjustment.ToCompactString());
                RootMotionSourceDebug::PrintOnScreen(*CharacterOwner, AdjustedDebugString);
            }
        }
#endif

        // 更新叠加型根运动的速度基准值（考虑物理力影响后的变化）
        if( CurrentRootMotion.HasAdditiveVelocity() )
        {
            const FVector Adjustment = (Velocity - OldVelocity);
            CurrentRootMotion.LastPreAdditiveVelocity += Adjustment;

#if ROOT_MOTION_DEBUG
            if (RootMotionSourceDebug::CVarDebugRootMotionSources.GetValueOnGameThread() == 1)
            {
                if (!Adjustment.IsNearlyZero())
                {
                    FString AdjustedDebugString = FString::Printf(TEXT("PerformMovement HasAdditiveVelocity AccumulatedForces LastPreAdditiveVelocity(%s) Adjustment(%s)"),
                        *CurrentRootMotion.LastPreAdditiveVelocity.ToCompactString(), *Adjustment.ToCompactString());
                    RootMotionSourceDebug::PrintOnScreen(*CharacterOwner, AdjustedDebugString);
                }
            }
#endif
        }

        // 准备根运动数据（从动画和其他根运动源生成/累积）
        // 注意：客户端更新时跳过，避免重复计算
        if (bHasRootMotionSources && !CharacterOwner->bClientUpdating && !CharacterOwner->bServerMoveIgnoreRootMotion)
        {
            // 动画根运动：如果使用动画根运动，先Tick动画姿态
            if( CharacterOwner->IsPlayingRootMotion() && CharacterOwner->GetMesh() )
            {
                TickCharacterPose(DeltaSeconds);

                // 检查动画事件是否销毁了角色（安全保护）
                if (!HasValidData())
                {
                    return;
                }

                // 网络同步关键：本地自治代理客户端保存根运动数据，用于客户端预测和服务器校正
                if( CharacterOwner->IsLocallyControlled() && (CharacterOwner->GetLocalRole() == ROLE_AutonomousProxy) && CharacterOwner->IsPlayingNetworkedRootMotionMontage() )
                {
                    CharacterOwner->ClientRootMotionParams = RootMotionParams; // 缓存给网络同步使用
                }
            }

            // 生成非动画根运动源的数据（如GAS技能创建的根运动）
            {
                SCOPE_CYCLE_COUNTER(STAT_CharacterMovementRootMotionSourceCalculate);
                CurrentRootMotion.PrepareRootMotion(DeltaSeconds, *CharacterOwner, *this, true);
            }

            // 保存根运动数据用于网络同步
            if( CharacterOwner->IsLocallyControlled() && (CharacterOwner->GetLocalRole() == ROLE_AutonomousProxy) )
            {
                CharacterOwner->SavedRootMotion = CurrentRootMotion;
            }
        }

        // 将根运动应用到速度
        // 重要：动画根运动优先级最高，会覆盖其他所有根运动源
        if( CurrentRootMotion.HasOverrideVelocity() || HasAnimRootMotion() )
        {
            if( HasAnimRootMotion() ) // 动画根运动处理
            {
                // 将局部空间根运动转换为世界空间
                USkeletalMeshComponent * SkelMeshComp = CharacterOwner->GetMesh();
                if( SkelMeshComp )
                {
                    // 关键：在物理计算前转换，确保使用最新的变换
                    RootMotionParams.Set( ConvertLocalRootMotionToWorld(RootMotionParams.GetRootMotionTransform(), DeltaSeconds) );
                }

                // 将根运动位移转换为速度，用于物理模式计算
                if( DeltaSeconds > 0.f )
                {
                    AnimRootMotionVelocity = CalcAnimRootMotionVelocity(RootMotionParams.GetRootMotionTransform().GetTranslation(), DeltaSeconds, Velocity);
                    Velocity = ConstrainAnimRootMotionVelocity(AnimRootMotionVelocity, Velocity);
                    
                    // 特殊处理：下落状态时保留之前地面的XY速度（防止根运动中断滑翔等效果）
                    if (IsFalling())
                    {
                        Velocity += FVector(DecayingFormerBaseVelocity.X, DecayingFormerBaseVelocity.Y, 0.f);
                    }
                }
                
                // 日志输出：用于调试根运动效果
                UE_LOGF(LogRootMotion, Log,  "PerformMovement WorldSpaceRootMotion Translation: %ls, Rotation: %ls, Actor Facing: %ls, Velocity: %ls"
                    , *RootMotionParams.GetRootMotionTransform().GetTranslation().ToCompactString()
                    , *RootMotionParams.GetRootMotionTransform().GetRotation().Rotator().ToCompactString()
                    , *CharacterOwner->GetActorForwardVector().ToCompactString()
                    , *Velocity.ToCompactString()
                    );
            }
            else // 非动画根运动源处理（如GAS技能）
            {
                if( DeltaSeconds > 0.f )
                {
                    SCOPE_CYCLE_COUNTER(STAT_CharacterMovementRootMotionSourceApply);

                    const FVector VelocityBeforeOverride = Velocity;
                    FVector NewVelocity = Velocity;
                    // 累积所有覆盖型根运动源的速度
                    CurrentRootMotion.AccumulateOverrideRootMotionVelocity(DeltaSeconds, *CharacterOwner, *this, NewVelocity);
                    
                    // 下落状态特殊处理
                    if (IsFalling())
                    {
                        NewVelocity += CurrentRootMotion.HasOverrideVelocityWithIgnoreZAccumulate() ? 
                            FVector(DecayingFormerBaseVelocity.X, DecayingFormerBaseVelocity.Y, 0.f) : DecayingFormerBaseVelocity;
                    }
                    Velocity = NewVelocity;

#if ROOT_MOTION_DEBUG
                    // 调试：显示根运动覆盖后的速度变化
                    if (RootMotionSourceDebug::CVarDebugRootMotionSources.GetValueOnGameThread() == 1)
                    {
                        if (VelocityBeforeOverride != Velocity)
                        {
                            FString AdjustedDebugString = FString::Printf(TEXT("PerformMovement AccumulateOverrideRootMotionVelocity Velocity(%s) VelocityBeforeOverride(%s)"),
                                *Velocity.ToCompactString(), *VelocityBeforeOverride.ToCompactString());
                            RootMotionSourceDebug::PrintOnScreen(*CharacterOwner, AdjustedDebugString);
                        }
                    }
#endif
                }
            }
        }

#if ROOT_MOTION_DEBUG
        // 调试：显示应用根运动后的最终速度
        if (RootMotionSourceDebug::CVarDebugRootMotionSources.GetValueOnGameThread() == 1)
        {
            FString AdjustedDebugString = FString::Printf(TEXT("PerformMovement Velocity(%s) OldVelocity(%s)"),
                *Velocity.ToCompactString(), *OldVelocity.ToCompactString());
            RootMotionSourceDebug::PrintOnScreen(*CharacterOwner, AdjustedDebugString);
        }
#endif

        // NaN值检测：确保速度没有非法值，避免物理系统崩溃
        devCode(ensureMsgf(!Velocity.ContainsNaN(), TEXT("UCharacterMovementComponent::PerformMovement: Velocity contains NaN (%s)n%s"), *GetPathNameSafe(this), *Velocity.ToString()));

        // 清空跳跃输入，为下一帧跳跃准备
        CharacterOwner->ClearJumpInput(DeltaSeconds);
        NumJumpApexAttempts = 0; // 重置跳跃顶点尝试次数

        // 移动前最后一次机会更新速度（用户自定义扩展点）
        UpdateVelocityBeforeMovement(DeltaSeconds);
        
        // 核心物理位置变更：根据移动模式调用对应的物理函数
        // 注意：这里会处理碰撞、滑墙、爬台阶等所有物理交互
        StartNewPhysics(DeltaSeconds, 0);

        // 再次检查数据有效性（物理计算可能触发销毁）
        if (!HasValidData())
        {
            return;
        }

        // 根据移动结果更新角色状态（如是否落地、是否开始下落等）
        UpdateCharacterStateAfterMovement(DeltaSeconds);

        // 物理旋转：根据速度/加速度更新角色朝向
        // 可配置是否允许在动画根运动期间进行物理旋转
        if (bAllowPhysicsRotationDuringAnimRootMotion || !HasAnimRootMotion())
        {
            PhysicsRotation(DeltaSeconds);
        }

        // 应用根运动旋转（在物理移动完成后）
        if( HasAnimRootMotion() )
        {
            const FQuat OldActorRotationQuat = UpdatedComponent->GetComponentQuat();
            const FQuat RootMotionRotationQuat = RootMotionParams.GetRootMotionTransform().GetRotation();
            if( !RootMotionRotationQuat.IsIdentity() )
            {
                const FQuat NewActorRotationQuat = RootMotionRotationQuat * OldActorRotationQuat;
                MoveUpdatedComponent(FVector::ZeroVector, NewActorRotationQuat, true);
            }

#if !(UE_BUILD_SHIPPING)
            // 调试代码（默认禁用）：显示根运动位移和旋转的详细信息
            #if 0
            {
                const FRotator OldActorRotation = OldActorRotationQuat.Rotator();
                const FVector ResultingLocation = UpdatedComponent->GetComponentLocation();
                const FRotator ResultingRotation = UpdatedComponent->GetComponentRotation();

                // 显示当前位置坐标系
                DrawDebugCoordinateSystem(MyWorld, CharacterOwner->GetMesh()->GetComponentLocation() + FVector(0,0,1), ResultingRotation, 50.f, false);

                // 显示位移向量
                DrawDebugLine(MyWorld, OldLocation, ResultingLocation, FColor::Red, false, 10.f);

                const FMovementBaseInterfaceData* MovementBaseInterfaceData = GetMovementBaseInterfaceData();
                // 日志输出详细信息
                UE_LOGF(LogRootMotion, Warning,  "PerformMovement Resulting DeltaMove Translation: %ls, Rotation: %ls, MovementBase: %ls",
                    *(ResultingLocation - OldLocation).ToCompactString(), *(ResultingRotation - OldActorRotation).GetNormalized().ToCompactString(), *GetNameSafe(MovementBaseInterfaceData ? MovementBaseInterfaceData->GetMovementBaseObject() : nullptr));

                const FVector RMTranslation = RootMotionParams.GetRootMotionTransform().GetTranslation();
                const FRotator RMRotation = RootMotionParams.GetRootMotionTransform().GetRotation().Rotator();
                UE_LOGF(LogRootMotion, Warning,  "PerformMovement Resulting DeltaError Translation: %ls, Rotation: %ls",
                    *(ResultingLocation - OldLocation - RMTranslation).ToCompactString(), *(ResultingRotation - OldActorRotation - RMRotation).GetNormalized().ToCompactString() );
            }
            #endif
#endif // !(UE_BUILD_SHIPPING)

            // 清空已使用的根运动参数
            RootMotionParams.Clear();
        }
        else if (CurrentRootMotion.HasActiveRootMotionSources()) // 非动画根运动源的旋转处理
        {
            FQuat RootMotionRotationQuat;
            if (CharacterOwner && UpdatedComponent && CurrentRootMotion.GetOverrideRootMotionRotation(DeltaSeconds, *CharacterOwner, *this, RootMotionRotationQuat))
            {
                const FQuat OldActorRotationQuat = UpdatedComponent->GetComponentQuat();
                const FQuat NewActorRotationQuat = RootMotionRotationQuat * OldActorRotationQuat;
                MoveUpdatedComponent(FVector::ZeroVector, NewActorRotationQuat, true);
            }
        }

        // 消耗路径跟随请求的速度（AI导航相关）
        LastUpdateRequestedVelocity = bHasRequestedVelocity ? RequestedVelocity : FVector::ZeroVector;
        bHasRequestedVelocity = false;

        // 触发移动更新委托（用于蓝图和C++事件监听）
        OnMovementUpdated(DeltaSeconds, OldLocation, OldVelocity);
    } // 作用域结束，批量移动更新完成

    // 调用外部移动后事件（这些事件可能需要使用最新的碰撞重叠状态）
    CallMovementUpdateDelegate(DeltaSeconds, OldLocation, OldVelocity);

    // 保存基底位置（用于基于物体的移动）
    if (CharacterMovementCVars::BasedMovementMode == 0)
    {
        SaveBaseLocation(); // 旧版本行为
    }
    else
    {
        MaybeSaveBaseLocation(); // 优化版本：仅在需要时保存
    }
    
    // 更新组件速度（用于渲染和其他系统查询）
    UpdateComponentVelocity();

    // 网络同步优化：避免移动后网络更新延迟过长
    const bool bHasAuthority = CharacterOwner && CharacterOwner->HasAuthority();
    if (bHasAuthority && UNetDriver::IsAdaptiveNetUpdateFrequencyEnabled() && UpdatedComponent)
    {
        UNetDriver* NetDriver = MyWorld->GetNetDriver();
        if (NetDriver && NetDriver->IsServer())
        {
            // 如果角色移动了但网络更新被节流，取消节流以立即同步
            if (!NetDriver->IsPendingNetUpdate(CharacterOwner) && NetDriver->IsNetworkActorUpdateFrequencyThrottled(CharacterOwner))
            {
                if (ShouldCancelAdaptiveReplication())
                {
                    NetDriver->CancelAdaptiveReplication(CharacterOwner);
                }
            }
        }
    }

    // 获取移动后的新位置和旋转
    const FVector NewLocation = UpdatedComponent ? UpdatedComponent->GetComponentLocation() : FVector::ZeroVector;
    const FQuat NewRotation = UpdatedComponent ? UpdatedComponent->GetComponentQuat() : FQuat::Identity;

    // 服务器端更新变换时间戳（用于客户端插值同步）
    if (bHasAuthority && UpdatedComponent && !IsNetMode(NM_Client))
    {
        const bool bLocationChanged = (NewLocation != LastUpdateLocation);
        const bool bRotationChanged = (NewRotation != LastUpdateRotation);
        if (bLocationChanged || bRotationChanged)
        {
            // 关键网络同步逻辑：使用客户端时间戳而非服务器时间，确保插值平滑
            const bool bIsRemotePlayer = (CharacterOwner->GetRemoteRole() == ROLE_AutonomousProxy);
            const FNetworkPredictionData_Server_Character* ServerData = bIsRemotePlayer ? GetPredictionData_Server_Character() : nullptr;
            if (bIsRemotePlayer && ServerData && CharacterMovementCVars::NetUseClientTimestampForReplicatedTransform)
            {
                // 使用客户端累积的时间戳（客户端预测校正的关键）
                ServerLastTransformUpdateTimeStamp = float(ServerData->ServerAccumulatedClientTimeStamp);
            }
            else
            {
                // 回退到服务器时间
                ServerLastTransformUpdateTimeStamp = MyWorld->GetTimeSeconds();
            }
        }
    }

    // 更新最后一次更新的位置、旋转和速度，用于下一帧计算
    LastUpdateLocation = NewLocation;
    LastUpdateRotation = NewRotation;
    LastUpdateVelocity = Velocity;
}

（AI生成）