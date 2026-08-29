uint16 UCharacterMovementComponent::ApplyRootMotionSource(TSharedPtr<FRootMotionSource> SourcePtr)
{
	// 1. 有效性检查
	if (!ensure(SourcePtr.IsValid()))
	{
		return (uint16)ERootMotionSourceID::Invalid;
	}

	// 2. 分配本地唯一 ID
	// LocalIDGenerator 是静态变量，保证每个源在当前会话中有唯一标识
	static uint16 LocalIDGenerator = 0;
	SourcePtr->LocalID = ++LocalIDGenerator;
    
	// 3. 设置初始状态
	SourcePtr->Status = ERootMotionSourceStatus::NotStarted;
	SourcePtr->StartTime = GetWorld()->GetTimeSeconds();

	// 4. 加入 Pending 队列
	// 注意：此时源并未立即参与计算，而是等待下一帧 PerformMovement 中的 Prepare 阶段合并
	PendingAddRootMotionSources.Add(SourcePtr);

	UE_LOG(LogCharacterMovement, Verbose, TEXT("Applied RootMotionSource ID: %d, Name: %s"), 
		   SourcePtr->LocalID, *SourcePtr->InstanceName.ToString());

	return SourcePtr->LocalID;
}
