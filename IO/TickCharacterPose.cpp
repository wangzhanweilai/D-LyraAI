
void UCharacterMovementComponent::TickCharacterPose(float DeltaTime)
{
	// 1. 获取角色的网格体组件
	USkeletalMeshComponent* CharacterMesh = CharacterOwner ? CharacterOwner->GetMesh() : nullptr;
	if (!CharacterMesh)
	{
		return;
	}

	// 2. 设置自动 Tick 标志
	// bIsAutonomousTickPose 为 true 时，Mesh 组件会跳过其自身的 Tick 逻辑，
	// 由移动组件完全控制动画更新时机，确保动画与物理模拟同步。
	CharacterMesh->bIsAutonomousTickPose = true;

	// 3. 判断是否需要执行 Pose Tick
	// ShouldTickPose 会根据可见性、网络角色类型等条件判断是否真的需要更新动画
	if (CharacterMesh->ShouldTickPose())
	{
		// 记录当前是否正在播放根运动动画，用于后续状态判断
		const bool bWasPlayingRootMotion = CharacterOwner->IsPlayingRootMotion();

		// 4. 执行动画姿态更新
		// 传入 DeltaTime 和 bFireEvents=true，触发动画通知（AnimNotifies）
		CharacterMesh->TickPose(DeltaTime, true);

		// 5. 提取根运动数据
		// 如果当前帧正在播放根运动，或者上一帧在播放但本帧刚结束（需要消耗最后一帧数据）
		if (CharacterOwner->IsPlayingRootMotion() || bWasPlayingRootMotion)
		{
			// ConsumeRootMotion 从 Mesh 中提取并清空 ExtractedRootMotion
			// 返回的是局部空间（Local Space）的位移和旋转
			FRootMotionMovementParams RootMotion = CharacterMesh->ConsumeRootMotion();

			// 6. 处理提取到的根运动数据
			if (RootMotion.bHasRootMotion)
			{
				// A. 缩放调整
				// 根据 Character 的 AnimRootMotionTranslationScale 属性对位移进行缩放
				// 这允许设计师在不修改动画资源的情况下调整位移距离
				RootMotion.ScaleRootMotionTranslation(CharacterOwner->GetAnimRootMotionTranslationScale());

				// B. 累加到移动组件
				// 将处理后的局部根运动数据累加到 CMC 的 RootMotionParams 成员变量中
				// RootMotionParams 将在后续的 PerformMovement 中被转换为世界坐标并应用
				RootMotionParams.Accumulate(RootMotion);
			}
		}
	}

	// 7. 恢复默认标志
	// 重置 bIsAutonomousTickPose，允许 Mesh 组件在其他情况下正常管理自己的 Tick
	CharacterMesh->bIsAutonomousTickPose = false;
}
