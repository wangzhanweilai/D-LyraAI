void UCharacterMovementComponent::TickComponent(float DeltaTime, enum ELevelTick TickType, FActorComponentTickFunction *ThisTickFunction)
{
    // 性能分析标记，用于 UE Insights 等性能分析工具追踪该函数执行时间
    SCOPED_NAMED_EVENT(UCharacterMovementComponent_TickComponent, FColor::Yellow);
    SCOPE_CYCLE_COUNTER(STAT_CharacterMovement);
    SCOPE_CYCLE_COUNTER(STAT_CharacterMovementTick);
    CSV_SCOPED_TIMING_STAT_EXCLUSIVE(CharacterMovement);

    // 初始化输入向量（用于后续计算移动加速度）
    FVector InputVector = FVector::ZeroVector;
    
    // 检查是否启用异步 Tick（通过控制台变量 CharacterMovementCVars::AsyncCharacterMovement 控制）
    // 异步模式下，输入消费和移动计算会延迟到物理线程执行
    bool bUsingAsyncTick = (CharacterMovementCVars::AsyncCharacterMovement == 1) && IsAsyncCallbackRegistered();
    
    // 如果不在异步模式，则立即消费本帧的玩家输入
    if (!bUsingAsyncTick)
    {
        // ConsumeInputVector() 会获取并清空由 PlayerController 累积的 ControlInputVector
        InputVector = ConsumeInputVector();
    }

    // 基础有效性检查：确保角色和组件引用有效，且不应该跳过更新
    if (!HasValidData() || ShouldSkipUpdate(DeltaTime))
    {
        return;
    }

    // 调用父类的 TickComponent（可能处理一些通用逻辑）
    Super::TickComponent(DeltaTime, TickType, ThisTickFunction);

    // 父类 Tick 可能会销毁角色或组件，需要再次检查有效性
    if (!HasValidData())
    {
        return;
    }

    // 异步 Tick 分支：适用于物理线程优化的高性能场景
    if (bUsingAsyncTick)
    {
        // 异步模式下，TickComponent 只负责提取根运动数据，不执行实际移动计算
        check(CharacterOwner && CharacterOwner->GetMesh());
        USkeletalMeshComponent* CharacterMesh = CharacterOwner->GetMesh();
        
        // 判断是否需要更新 Mesh 的姿态（可见性、LOD 等条件）
        if (CharacterMesh->ShouldTickPose())
        {
            // 记录当前是否正在播放根运动动画，以及根运动缩放系数
            // 因为动画可能在 TickPose 过程中结束，需要缓存结束前的状态
            const bool bWasPlayingRootMotion = CharacterOwner->IsPlayingRootMotion();
            const float RootMotionTranslationScale = CharacterOwner->GetAnimRootMotionTranslationScale();

            // 更新骨骼动画姿态（这是动画根运动的来源）
            CharacterMesh->TickPose(DeltaTime, true);
            
            // 检查根运动状态（动画可能在本帧结束）
            const bool bIsPlayingRootMotion = CharacterOwner->IsPlayingRootMotion();
            
            // 如果本帧正在播放或上一帧在播放根运动动画
            if (bIsPlayingRootMotion || bWasPlayingRootMotion)
            {
                // 从 Mesh 中提取动画产生的根运动数据（位移和旋转）
                FRootMotionMovementParams RootMotion = CharacterMesh->ConsumeRootMotion();
                
                if (RootMotion.bHasRootMotion)
                {
                    // 应用角色设置的根运动缩放系数（允许设计师调整动画位移幅度）
                    RootMotion.ScaleRootMotionTranslation(RootMotionTranslationScale);
                    
                    // 累加到 RootMotionParams 中，后续会在物理线程的 PerformMovement 中应用
                    RootMotionParams.Accumulate(RootMotion);
                }
            }
        }

        // 将本帧的根运动数据存入异步缓冲区，供物理线程后续消费
        AccumulateRootMotionForAsync(DeltaTime, AsyncRootMotion);

        // 异步模式下，移动计算在物理线程执行，此处直接返回
        return;
    }

    // ==== 同步模式（主线程执行移动）====

    // 安全检查：防止角色因物理异常掉出世界边界（仅服务器端检查）
    const bool bIsSimulatingPhysics = UpdatedComponent->IsSimulatingPhysics();
    if (CharacterOwner->GetLocalRole() == ROLE_Authority && (!bCheatFlying || bIsSimulatingPhysics) && !CharacterOwner->CheckStillInWorld())
    {
        return;
    }

    // 如果角色正在模拟物理（如 ragdoll 状态），跳过移动逻辑
    if (bIsSimulatingPhysics)
    {
        // 对于自主客户端，即使物理模拟中也需要更新摄像机位置
        if (CharacterOwner->GetLocalRole() == ROLE_AutonomousProxy && IsNetMode(NM_Client))
        {
            MarkForClientCameraUpdate();
        }

        // 清除累积的力，防止物理模拟异常
        ClearAccumulatedForces();
        return;
    }

    // 减少回避锁定计时器（用于群体避障系统）
    AvoidanceLockTimer -= DeltaTime;

    // ===== 网络角色判断与移动分发 =====
    // 根据网络角色（Authority、AutonomousProxy、SimulatedProxy）执行不同的移动逻辑

    // 1. 权威端（服务器）或自主客户端（本地控制）
    if (CharacterOwner->GetLocalRole() > ROLE_SimulatedProxy)
    {
        SCOPE_CYCLE_COUNTER(STAT_CharacterMovementNonSimulated);

        // 客户端特定逻辑：检查是否需要应用服务器校正
        const bool bIsClient = (CharacterOwner->GetLocalRole() == ROLE_AutonomousProxy && IsNetMode(NM_Client));
        if (bIsClient)
        {
            FNetworkPredictionData_Client_Character* ClientData = GetPredictionData_Client_Character();
            
            // 如果收到服务器的位置校正，先执行校正逻辑
            // 这是前端预测（Client-side Prediction）的核心：服务器校正后，客户端需要重放移动
            if (ClientData && ClientData->bUpdatePosition)
            {
                ClientUpdatePositionAfterServerUpdate();
            }
        }

        // 创建作用域锁，延迟所有 Mesh 子组件的更新，直到移动计算完成
        // 避免移动过程中 Mesh 位置抖动
        FScopedMeshMovementUpdate ScopedMeshUpdate(CharacterOwner->GetMesh());

        // 判断是否需要执行受控角色移动
        const bool bShouldPerformControlledCharMove = 
            CharacterOwner->IsLocallyControlled() ||                          // 本地控制
            (!CharacterOwner->GetController() && bRunPhysicsWithNoController) || // 无控制器但允许物理移动
            (!CharacterOwner->GetController() && CharacterOwner->IsPlayingRootMotion()); // 无控制器但正在播放根运动

        // 2.1 执行受控移动（本地控制或根运动驱动）
        if (bShouldPerformControlledCharMove)
        {
            // 核心移动函数：处理输入、物理模拟、根运动应用
            ControlledCharacterMove(InputVector, DeltaTime);

            // 如果是监听服务器上的自主代理（本地玩家在服务器上）
            const bool bIsaListenServerAutonomousProxy = 
                CharacterOwner->IsLocallyControlled() && 
                (CharacterOwner->GetRemoteRole() == ROLE_AutonomousProxy);

            if (bIsaListenServerAutonomousProxy)
            {
                // 执行服务器端的自主代理 Tick（处理客户端移动请求）
                ServerAutonomousProxyTick(DeltaTime);
            }
        }
        // 2.2 服务器处理远程客户端的自主代理
        else if (CharacterOwner->GetRemoteRole() == ROLE_AutonomousProxy)
        {
            // 服务器为远程客户端更新基于其他物体的移动（如站在移动平台上）
            MaybeUpdateBasedMovement(DeltaTime);
            MaybeSaveBaseLocation();

            // 服务器处理客户端的移动请求
            ServerAutonomousProxyTick(DeltaTime);

            // 监听服务器平滑：在监听服务器上平滑显示远程客户端的位置
            if (CharacterMovementCVars::NetEnableListenServerSmoothing && 
                !bNetworkSmoothingComplete && 
                IsNetMode(NM_ListenServer))
            {
                SmoothClientPosition(DeltaTime);
            }
        }
    }
    // 3. 模拟代理（其他客户端上的远程玩家）
    else if (CharacterOwner->GetLocalRole() == ROLE_SimulatedProxy)
    {
        // 同样延迟 Mesh 更新
        FScopedMeshMovementUpdate ScopedMeshUpdate(CharacterOwner->GetMesh());

        // 处理胶囊体大小调整（用于下蹲等状态切换时的平滑过渡）
        if (bShrinkProxyCapsule)
        {
            AdjustProxyCapsuleSize();
        }
        
        // 模拟端移动：不执行本地输入，只根据服务器同步的数据进行插值平滑
        SimulatedTick(DeltaTime);
    }

    // 群体避障系统更新
    if (bUseRVOAvoidance)
    {
        UpdateDefaultAvoidance();
    }

    // 物理交互：应用向下力和排斥力（如角色站在斜坡上的稳定力）
    if (bEnablePhysicsInteraction)
    {
        SCOPE_CYCLE_COUNTER(STAT_CharPhysicsInteraction);
        ApplyDownwardForce(DeltaTime);
        ApplyRepulsionForce(DeltaTime);
    }

// 调试可视化（仅在开发版本中启用）
#if !(UE_BUILD_SHIPPING || UE_BUILD_TEST)
    const bool bVisualizeMovement = CharacterMovementCVars::VisualizeMovement > 0;
    if (bVisualizeMovement)
    {
        VisualizeMovement();
    }
#endif // !(UE_BUILD_SHIPPING || UE_BUILD_TEST)
}
