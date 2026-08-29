void FRootMotionSourceGroup::PrepareRootMotion(float DeltaSeconds, const ACharacter* CharacterOwner)
{
	// 1. 合并 Pending 队列中的新源到 Active 列表
	// 这一步确保了所有客户端和服务器在同一帧看到相同的源集合
	for (TSharedPtr<FRootMotionSource>& Source : PendingAddRootMotionSources)
	{
		ActiveRootMotionSources.Add(Source);
	}
	PendingAddRootMotionSources.Empty();

	// 2. 遍历所有活跃源，更新状态并计算增量
	for (int32 i = ActiveRootMotionSources.Num() - 1; i >= 0; --i)
	{
		TSharedPtr<FRootMotionSource>& Source = ActiveRootMotionSources[i];

		// 2.1 检查生命周期
		float CurrentTime = CharacterOwner->GetWorld()->GetTimeSeconds();
		if (CurrentTime >= Source->StartTime + Source->Duration)
		{
			Source->Status = ERootMotionSourceStatus::Finished;
			continue; // 标记为完成，稍后清理
		}

		// 2.2 调用源的 Update 逻辑
		// 每个具体的 Source 子类（如 FRootMotionSource_ConstantForce）会在此计算本帧的速度/位移
		Source->Update(DeltaSeconds, CharacterOwner);
        
		// 2.3 累加结果到临时缓冲区
		// AccumulateMode 决定了是 Override 还是 Additive
		if (Source->AccumulateMode == ERootMotionAccumulateMode::Override)
		{
			// 覆盖模式：通常只保留优先级最高的 Override 源
			OverrideRootMotionVelocity = Source->GetTargetVelocity();
			bHasOverrideRootMotion = true;
		}
		else if (Source->AccumulateMode == ERootMotionAccumulateMode::Additive)
		{
			// 叠加模式：累加速度增量
			AdditiveRootMotionVelocity += Source->GetVelocityDelta();
		}
	}

	// 3. 清理已完成的源
	CleanUpInvalidRootMotionSources();
}
