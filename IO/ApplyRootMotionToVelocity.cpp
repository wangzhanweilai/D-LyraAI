void UCharacterMovementComponent::ApplyRootMotionToVelocity(float DeltaSeconds)
{
	// 1. 获取当前基础速度（来自输入、重力等）
	FVector CurrentVelocity = Velocity;

	// 2. 处理覆盖型根运动 (Override)
	// 如果存在 Override 源，它将完全接管水平移动控制权
	if (CurrentRootMotion.bHasOverrideRootMotion)
	{
		// 注意：通常只覆盖 XY 平面，保留 Z 轴以维持重力交互，除非源指定了 Z 轴覆盖
		FVector NewVelocity = CurrentRootMotion.OverrideRootMotionVelocity;
        
		// 特殊处理：如果在空中，可能需要混合 Z 轴速度以防止穿地或浮空
		if (MovementMode == MOVE_Falling)
		{
			NewVelocity.Z = CurrentVelocity.Z; 
		}
        
		Velocity = NewVelocity;
        
		UE_LOG(LogCharacterMovement, VeryVerbose, TEXT("RootMotion Override Velocity: %s"), *Velocity.ToString());
	}
	// 3. 处理叠加型根运动 (Additive)
	else if (!CurrentRootMotion.AdditiveRootMotionVelocity.IsZero())
	{
		// 将根运动产生的速度增量叠加到当前速度上
		Velocity += CurrentRootMotion.AdditiveRootMotionVelocity;
        
		UE_LOG(LogCharacterMovement, VeryVerbose, TEXT("RootMotion Additive Velocity: %s"), *Velocity.ToString());
	}

	// 4. 限制最大速度 (可选)
	// 防止根运动导致速度超出物理引擎合理范围
	if (MaxWalkSpeed > 0.f && MovementMode == MOVE_Walking)
	{
		Velocity = Velocity.GetClampedToMaxSize(MaxWalkSpeed);
	}
}
