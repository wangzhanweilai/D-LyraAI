<mxfile host="Electron" agent="Codex" pages="2">
  <diagram id="px-character-movement" name="玩家移动详情 UML">
    <mxGraphModel dx="3243" dy="1413" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" parent="1" style="text;html=1;fontSize=28;fontStyle=1;align=center;verticalAlign=middle;" value="Custom Player Movement - UPXCharacterMovementComponent Detail UML" vertex="1">
          <mxGeometry height="45" width="1000" x="850" y="30" as="geometry" />
        </mxCell>
        <mxCell id="legend" parent="1" style="text;html=1;fontSize=14;align=center;verticalAlign=middle;fontColor=#666666;" value="蓝色：服务器交互、上传、接收与客户端纠正 | 实线：调用 | 虚线：事件 | 前缀 + 编号：同一执行路径内的直接调用顺序" vertex="1">
          <mxGeometry height="28" width="1400" x="650" y="75" as="geometry" />
        </mxCell>
        <mxCell id="call-number-notes" parent="1" style="shape=note;whiteSpace=wrap;html=1;backgroundOutline=1;fillColor=#f5f5f5;strokeColor=#666666;fontSize=13;align=left;verticalAlign=top;spacingTop=6;spacingLeft=8;" value="&lt;b&gt;调用编号说明&lt;/b&gt;&lt;br&gt;&lt;b&gt;前缀&lt;/b&gt;表示独立执行路径；数字表示该路径中的直接调用顺序。&lt;br&gt;R = 跑步 | G = 地面查询 | J = 跳跃 / 下落 | M = 移动 Tag 门控 | H = 角色转向 | N = 移动网络同步。&lt;br&gt;&lt;br&gt;&lt;b&gt;N1-N8&lt;/b&gt;：采样变化状态 → C++ 蓝图事件 → Lua 构造请求 → 分发器发送 → 上传服务器 → 收到同步通知 → 路由到 Lua 处理函数 → 查找组件并纠正/应用移动状态。&lt;br&gt;&lt;br&gt;&lt;b&gt;实例化说明&lt;/b&gt;：&lt;i&gt;BP_MovementCompnent&lt;/i&gt; 是 &lt;i&gt;UPXMoveNetSyncComponent&lt;/i&gt; 的蓝图子类。它配置在具体角色蓝图的组件列表中；角色 Actor 生成时由 Unreal 创建实例。C++ 仅通过 &lt;i&gt;GetComponentByClass&lt;/i&gt; 获取已有组件。" vertex="1">
          <mxGeometry height="215" width="760" x="1780" y="110" as="geometry" />
        </mxCell>
        <mxCell id="ue-cmc" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#f5f5f5;strokeColor=#666666;" value="UCharacterMovementComponent &lt;font color=&quot;#666666&quot;&gt;Unreal Engine base (external)&lt;/font&gt;" vertex="1">
          <mxGeometry height="138" width="410" x="2070" y="1580" as="geometry" />
        </mxCell>
        <mxCell id="ue-cmc-f" parent="ue-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Acceleration / Velocity / GravityScale&lt;br&gt;+ MaxWalkSpeed / RotationRate&lt;br&gt;+ MovementMode / CurrentFloor" vertex="1">
          <mxGeometry height="52" width="410" y="26" as="geometry" />
        </mxCell>
        <mxCell id="ue-cmc-line" parent="ue-cmc" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="410" y="78" as="geometry" />
        </mxCell>
        <mxCell id="ue-cmc-methods" parent="ue-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SimulateMovement() / GetMaxSpeed() / DoJump()&lt;br&gt;+ PhysFalling() / OnMovementModeChanged()" vertex="1">
          <mxGeometry height="52" width="410" y="86" as="geometry" />
        </mxCell>
        <mxCell id="px-cmc" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXCharacterMovementComponent &lt;font color=&quot;#008000&quot;&gt;PXGameCore C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="346" width="560" x="1990" y="1850" as="geometry" />
        </mxCell>
        <mxCell id="px-cmc-f" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- CachedGroundInfo: FPXCharacterGroundInfo&lt;br&gt;- bHasReplicatedAcceleration: bool&lt;br&gt;- RunningSpeed / CrouchedRunningSpeed&lt;br&gt;- bIsRunning / JumpMapLocationZ&lt;br&gt;+ OnFallInGround(FallDistance): delegate" vertex="1">
          <mxGeometry height="104" width="560" y="26" as="geometry" />
        </mxCell>
        <mxCell id="px-cmc-line" parent="px-cmc" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="560" y="130" as="geometry" />
        </mxCell>
        <mxCell id="px-sim" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SimulateMovement(DeltaTime): preserve replicated acceleration" vertex="1">
          <mxGeometry height="26" width="560" y="138" as="geometry" />
        </mxCell>
        <mxCell id="px-ground" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ GetGroundInfo(): FPXCharacterGroundInfo &lt;font color=&quot;#ff0000&quot;&gt;[async ground trace cache]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="560" y="164" as="geometry" />
        </mxCell>
        <mxCell id="px-speed" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ GetMaxSpeed(): float &lt;font color=&quot;#ff0000&quot;&gt;[MovementStopped gate]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="560" y="190" as="geometry" />
        </mxCell>
        <mxCell id="px-rotation" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ GetDeltaRotation(DeltaTime): FRotator &lt;font color=&quot;#ff0000&quot;&gt;[MovementStopped gate]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="560" y="216" as="geometry" />
        </mxCell>
        <mxCell id="px-run" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ToggleRun(): bool &lt;font color=&quot;#ff0000&quot;&gt;[speed + Status.Running]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="560" y="242" as="geometry" />
        </mxCell>
        <mxCell id="px-jump" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ DoJump(...): bool &lt;font color=&quot;#ff0000&quot;&gt;[capture jump Z]&lt;/font&gt;" vertex="1">
          <mxGeometry height="26" width="560" y="268" as="geometry" />
        </mxCell>
        <mxCell id="px-fall" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ PhysFalling(...): update FallDistance" vertex="1">
          <mxGeometry height="26" width="560" y="294" as="geometry" />
        </mxCell>
        <mxCell id="px-land" parent="px-cmc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnMovementModeChanged(...): broadcast landing fall distance" vertex="1">
          <mxGeometry height="26" width="560" y="320" as="geometry" />
        </mxCell>
        <mxCell id="cmc-base" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXCMCBase &lt;font color=&quot;#008000&quot;&gt;PXCharacter C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="216" width="530" x="2009" y="2494" as="geometry" />
        </mxCell>
        <mxCell id="cmc-base-f" parent="cmc-base" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- MaxWalkSpeedModifiers: minimum aggregation&lt;br&gt;- RotationRateModifiers: component maximum aggregation&lt;br&gt;- GravityScaleModifiers: minimum aggregation" vertex="1">
          <mxGeometry height="52" width="530" y="26" as="geometry" />
        </mxCell>
        <mxCell id="cmc-base-line" parent="cmc-base" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="530" y="78" as="geometry" />
        </mxCell>
        <mxCell id="base-register" parent="cmc-base" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnRegister() / OnUnregister(): initialize modifiers and rotation delegate" vertex="1">
          <mxGeometry height="26" width="530" y="86" as="geometry" />
        </mxCell>
        <mxCell id="base-speed" parent="cmc-base" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Add/RemoveMaxWalkSpeedModifier(Mode, Speed)" vertex="1">
          <mxGeometry height="26" width="530" y="112" as="geometry" />
        </mxCell>
        <mxCell id="base-rotation" parent="cmc-base" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Add/RemoveRotationRateModifier(Mode, Rate, AutoRemove)" vertex="1">
          <mxGeometry height="26" width="530" y="138" as="geometry" />
        </mxCell>
        <mxCell id="base-gravity" parent="cmc-base" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Add/RemoveGravityScaleModifier(Mode, Scale)" vertex="1">
          <mxGeometry height="26" width="530" y="164" as="geometry" />
        </mxCell>
        <mxCell id="base-rotation-finished" parent="cmc-base" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ HandleCharacterRotationFinished(RotationInfo): remove auto modifiers" vertex="1">
          <mxGeometry height="26" width="530" y="190" as="geometry" />
        </mxCell>
        <mxCell id="cmc-player" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXCMC_Player &lt;font color=&quot;#008000&quot;&gt;PXCharacter C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="138" width="470" x="2040" y="3060" as="geometry" />
        </mxCell>
        <mxCell id="cmc-player-f" parent="cmc-player" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- Owner: player character only" vertex="1">
          <mxGeometry height="26" width="470" y="26" as="geometry" />
        </mxCell>
        <mxCell id="cmc-player-line" parent="cmc-player" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="470" y="52" as="geometry" />
        </mxCell>
        <mxCell id="player-register" parent="cmc-player" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnRegister() / OnUnregister(): bind jump event" vertex="1">
          <mxGeometry height="26" width="470" y="60" as="geometry" />
        </mxCell>
        <mxCell id="player-jump-event" parent="cmc-player" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ HandleOnJumpEvent(JumpAbility, bUp, bEnd): Jump gravity modifier" vertex="1">
          <mxGeometry height="26" width="470" y="86" as="geometry" />
        </mxCell>
        <mxCell id="player-landing" parent="cmc-player" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="  bEnd: remove Jump modifier and clear Velocity" vertex="1">
          <mxGeometry height="26" width="470" y="112" as="geometry" />
        </mxCell>
        <mxCell id="character" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="APXCharacter &lt;font color=&quot;#008000&quot;&gt;PXGameCore C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="242" width="540" x="260" y="1820" as="geometry" />
        </mxCell>
        <mxCell id="character-f" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ CharacterMovement: UPXCharacterMovementComponent&lt;br&gt;+ AbilitySystem: UPXAbilitySystemComponent&lt;br&gt;+ MovementModeChangedDelegate" vertex="1">
          <mxGeometry height="52" width="540" y="26" as="geometry" />
        </mxCell>
        <mxCell id="character-line" parent="character" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="540" y="78" as="geometry" />
        </mxCell>
        <mxCell id="character-init" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Constructor(): install UPXCharacterMovementComponent" vertex="1">
          <mxGeometry height="26" width="540" y="86" as="geometry" />
        </mxCell>
        <mxCell id="character-mode" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnMovementModeChanged(): set ability movement-mode tags" vertex="1">
          <mxGeometry height="26" width="540" y="112" as="geometry" />
        </mxCell>
        <mxCell id="character-crouch" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ToggleCrouch(): Crouch / UnCrouch on ground" vertex="1">
          <mxGeometry height="26" width="540" y="138" as="geometry" />
        </mxCell>
        <mxCell id="character-run" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ ToggleRunning() / StopRunning(): ToggleRun" vertex="1">
          <mxGeometry height="26" width="540" y="164" as="geometry" />
        </mxCell>
        <mxCell id="character-jump" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Jump() / StopJumping(): character jump control" vertex="1">
          <mxGeometry height="26" width="540" y="190" as="geometry" />
        </mxCell>
        <mxCell id="character-tags" parent="character" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SetMovementModeTag(mode, custom, enabled): loose tag count" vertex="1">
          <mxGeometry height="26" width="540" y="216" as="geometry" />
        </mxCell>
        <mxCell id="jump-ga" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXGameplayAbility_Jump &lt;font color=&quot;#008000&quot;&gt;PXGameCore C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="190" width="530" x="-430" y="1350" as="geometry" />
        </mxCell>
        <mxCell id="jump-ga-f" parent="jump-ga" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnJumpEvent(JumpAbility, bUp, bEnd): static delegate&lt;br&gt;- OriginalGravityScale / timers / ability tasks" vertex="1">
          <mxGeometry height="52" width="530" y="26" as="geometry" />
        </mxCell>
        <mxCell id="jump-ga-line" parent="jump-ga" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="530" y="78" as="geometry" />
        </mxCell>
        <mxCell id="jump-can" parent="jump-ga" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ CanActivateAbility(): APXCharacter.CanJump and base validation" vertex="1">
          <mxGeometry height="26" width="530" y="86" as="geometry" />
        </mxCell>
        <mxCell id="jump-start" parent="jump-ga" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ CharacterJumpStart(): bind mode event, schedule checks, Character.Jump" vertex="1">
          <mxGeometry height="26" width="530" y="112" as="geometry" />
        </mxCell>
        <mxCell id="jump-tick" parent="jump-ga" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnJumpFallNextTick(): broadcast ascent or descent gravity event" vertex="1">
          <mxGeometry height="26" width="530" y="138" as="geometry" />
        </mxCell>
        <mxCell id="jump-land" parent="jump-ga" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnMovementModeChanged_JumpFall(): broadcast end and EndAbility" vertex="1">
          <mxGeometry height="26" width="530" y="164" as="geometry" />
        </mxCell>
        <mxCell id="anim" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;" value="UPXAnimInstance &lt;font color=&quot;#008000&quot;&gt;PXGameCore C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="86" width="490" x="1040" y="1190" as="geometry" />
        </mxCell>
        <mxCell id="anim-f" parent="anim" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- GroundDistance / FallDistance: float" vertex="1">
          <mxGeometry height="26" width="490" y="26" as="geometry" />
        </mxCell>
        <mxCell id="anim-line" parent="anim" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="490" y="52" as="geometry" />
        </mxCell>
        <mxCell id="anim-update" parent="anim" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ NativeUpdateAnimation(): GetGroundInfo and copy distances" vertex="1">
          <mxGeometry height="26" width="490" y="60" as="geometry" />
        </mxCell>
        <mxCell id="asc" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" value="UPXAbilitySystemComponent &lt;font color=&quot;#008000&quot;&gt;external collaborator&lt;/font&gt;" vertex="1">
          <mxGeometry height="112" width="490" x="1420" y="462" as="geometry" />
        </mxCell>
        <mxCell id="asc-f" parent="asc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="Gameplay_MovementStopped&lt;br&gt;Gameplay_RunningStopped&lt;br&gt;Status_Running / movement mode tags" vertex="1">
          <mxGeometry height="52" width="490" y="26" as="geometry" />
        </mxCell>
        <mxCell id="asc-line" parent="asc" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="490" y="78" as="geometry" />
        </mxCell>
        <mxCell id="asc-tags" parent="asc" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ HasMatchingGameplayTag() / SetLooseGameplayTagCount()" vertex="1">
          <mxGeometry height="26" width="490" y="86" as="geometry" />
        </mxCell>
        <mxCell id="hero" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" value="UPXHeroComponent &lt;font color=&quot;#008000&quot;&gt;external collaborator&lt;/font&gt;" vertex="1">
          <mxGeometry height="86" width="500" x="-610" y="2230" as="geometry" />
        </mxCell>
        <mxCell id="hero-f" parent="hero" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ OnCharacterRotateStateChanged: delegate" vertex="1">
          <mxGeometry height="26" width="500" y="26" as="geometry" />
        </mxCell>
        <mxCell id="hero-line" parent="hero" style="line;strokeWidth=1;fillColor=none;" value="" vertex="1">
          <mxGeometry height="8" width="500" y="52" as="geometry" />
        </mxCell>
        <mxCell id="hero-rotate" parent="hero" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SetCharacterRotation(...) / broadcast rotation state" vertex="1">
          <mxGeometry height="26" width="500" y="60" as="geometry" />
        </mxCell>
        <mxCell id="e-inherit-1" edge="1" parent="1" source="px-cmc" style="endArrow=block;endFill=0;endSize=16;html=1;rounded=0;" target="ue-cmc" value="extends">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-inherit-2" edge="1" parent="1" source="cmc-base" style="endArrow=block;endFill=0;endSize=16;html=1;rounded=0;exitX=0.5;exitY=0;exitDx=0;exitDy=0;" target="px-cmc" value="extends">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-inherit-3" edge="1" parent="1" source="cmc-player" style="endArrow=block;endFill=0;endSize=16;html=1;rounded=0;" target="cmc-base" value="extends">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-character-cmc" edge="1" parent="1" source="character-init" style="endArrow=diamond;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;" target="px-cmc" value="installs / owns">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-character-run" edge="1" parent="1" source="character-run" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;" target="px-run" value="R1: ToggleRun()">
          <mxGeometry relative="1" x="0.2097" y="3" as="geometry">
            <mxPoint x="1" as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="e-run-status" edge="1" parent="1" source="px-run" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="asc-tags" value="R2: guard tags and set Status.Running">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="2830" y="2105.09" />
              <mxPoint x="2830" y="882" />
              <mxPoint x="1300" y="882" />
              <mxPoint x="1300" y="561.09" />
            </Array>
            <mxPoint x="2280" y="640" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="e-character-tag" edge="1" parent="1" source="character-tags" style="endArrow=block;endFill=1;html=1;edgeStyle=isometricEdgeStyle;rounded=0;entryX=0;entryY=0.75;entryDx=0;entryDy=0;exitX=1;exitY=0.25;exitDx=0;exitDy=0;" target="asc-tags" value="M3: set movement mode tag">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-cmc-tag-gate" edge="1" parent="1" source="px-speed" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;entryX=0;entryY=0;entryDx=0;entryDy=0;" target="asc-tags" value="M1: GetMaxSpeed checks tags">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-cmc-rotation-gate" edge="1" parent="1" source="px-rotation" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;entryX=0;entryY=0.25;entryDx=0;entryDy=0;" target="asc-tags" value="M2: GetDeltaRotation checks MovementStopped">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-anim-ground" edge="1" parent="1" source="anim-update" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;" target="px-ground" value="G1: GetGroundInfo and copy distances">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-jump-character" edge="1" parent="1" source="jump-start" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;" target="character-jump" value="J1: CanJump then Character.Jump">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e-character-dojump" edge="1" parent="1" source="character-jump" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;" target="px-jump" value="J2: DoJump captures jump start height">
          <mxGeometry relative="1" x="0.5633" y="-1" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="e-landing-character" edge="1" parent="1" source="px-land" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;" target="character-mode" value="J3: movement mode changed after falling">
          <mxGeometry relative="1" x="0.6326" y="-5" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="e-jump-landing" edge="1" parent="1" source="character-mode" style="endArrow=block;dashed=1;endFill=0;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;libavoidRouting=1;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="jump-land" value="J4: MovementModeChangedDelegate">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="816" y="1945" />
              <mxPoint x="816" y="1693" />
              <mxPoint x="-446" y="1693" />
              <mxPoint x="-446" y="1527" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e-jump-event" edge="1" parent="1" source="jump-tick" style="endArrow=block;dashed=1;endFill=0;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;libavoidRouting=1;" target="player-jump-event" value="J5: OnJumpEvent ascent, descent, or landing">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1395" y="1501" />
              <mxPoint x="1395" y="3159" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e-player-gravity" edge="1" parent="1" source="player-jump-event" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="base-gravity" value="J6: Add or remove Jump gravity modifier">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="2850" y="3159.09" />
              <mxPoint x="2850" y="2898" />
              <mxPoint x="1760" y="2898" />
              <mxPoint x="1760" y="2671.09" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e-hero-bind" edge="1" parent="1" source="base-register" style="endArrow=block;dashed=1;endFill=0;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;libavoidRouting=1;" target="hero-rotate" value="H1: bind rotation finished delegate">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="-360" y="2593" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e-rotation-event" edge="1" parent="1" source="hero-rotate" style="endArrow=block;dashed=1;endFill=0;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;libavoidRouting=1;" target="base-rotation-finished" value="H2: OnCharacterRotateStateChanged">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="-360" y="2697" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="KBFHA9E5-ORjHUQzNy8C-4" edge="1" parent="1" source="character-tags" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;entryX=0;entryY=0.75;entryDx=0;entryDy=0;libavoidRouting=1;" target="asc-tags" value="M3: set movement mode tag">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="920" y="2049" />
              <mxPoint x="920" y="568" />
            </Array>
            <mxPoint x="530" y="592" as="sourcePoint" />
            <mxPoint x="2301" y="649" as="targetPoint" />
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="JnKaGwDL6963y3G3FBaH" name="玩家移动的上下行协议">
    <mxGraphModel dx="2054" dy="1201" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="N4drrUrLcN0piS6K0V41-1" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" value="UPXMoveNetSyncComponent &lt;font color=&quot;#6c8ebf&quot;&gt;C++ network bridge&lt;/font&gt;" vertex="1">
          <mxGeometry height="190" width="500" x="910" y="410" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-2" parent="N4drrUrLcN0piS6K0V41-1" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- OldMoveInfo / SaveLocation / serial ids&lt;br&gt;- CheckLocation: correction gate&lt;br&gt;- Owner: AWCharacter" vertex="1">
          <mxGeometry height="52" width="500" y="26" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-3" parent="N4drrUrLcN0piS6K0V41-1" style="line;strokeWidth=1;fillColor=none;strokeColor=#6c8ebf;" value="" vertex="1">
          <mxGeometry height="8" width="500" y="78" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-4" parent="N4drrUrLcN0piS6K0V41-1" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ PerformMovement(): sample only local controlled character" vertex="1">
          <mxGeometry height="26" width="500" y="86" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-5" parent="N4drrUrLcN0piS6K0V41-1" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SendMovementInfo(FWMoveInfo): Blueprint event to Lua" vertex="1">
          <mxGeometry height="26" width="500" y="112" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-6" parent="N4drrUrLcN0piS6K0V41-1" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;fontStyle=1;" value="+ ApplyServerMovementData(FWMoveInfo): server result" vertex="1">
          <mxGeometry height="26" width="500" y="138" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-7" parent="N4drrUrLcN0piS6K0V41-1" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="  local: sequence cache plus distance correction | remote: position, velocity, rotation" vertex="1">
          <mxGeometry height="26" width="500" y="164" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-8" edge="1" parent="N4drrUrLcN0piS6K0V41-1" source="N4drrUrLcN0piS6K0V41-4" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="N4drrUrLcN0piS6K0V41-5" value="N1: changed snapshot to SendMovementInfo">
          <mxGeometry relative="1" x="-0.5" y="247" as="geometry">
            <mxPoint x="57" y="158" as="offset" />
            <Array as="points">
              <mxPoint x="540.08" y="99.08" />
              <mxPoint x="540.08" y="330" />
              <mxPoint x="-109.92" y="330" />
              <mxPoint x="-109.92" y="125.08" />
            </Array>
            <mxPoint x="500" y="99" as="sourcePoint" />
            <mxPoint y="125" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-9" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" value="PXMoveNetSyncComponent &lt;font color=&quot;#6c8ebf&quot;&gt;Lua bridge&lt;/font&gt;" vertex="1">
          <mxGeometry height="86" width="410" x="1749" y="463" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-10" parent="N4drrUrLcN0piS6K0V41-9" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- RoleMoveNet: WRoleMoveNet" vertex="1">
          <mxGeometry height="26" width="410" y="26" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-11" parent="N4drrUrLcN0piS6K0V41-9" style="line;strokeWidth=1;fillColor=none;strokeColor=#6c8ebf;" value="" vertex="1">
          <mxGeometry height="8" width="410" y="52" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-12" parent="N4drrUrLcN0piS6K0V41-9" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ SendMovementInfo(InMoveInfo): WRoleMoveNet.OnSendMoveReq" vertex="1">
          <mxGeometry height="26" width="410" y="60" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-13" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" value="WRoleMoveNet &lt;font color=&quot;#6c8ebf&quot;&gt;Lua protocol adapter&lt;/font&gt;" vertex="1">
          <mxGeometry height="164" width="520" x="2425" y="390" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-14" parent="N4drrUrLcN0piS6K0V41-13" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- MOVE_REQ / MOVE_RESP / MOVE_SYNC_NOTIFY&lt;br&gt;- UEContextObj: UObject" vertex="1">
          <mxGeometry height="52" width="520" y="26" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-15" parent="N4drrUrLcN0piS6K0V41-13" style="line;strokeWidth=1;fillColor=none;strokeColor=#6c8ebf;" value="" vertex="1">
          <mxGeometry height="8" width="520" y="78" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-16" parent="N4drrUrLcN0piS6K0V41-13" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;fontStyle=1;" value="+ OnSendMoveReq(MoveInfo): build MOVE_REQ payload" vertex="1">
          <mxGeometry height="26" width="520" y="86" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-17" parent="N4drrUrLcN0piS6K0V41-13" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;fontStyle=1;" value="+ OnMoveMoveSyncNotify(Resp): Resp to FWMoveInfo" vertex="1">
          <mxGeometry height="26" width="520" y="112" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-18" parent="N4drrUrLcN0piS6K0V41-13" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ GetCharaMoveComp(context, roleId): apply server data" vertex="1">
          <mxGeometry height="26" width="520" y="138" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-19" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=26;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" value="WNetDispatcher &lt;font color=&quot;#6c8ebf&quot;&gt;network dispatcher&lt;/font&gt;" vertex="1">
          <mxGeometry height="112" width="390" x="3233" y="416" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-20" parent="N4drrUrLcN0piS6K0V41-19" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="- HandlerMap: service x proto to callback" vertex="1">
          <mxGeometry height="26" width="390" y="26" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-21" parent="N4drrUrLcN0piS6K0V41-19" style="line;strokeWidth=1;fillColor=none;strokeColor=#6c8ebf;" value="" vertex="1">
          <mxGeometry height="8" width="390" y="52" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-22" parent="N4drrUrLcN0piS6K0V41-19" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Send(MOVE, MOVE_REQ, payload): result" vertex="1">
          <mxGeometry height="26" width="390" y="60" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-23" parent="N4drrUrLcN0piS6K0V41-19" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=4;whiteSpace=wrap;html=1;" value="+ Dispatch(MOVE_SYNC_NOTIFY, Resp): invoke handler" vertex="1">
          <mxGeometry height="26" width="390" y="86" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-24" parent="1" style="ellipse;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;fontSize=16;" value="&lt;b&gt;Game Server&lt;/b&gt;&lt;br&gt;MOVE_REQ upload&lt;br&gt;MOVE_SYNC_NOTIFY broadcast" vertex="1">
          <mxGeometry height="110" width="230" x="3870" y="450" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-25" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-4" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="N4drrUrLcN0piS6K0V41-5" value="N1: changed snapshot to SendMovementInfo">
          <mxGeometry relative="1" x="0.1504" y="-10" as="geometry">
            <mxPoint as="offset" />
            <Array as="points">
              <mxPoint x="1470" y="509.03" />
              <mxPoint x="1470" y="390" />
              <mxPoint x="790" y="390" />
              <mxPoint x="790" y="535.03" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-26" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-5" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;" target="N4drrUrLcN0piS6K0V41-12" value="N2: Blueprint event to Lua bridge">
          <mxGeometry relative="1" x="-0.0053" y="-5" as="geometry">
            <mxPoint x="5" y="-5" as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-27" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-12" style="endArrow=block;endFill=1;html=1;rounded=0;strokeColor=#6c8ebf;entryX=0;entryY=0.5;entryDx=0;entryDy=0;edgeStyle=orthogonalEdgeStyle;curved=1;" target="N4drrUrLcN0piS6K0V41-16" value="N3: OnSendMoveReq builds MOVE_REQ">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-28" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-16" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;" target="N4drrUrLcN0piS6K0V41-22" value="N4: WNetDispatcher.Send">
          <mxGeometry relative="1" x="0.0789" y="17" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-29" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-22" style="endArrow=block;endFill=1;html=1;edgeStyle=entityRelationEdgeStyle;rounded=0;strokeColor=#6c8ebf;" target="N4drrUrLcN0piS6K0V41-24" value="N5: upload MOVE_REQ">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-30" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-24" style="endArrow=block;dashed=1;endFill=0;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;entryX=0;entryY=0.75;entryDx=0;entryDy=0;libavoidRouting=1;" target="N4drrUrLcN0piS6K0V41-23" value="N6: receive MOVE_SYNC_NOTIFY">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="3747" y="505" />
              <mxPoint x="3747" y="544" />
              <mxPoint x="3217" y="544" />
              <mxPoint x="3217" y="522" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-31" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-23" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;" target="N4drrUrLcN0piS6K0V41-17" value="N7: route to OnMoveMoveSyncNotify">
          <mxGeometry relative="1" x="0.0654" y="-5" as="geometry">
            <mxPoint as="offset" />
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-32" edge="1" parent="1" source="N4drrUrLcN0piS6K0V41-18" style="endArrow=block;endFill=1;html=1;edgeStyle=orthogonalEdgeStyle;rounded=0;strokeColor=#6c8ebf;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="N4drrUrLcN0piS6K0V41-6" value="N8: resolve component and apply correction or remote state">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="3070" y="541.04" />
              <mxPoint x="3070" y="710" />
              <mxPoint x="850" y="710" />
              <mxPoint x="850" y="561.04" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="N4drrUrLcN0piS6K0V41-33" parent="1" style="text;html=1;whiteSpace=wrap;strokeColor=none;fillColor=none;align=center;verticalAlign=middle;rounded=0;" value="插件：/PXMovementSync" vertex="1">
          <mxGeometry height="30" width="370" x="370" y="320" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
