// 客户端：打包移动数据时包含根运动信息
void UCharacterMovementComponent::ReplicateMoveToServer(FNetworkPredictionData_Client_Character* ClientData)
{
	// ... 其他移动数据打包 ...

	// 1. 检查是否有活跃的根运动源
	if (CurrentRootMotion.HasActiveRootMotionSources())
	{
		// 2. 将当前的 RootMotion 快照保存到 SavedMoves
		// 这样当服务器确认移动时，客户端可以重放相同的根运动逻辑
		FSavedMove_Character* NewMove = ClientData->PendingMove;
		if (NewMove)
		{
			NewMove->RootMotionSourceGroup = CurrentRootMotion;
			NewMove->bHasRootMotionSources = true;
		}
	}
}

// 服务器：处理客户端移动请求
bool UCharacterMovementComponent::ServerMove_HandleMoveData(
	const FCharacterNetworkMoveData& MoveData, 
	const FVector& InAccel, 
	float TimeStamp)
{
	// ... 基础位置校验 ...

	// 1. 如果客户端声明有根运动源
	if (MoveData.bHasRootMotionSources)
	{
		// 2. 服务器重放客户端的根运动源
		// 注意：服务器必须拥有相同的 Source 定义和参数，否则计算结果会不一致
		CurrentRootMotion = MoveData.RootMotionSourceGroup;
        
		// 3. 标记忽略本地的根运动生成逻辑，直接使用客户端同步过来的数据
		// 防止服务器自己生成一套不同的根运动导致冲突
		bServerMoveIgnoreRootMotionGeneration = true;
	}
    
	// 4. 执行服务器的物理移动
	PerformMovement(TimeStamp - ServerLastUpdateTime);
    
	return true;
}
