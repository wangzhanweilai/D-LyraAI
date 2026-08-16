<mxfile host="Electron" agent="Codex">
  <diagram id="player-sync" name="玩家同步 UML">
    <mxGraphModel dx="2934" dy="1716" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" parent="1" style="text;html=1;fontSize=28;fontStyle=1;align=center;verticalAlign=middle;" value="Player Synchronization - Method-Level UML Class Diagram" vertex="1">
          <mxGeometry height="45" width="900" x="810" y="30" as="geometry" />
        </mxCell>
        <mxCell id="legend" parent="1" style="text;html=1;fontSize=14;align=center;verticalAlign=middle;fontColor=#666666;" value="Dashed: server protocol notification | Solid: direct call | Red method: synchronization entry point" vertex="1">
          <mxGeometry height="28" width="1140" x="690" y="75" as="geometry" />
        </mxCell>
        <mxCell id="server" parent="1" style="ellipse;whiteSpace=wrap;html=1;fillColor=#ffe6cc;strokeColor=#d79b00;fontSize=16;" value="&lt;b&gt;Game Server&lt;/b&gt;&lt;br&gt;PLAYER / MAP / WEBGROUP / MOVE" vertex="1">
          <mxGeometry height="100" width="200" x="30" y="450" as="geometry" />
        </mxCell>
        <mxCell id="dispatcher" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="WNetDispatcher &lt;font color=&quot;#ff0000&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="164" width="300" x="330" y="360" as="geometry" />
        </mxCell>
        <mxCell id="dispatcher-f" parent="dispatcher" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;spacingRight=4;whiteSpace=wrap;html=1;" value="+ HandlerMap: service x proto to callback" vertex="1">
          <mxGeometry height="26" width="300" y="26" as="geometry" />
        </mxCell>
        <mxCell id="dispatcher-line" parent="dispatcher" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="300" y="52" as="geometry" />
        </mxCell>
        <mxCell id="dispatcher-register" parent="dispatcher" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Register(service, proto, handler): void" vertex="1">
          <mxGeometry height="26" width="300" y="60" as="geometry" />
        </mxCell>
        <mxCell id="dispatcher-send" parent="dispatcher" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Send(service, proto, payload): result" vertex="1">
          <mxGeometry height="26" width="300" y="86" as="geometry" />
        </mxCell>
        <mxCell id="dispatcher-dispatch" parent="dispatcher" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Dispatch(service, proto, Resp): void" vertex="1">
          <mxGeometry height="26" width="300" y="112" as="geometry" />
        </mxCell>
        <mxCell id="role-net" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="WRoleMgrNet &lt;font color=&quot;#ff0000&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="216" width="390" x="780" y="150" as="geometry" />
        </mxCell>
        <mxCell id="role-net-f" parent="role-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ EnterPlayScene: WEnterPlayScene" vertex="1">
          <mxGeometry height="26" width="390" y="26" as="geometry" />
        </mxCell>
        <mxCell id="role-net-line" parent="role-net" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="390" y="52" as="geometry" />
        </mxCell>
        <mxCell id="role-net-self" parent="role-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnMapEnterGameResp(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[self sync]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="390" y="60" as="geometry" />
        </mxCell>
        <mxCell id="role-net-enter" parent="role-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnWebgroupOnObjectEnterNotify(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[AOI enter]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="390" y="86" as="geometry" />
        </mxCell>
        <mxCell id="role-net-leave" parent="role-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnWebgroupOnObjectLeaveNotify(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[AOI leave]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="390" y="112" as="geometry" />
        </mxCell>
        <mxCell id="role-net-batch" parent="role-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnWebgroupOnBatchObjectEnterNotify(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[first screen]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="390" y="138" as="geometry" />
        </mxCell>
        <mxCell id="enter-scene" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="WEnterPlayScene &lt;font color=&quot;#ff0000&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="294" width="390" x="1320" y="110" as="geometry" />
        </mxCell>
        <mxCell id="enter-f" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- IsPlaySceneLoadComplete: bool&lt;br&gt;- IsSelfDataSyncComplete: bool&lt;br&gt;- IsOtherDataSyncComplete: bool" vertex="1">
          <mxGeometry height="52" width="390" y="26" as="geometry" />
        </mxCell>
        <mxCell id="enter-line" parent="enter-scene" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="390" y="78" as="geometry" />
        </mxCell>
        <mxCell id="enter-begin" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ BeginPlay(World): void" vertex="1">
          <mxGeometry height="26" width="390" y="86" as="geometry" />
        </mxCell>
        <mxCell id="enter-self" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SelfDataSyncComplete(Resp): void" vertex="1">
          <mxGeometry height="26" width="390" y="112" as="geometry" />
        </mxCell>
        <mxCell id="enter-other" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OtherDataSyncComplete(Resp): void" vertex="1">
          <mxGeometry height="26" width="390" y="138" as="geometry" />
        </mxCell>
        <mxCell id="enter-aoi" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ObjectEnterAoi(Resp) / ObjectLeaveAoi(Resp): void" vertex="1">
          <mxGeometry height="26" width="390" y="164" as="geometry" />
        </mxCell>
        <mxCell id="enter-create" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ CreateChara(Object, RoleType): void" vertex="1">
          <mxGeometry height="26" width="390" y="190" as="geometry" />
        </mxCell>
        <mxCell id="enter-ready" parent="enter-scene" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ NotifyComplete(): void &lt;font color=&quot;#ff0000&quot;&gt;[all 3 gates ready]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="390" y="216" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UWRoleManagerSubSys &lt;font color=&quot;#008000&quot;&gt;C++ WorldSubsystem&lt;/font&gt;" vertex="1">
          <mxGeometry height="268" width="390" x="1900" y="160" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-f" parent="role-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- RoleBaseObj: roleId to AWCharacter&lt;br&gt;- NetIdMapping: netId to roleId" vertex="1">
          <mxGeometry height="52" width="390" y="26" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-line" parent="role-mgr" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="390" y="78" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-create" parent="role-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ CreateCharacter(FWSpawnCharaInfo): AWCharacter" vertex="1">
          <mxGeometry height="26" width="390" y="86" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-remove" parent="role-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ RemoveCharacter(roleId, RoleType): void" vertex="1">
          <mxGeometry height="26" width="390" y="112" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-get" parent="role-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ GetCharacter(roleId): AWCharacter" vertex="1">
          <mxGeometry height="26" width="390" y="138" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-map" parent="role-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ AddNetIdMapping(netId, roleId): void" vertex="1">
          <mxGeometry height="26" width="390" y="164" as="geometry" />
        </mxCell>
        <mxCell id="role-mgr-ready" parent="role-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ExePrepareCompleteEvent(): void" vertex="1">
          <mxGeometry height="26" width="390" y="190" as="geometry" />
        </mxCell>
        <mxCell id="move-net" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="WRoleMoveNet &lt;font color=&quot;#ff0000&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="164" width="370" x="780" y="620" as="geometry" />
        </mxCell>
        <mxCell id="move-net-f" parent="move-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- UEContextObj: UObject" vertex="1">
          <mxGeometry height="26" width="370" y="26" as="geometry" />
        </mxCell>
        <mxCell id="move-net-line" parent="move-net" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="370" y="52" as="geometry" />
        </mxCell>
        <mxCell id="move-send" parent="move-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnSendMoveReq(MoveInfo): result" vertex="1">
          <mxGeometry height="26" width="370" y="60" as="geometry" />
        </mxCell>
        <mxCell id="move-sync" parent="move-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnMoveMoveSyncNotify(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[MOVE_SYNC_NOTIFY]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="370" y="86" as="geometry" />
        </mxCell>
        <mxCell id="move-register" parent="move-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ToClientFuncRegister(): void" vertex="1">
          <mxGeometry height="26" width="370" y="112" as="geometry" />
        </mxCell>
        <mxCell id="move-comp" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXMoveNetSyncComponent &lt;font color=&quot;#008000&quot;&gt;C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="138" width="390" x="1370" y="650" as="geometry" />
        </mxCell>
        <mxCell id="move-comp-f" parent="move-comp" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- OwnerCharacter: AWCharacter" vertex="1">
          <mxGeometry height="26" width="390" y="26" as="geometry" />
        </mxCell>
        <mxCell id="move-comp-line" parent="move-comp" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="390" y="52" as="geometry" />
        </mxCell>
        <mxCell id="move-apply" parent="move-comp" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ApplyServerMovementData(FWMoveInfo): void" vertex="1">
          <mxGeometry height="26" width="390" y="60" as="geometry" />
        </mxCell>
        <mxCell id="camera-net" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="PXCameraNet &lt;font color=&quot;#ff0000&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="190" width="410" x="780" y="940" as="geometry" />
        </mxCell>
        <mxCell id="camera-net-f" parent="camera-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- UEContextObj: UObject" vertex="1">
          <mxGeometry height="26" width="410" y="26" as="geometry" />
        </mxCell>
        <mxCell id="camera-net-line" parent="camera-net" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="410" y="52" as="geometry" />
        </mxCell>
        <mxCell id="camera-send" parent="camera-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnSendCameraReq(roleId, SendInfo): result" vertex="1">
          <mxGeometry height="26" width="410" y="60" as="geometry" />
        </mxCell>
        <mxCell id="camera-resolve" parent="camera-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ResolveCameraHandle(context, roleId): FPXCameraHandle" vertex="1">
          <mxGeometry height="26" width="410" y="86" as="geometry" />
        </mxCell>
        <mxCell id="camera-sync" parent="camera-net" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnMoveCameraSyncInfoNotify(Notify): void &lt;font color=&quot;#ff0000&quot;&gt;[CAMERA_SYNC_INFO_NOTIFY]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="410" y="112" as="geometry" />
        </mxCell>
        <mxCell id="camera-mgr" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXCameraNetManager &lt;font color=&quot;#008000&quot;&gt;C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="164" width="390" x="1370" y="960" as="geometry" />
        </mxCell>
        <mxCell id="camera-mgr-f" parent="camera-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- ReplicateStrategyClasses: TArray&lt;Class&gt;" vertex="1">
          <mxGeometry height="26" width="390" y="26" as="geometry" />
        </mxCell>
        <mxCell id="camera-mgr-line" parent="camera-mgr" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="390" y="52" as="geometry" />
        </mxCell>
        <mxCell id="camera-pool" parent="camera-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ GetCameraComponentPool(): UPXCameraComponentPool" vertex="1">
          <mxGeometry height="26" width="390" y="60" as="geometry" />
        </mxCell>
        <mxCell id="camera-recv" parent="camera-mgr" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ReceiveFromServer(handle, info): void" vertex="1">
          <mxGeometry height="26" width="390" y="86" as="geometry" />
        </mxCell>
        <mxCell id="health" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="PXHealthComponent &lt;font color=&quot;#ff0000&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="216" width="410" x="1900" y="650" as="geometry" />
        </mxCell>
        <mxCell id="health-f" parent="health" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- Owner: AWCharacter" vertex="1">
          <mxGeometry height="26" width="410" y="26" as="geometry" />
        </mxCell>
        <mxCell id="health-line" parent="health" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="410" y="52" as="geometry" />
        </mxCell>
        <mxCell id="health-init" parent="health" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Init() / ReceiveEndPlay(): void" vertex="1">
          <mxGeometry height="26" width="410" y="60" as="geometry" />
        </mxCell>
        <mxCell id="health-attr" parent="health" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ RespAttributeChange(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[CHANGE_ATTRIBUTE_NOTIFY]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="410" y="86" as="geometry" />
        </mxCell>
        <mxCell id="health-level" parent="health" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ RespLevelChange(Resp): void &lt;font color=&quot;#ff0000&quot;&gt;[LEVEL_UP_NOTIFY]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="410" y="112" as="geometry" />
        </mxCell>
        <mxCell id="health-logic" parent="health" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ApplyLogicAttributeBatch(values, time): bool" vertex="1">
          <mxGeometry height="26" width="410" y="138" as="geometry" />
        </mxCell>
        <mxCell id="logic" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXLogicBattleSystem &lt;font color=&quot;#008000&quot;&gt;C++ WorldSubsystem&lt;/font&gt;" vertex="1">
          <mxGeometry height="190" width="410" x="1900" y="1000" as="geometry" />
        </mxCell>
        <mxCell id="logic-f" parent="logic" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- UnitSnapshots: unitId to attributes" vertex="1">
          <mxGeometry height="26" width="410" y="26" as="geometry" />
        </mxCell>
        <mxCell id="logic-line" parent="logic" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="410" y="52" as="geometry" />
        </mxCell>
        <mxCell id="logic-ensure" parent="logic" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ EnsurePlayerByID(unitId, roleId): bool" vertex="1">
          <mxGeometry height="26" width="410" y="60" as="geometry" />
        </mxCell>
        <mxCell id="logic-begin" parent="logic" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ BeginCharacterSnapshotUpdate(unitId): bool" vertex="1">
          <mxGeometry height="26" width="410" y="86" as="geometry" />
        </mxCell>
        <mxCell id="logic-apply" parent="logic" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ApplyCharacterAttributeByName(...): bool" vertex="1">
          <mxGeometry height="26" width="410" y="112" as="geometry" />
        </mxCell>
        <mxCell id="e-server" edge="1" parent="1" source="server" style="endArrow=block;dashed=1;endFill=0;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="dispatcher-dispatch" value="MAP / WEBGROUP / PLAYER / MOVE protocol">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-reg-role" edge="1" parent="1" source="dispatcher-register" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="role-net-self" value="Register(MAP, WEBGROUP)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-reg-move" edge="1" parent="1" source="dispatcher-register" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="move-register" value="Register(MOVE_SYNC_NOTIFY)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-role-self" edge="1" parent="1" source="role-net-self" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="enter-self" value="SelfDataSyncComplete(Resp)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-role-enter" edge="1" parent="1" source="role-net-enter" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="enter-aoi" value="ObjectEnterAoi(Resp)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-role-leave" edge="1" parent="1" source="role-net-leave" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="enter-aoi" value="ObjectLeaveAoi(Resp)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-role-batch" edge="1" parent="1" source="role-net-batch" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="enter-other" value="OtherDataSyncComplete(Resp)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-enter-create" edge="1" parent="1" source="enter-create" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="role-mgr-create" value="CreateCharacter / AddNetIdMapping">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-enter-aoi" edge="1" parent="1" source="enter-aoi" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="role-mgr-remove" value="RemoveCharacter">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-enter-ready" edge="1" parent="1" source="enter-ready" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="role-mgr-ready" value="ExePrepareCompleteEvent">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-move-apply" edge="1" parent="1" source="move-sync" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="move-apply" value="Resp to FWMoveInfo to ApplyServerMovementData">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-camera-role" edge="1" parent="1" source="camera-resolve" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="role-mgr-get" value="GetCharacter(roleId)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1210" y="910" />
              <mxPoint x="1820" y="910" />
              <mxPoint x="1820" y="470" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e-camera-recv" edge="1" parent="1" source="camera-sync" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="camera-recv" value="FPXCameraReceiveInfo">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-health-logic" edge="1" parent="1" source="health-logic" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="logic-apply" value="authoritative attribute snapshot">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-health-register" edge="1" parent="1" source="dispatcher-register" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="health-init" value="Register PLAYER / COMBAT callbacks">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="680" y="325" />
              <mxPoint x="1850" y="325" />
              <mxPoint x="1850" y="730" />
            </Array>
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
