<mxfile host="Electron" agent="Codex" pages="5">
  <diagram id="call-map" name="0. 函数调用总览">
    <mxGraphModel dx="2470" dy="961" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" parent="1" style="text;html=1;fontSize=28;fontStyle=1;align=center;verticalAlign=middle;" value="PXBuilding 建造系统 - 函数调用总览" vertex="1">
          <mxGeometry height="45" width="900" x="780" y="30" as="geometry" />
        </mxCell>
        <mxCell id="legend" parent="1" style="text;html=1;fontSize=14;align=center;verticalAlign=middle;fontColor=#666666;" value="蓝色：C++ 输入/预览   绿色：WorldSubsystem 规则/创建   紫色：Lua/UI   黄色：建筑 Actor   红色：收纳与销毁   虚线：回调/返回" vertex="1">
          <mxGeometry height="30" width="1250" x="600" y="85" as="geometry" />
        </mxCell>
        <mxCell id="bagLua" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=28;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#e1d5e7;strokeColor=#9673a6;" value="WBP_PXBuildingBag &lt;font color=&quot;#9673a6&quot;&gt;Lua&lt;/font&gt;" vertex="1">
          <mxGeometry height="148" width="380" x="-741" y="180" as="geometry" />
        </mxCell>
        <mxCell id="bagLua1" parent="bagLua" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ Construct(): Bind Button_Build / Button_Store" vertex="1">
          <mxGeometry height="30" width="380" y="28" as="geometry" />
        </mxCell>
        <mxCell id="bagLua2" parent="bagLua" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ OnBuildClicked()" vertex="1">
          <mxGeometry height="30" width="380" y="58" as="geometry" />
        </mxCell>
        <mxCell id="bagLua3" parent="bagLua" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ OnStoreClicked(): select / store switch" vertex="1">
          <mxGeometry height="30" width="380" y="88" as="geometry" />
        </mxCell>
        <mxCell id="bagLua4" parent="bagLua" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ CloseBuildingBag()" vertex="1">
          <mxGeometry height="30" width="380" y="118" as="geometry" />
        </mxCell>
        <mxCell id="input" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=28;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" value="UPXBuildingBagInputComponent &lt;font color=&quot;#6c8ebf&quot;&gt;C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="358" width="500" x="159" y="150" as="geometry" />
        </mxCell>
        <mxCell id="input1" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ Input_OpenInventory()" vertex="1">
          <mxGeometry height="30" width="500" y="28" as="geometry" />
        </mxCell>
        <mxCell id="input2" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ StartBuildingPlacement(DefinitionId)" vertex="1">
          <mxGeometry height="30" width="500" y="58" as="geometry" />
        </mxCell>
        <mxCell id="input3" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="- CreatePlacementPreview(DefinitionId)" vertex="1">
          <mxGeometry height="30" width="500" y="88" as="geometry" />
        </mxCell>
        <mxCell id="input4" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="- TickComponent() → UpdateBuildingPlacement()" vertex="1">
          <mxGeometry height="30" width="500" y="118" as="geometry" />
        </mxCell>
        <mxCell id="input5" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="- GetCursorHit() / ApplyPreviewMaterial(Failure)" vertex="1">
          <mxGeometry height="30" width="500" y="148" as="geometry" />
        </mxCell>
        <mxCell id="input6" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="- FinishBuildingPlacement()" vertex="1">
          <mxGeometry height="30" width="500" y="178" as="geometry" />
        </mxCell>
        <mxCell id="input7" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ StartStoreSelection()" vertex="1">
          <mxGeometry height="30" width="500" y="208" as="geometry" />
        </mxCell>
        <mxCell id="input8" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="- UpdateStoreSelection() → SelectedBuilding" vertex="1">
          <mxGeometry height="30" width="500" y="238" as="geometry" />
        </mxCell>
        <mxCell id="input9" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ StoreSelectedBuilding()" vertex="1">
          <mxGeometry height="30" width="500" y="268" as="geometry" />
        </mxCell>
        <mxCell id="input10" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ StoreBuildingForLocalPlayer(Building)" vertex="1">
          <mxGeometry height="30" width="500" y="298" as="geometry" />
        </mxCell>
        <mxCell id="input11" parent="input" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="- ResolveBuildingOwnerId()" vertex="1">
          <mxGeometry height="30" width="500" y="328" as="geometry" />
        </mxCell>
        <mxCell id="world" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=28;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" value="UPXBuildingWorldSubsystem &lt;font color=&quot;#82b366&quot;&gt;C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="510" width="520" x="1240" y="150" as="geometry" />
        </mxCell>
        <mxCell id="world1" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ EnterBuildMode() / EnterStoreMode() / ExitMode()" vertex="1">
          <mxGeometry height="30" width="520" y="28" as="geometry" />
        </mxCell>
        <mxCell id="world2" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ GetDefinition(DefinitionId, OutDefinition)" vertex="1">
          <mxGeometry height="30" width="520" y="58" as="geometry" />
        </mxCell>
        <mxCell id="world3" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ EvaluatePlacement(id, Transform)" vertex="1">
          <mxGeometry height="30" width="520" y="88" as="geometry" />
        </mxCell>
        <mxCell id="world4" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="- EvaluatePlacementInternal(): Snap / territory / overlap / ground / limit" vertex="1">
          <mxGeometry height="30" width="520" y="118" as="geometry" />
        </mxCell>
        <mxCell id="world5" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ UpdatePreview(Transform) → OnPlacementPreviewUpdated" vertex="1">
          <mxGeometry height="30" width="520" y="148" as="geometry" />
        </mxCell>
        <mxCell id="world6" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ ConfirmPlacement(id, Transform, OwnerId, Builder)" vertex="1">
          <mxGeometry height="30" width="520" y="178" as="geometry" />
        </mxCell>
        <mxCell id="world7" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ StoreBuilding(Building, OwnerId, Builder)" vertex="1">
          <mxGeometry height="30" width="520" y="208" as="geometry" />
        </mxCell>
        <mxCell id="world8" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="Lua event: RequestBuildingCost(Costs, Builder)" vertex="1">
          <mxGeometry height="30" width="520" y="238" as="geometry" />
        </mxCell>
        <mxCell id="world9" parent="world" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="Lua event: RequestStoreBuilding(Building, Builder)" vertex="1">
          <mxGeometry height="30" width="520" y="268" as="geometry" />
        </mxCell>
        <mxCell id="actor" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=28;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" value="APXBuildingActor &lt;font color=&quot;#d6b656&quot;&gt;C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="268" width="500" x="2718" y="150" as="geometry" />
        </mxCell>
        <mxCell id="actor1" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ InitializeBuilding(...) → Constructing" vertex="1">
          <mxGeometry height="30" width="500" y="28" as="geometry" />
        </mxCell>
        <mxCell id="actor2" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ FinishConstruction() → Idle" vertex="1">
          <mxGeometry height="30" width="500" y="58" as="geometry" />
        </mxCell>
        <mxCell id="actor3" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ CanBeStoredBy(RequestingOwnerId): Idle &amp;&amp; OwnerId match" vertex="1">
          <mxGeometry height="30" width="500" y="88" as="geometry" />
        </mxCell>
        <mxCell id="actor4" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ BeginPlay(): bind InteractionTrigger overlap callbacks" vertex="1">
          <mxGeometry height="30" width="500" y="118" as="geometry" />
        </mxCell>
        <mxCell id="actor5" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="- OnInteractionTriggerBegin() [Idle &amp;&amp; local pawn]" vertex="1">
          <mxGeometry height="30" width="500" y="148" as="geometry" />
        </mxCell>
        <mxCell id="actor6" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="- OpenInteractionWidget()" vertex="1">
          <mxGeometry height="30" width="500" y="178" as="geometry" />
        </mxCell>
        <mxCell id="actor7" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="- OnInteractionTriggerEnd() → CloseInteractionWidget()" vertex="1">
          <mxGeometry height="30" width="500" y="208" as="geometry" />
        </mxCell>
        <mxCell id="actor8" parent="actor" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ ApplyDamage() / ApplyStatePresentation()" vertex="1">
          <mxGeometry height="30" width="500" y="238" as="geometry" />
        </mxCell>
        <mxCell id="interaction" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=28;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#e1d5e7;strokeColor=#9673a6;" value="WBP_PXBuildingInteraction &lt;font color=&quot;#9673a6&quot;&gt;Lua / C++&lt;/font&gt;" vertex="1">
          <mxGeometry height="178" width="480" x="2719" y="820" as="geometry" />
        </mxCell>
        <mxCell id="interaction1" parent="interaction" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ Construct(): bind Button_Store.OnClicked" vertex="1">
          <mxGeometry height="30" width="480" y="28" as="geometry" />
        </mxCell>
        <mxCell id="interaction2" parent="interaction" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ OnStoreClicked() → StoreBuilding()" vertex="1">
          <mxGeometry height="30" width="480" y="58" as="geometry" />
        </mxCell>
        <mxCell id="interaction3" parent="interaction" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ SetBuilding(APXBuildingActor*)" vertex="1">
          <mxGeometry height="30" width="480" y="88" as="geometry" />
        </mxCell>
        <mxCell id="interaction4" parent="interaction" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;fontStyle=1;" value="+ StoreBuilding(): Find BagInputComponent" vertex="1">
          <mxGeometry height="30" width="480" y="118" as="geometry" />
        </mxCell>
        <mxCell id="interaction5" parent="interaction" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ CloseInteractionWidget() → UIManager.CloseWidgetByInstance" vertex="1">
          <mxGeometry height="30" width="480" y="148" as="geometry" />
        </mxCell>
        <mxCell id="luaSub" parent="1" style="swimlane;fontStyle=1;align=center;verticalAlign=top;childLayout=stackLayout;horizontal=1;startSize=28;horizontalStack=0;resizeParent=1;resizeParentMax=0;resizeLast=0;collapsible=1;marginBottom=0;whiteSpace=wrap;html=1;fillColor=#f8cecc;strokeColor=#b85450;" value="PXBuildingSubsystem.lua" vertex="1">
          <mxGeometry height="180" width="520" x="1240" y="850" as="geometry" />
        </mxCell>
        <mxCell id="luaSub1" parent="luaSub" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ RequestBuildingCost(costs, builder): false (current)" vertex="1">
          <mxGeometry height="30" width="520" y="28" as="geometry" />
        </mxCell>
        <mxCell id="luaSub2" parent="luaSub" style="text;strokeColor=none;fillColor=none;align=left;verticalAlign=top;spacingLeft=8;whiteSpace=wrap;html=1;" value="+ RequestStoreBuilding(building, builder): true (current)" vertex="1">
          <mxGeometry height="30" width="520" y="58" as="geometry" />
        </mxCell>
        <mxCell id="e1" edge="1" parent="1" source="bagLua2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;orthogonalLoop=1;jettySize=auto;html=1;endArrow=block;endFill=1;strokeColor=#9673a6;fontSize=13;" target="input2" value="1. OnBuildClicked() → StartBuildingPlacement(id)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="-190" y="253.03" />
              <mxPoint x="-190" y="223.03" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e2" edge="1" parent="1" source="input3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#6c8ebf;fontSize=13;" target="world2" value="2. CreatePlacementPreview(): GetDefinition(id)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="720.05" y="253.05" />
              <mxPoint x="720.05" y="223.05" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e3" edge="1" parent="1" source="input4" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#6c8ebf;fontSize=13;" target="world3" value="3. Tick → EvaluatePlacement(id, cursor transform)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="850.05" y="283.05" />
              <mxPoint x="850.05" y="253.05" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e4" edge="1" parent="1" source="world3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#82b366;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="world4" value="4. EvaluatePlacement → EvaluatePlacementInternal">
          <mxGeometry relative="1" x="-0.029" as="geometry">
            <mxPoint as="offset" />
            <Array as="points">
              <mxPoint x="1850" y="253" />
              <mxPoint x="1850" y="120" />
              <mxPoint x="1140" y="120" />
              <mxPoint x="1140" y="283" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e5" edge="1" parent="1" source="world4" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;dashed=1;endArrow=open;strokeColor=#6c8ebf;fontSize=13;" target="input5" value="5. Result.Failure → ApplyPreviewMaterial\nNone=green; otherwise=red">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e6" edge="1" parent="1" source="input6" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#6c8ebf;fontSize=13;" target="world6" value="6. mouse release → ConfirmPlacement(...)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e7" edge="1" parent="1" source="world6" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#82b366;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="actor1" value="7. SpawnActor → InitializeBuilding → FinishConstruction">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1920" y="343" />
              <mxPoint x="1920" y="193" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e8" edge="1" parent="1" source="bagLua3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#9673a6;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="input7" value="8. OnStoreClicked → StartStoreSelection">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="-190" y="283.03" />
              <mxPoint x="-190" y="373.03" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e9" edge="1" parent="1" source="bagLua3" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#9673a6;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="input9" value="9. selected building → StoreSelectedBuilding">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="-190" y="283.03" />
              <mxPoint x="-190" y="433.03" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e10" edge="1" parent="1" source="input9" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#6c8ebf;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="input10" value="10. StoreSelectedBuilding → StoreBuildingForLocalPlayer">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="860" y="433.03" />
              <mxPoint x="860" y="540" />
              <mxPoint x="-60" y="540" />
              <mxPoint x="-60" y="463.03" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e11" edge="1" parent="1" source="input10" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#6c8ebf;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="world7" value="11. Resolve owner → StoreBuilding(Building, OwnerId, PC)">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e12" edge="1" parent="1" source="world7" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#b85450;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="actor3" value="12. CanBeStoredBy(owner) [Idle &amp;&amp; owner matches]">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1960" y="373.03" />
              <mxPoint x="1960" y="253.03" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e13" edge="1" parent="1" source="world9" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#b85450;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="luaSub2" value="13. RequestStoreBuilding(Building, Builder)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="1830" y="433" />
              <mxPoint x="1830" y="750" />
              <mxPoint x="1000" y="750" />
              <mxPoint x="1000" y="923" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e14" edge="1" parent="1" source="luaSub2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;dashed=1;endArrow=open;strokeColor=#b85450;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="actor8" value="14. true → OnBuildingStored.Broadcast; Building.Destroy">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="2040" y="923" />
              <mxPoint x="2040" y="403" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e15" edge="1" parent="1" source="actor5" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#d6b656;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="actor6" value="15. overlap begin → OpenInteractionWidget">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="3320" y="313.04" />
              <mxPoint x="3320" y="130" />
              <mxPoint x="2060" y="130" />
              <mxPoint x="2060" y="343.04" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e16" edge="1" parent="1" source="actor6" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#d6b656;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;" target="interaction3" value="16. Push widget; SetBuilding(this)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="2230" y="343" />
              <mxPoint x="2230" y="923" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e17" edge="1" parent="1" source="interaction2" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#9673a6;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="interaction4" value="17. Button_Store → StoreBuilding">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="3320" y="893.04" />
              <mxPoint x="3320" y="800" />
              <mxPoint x="2087.04" y="800" />
              <mxPoint x="2087.04" y="953.04" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e18" edge="1" parent="1" source="interaction4" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#9673a6;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.25;exitDx=0;exitDy=0;" target="input10" value="18. Find BagInput → StoreBuildingForLocalPlayer(Building)">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="3310" y="945.53" />
              <mxPoint x="3310" y="1050.07" />
              <mxPoint x="-189.87" y="1050.07" />
              <mxPoint x="-189.87" y="463" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="e19" edge="1" parent="1" source="actor7" style="edgeStyle=orthogonalEdgeStyle;rounded=0;html=1;endArrow=block;endFill=1;strokeColor=#d6b656;fontSize=13;entryX=0;entryY=0.5;entryDx=0;entryDy=0;exitX=1;exitY=0.5;exitDx=0;exitDy=0;" target="interaction5" value="19. overlap end / non-Idle → CloseInteractionWidget">
          <mxGeometry relative="1" as="geometry">
            <Array as="points">
              <mxPoint x="3360" y="373.04" />
              <mxPoint x="3360" y="1080" />
              <mxPoint x="2090" y="1080" />
              <mxPoint x="2090" y="983.04" />
            </Array>
          </mxGeometry>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="class" name="1. UML Class Diagram">
    <mxGraphModel dx="1800" dy="1100" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1800" pageHeight="1100" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" value="PXBuilding System - UML Class Diagram" style="text;html=1;fontSize=24;fontStyle=1;align=center;" vertex="1" parent="1">
          <mxGeometry x="570" y="20" width="650" height="40" as="geometry" />
        </mxCell>
        <mxCell id="world" value="&lt;b&gt;&amp;lt;&amp;lt;WorldSubsystem&amp;gt;&amp;gt;&lt;/b&gt;&lt;br/&gt;&lt;b&gt;UPXBuildingWorldSubsystem&lt;/b&gt;&lt;hr/&gt;- Mode: EPXBuildingMode&lt;br/&gt;- SelectedDefinitionId: int32&lt;br/&gt;- Territory: FPXBuildingTerritory&lt;hr/&gt;+ EnterBuildMode(): void&lt;br/&gt;+ EnterStoreMode(): void&lt;br/&gt;+ ExitMode(): void&lt;br/&gt;+ EvaluatePlacement(id, t): Result&lt;br/&gt;+ ConfirmPlacement(id, t, owner, builder): Actor*&lt;br/&gt;+ StoreBuilding(actor, owner, builder): bool&lt;br/&gt;- EvaluatePlacementInternal(id, t, ignored): Result" style="swimlane;html=1;rounded=0;startSize=30;fillColor=#d5e8d4;strokeColor=#82b366;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="620" y="140" width="400" height="320" as="geometry" />
        </mxCell>
        <mxCell id="actor" value="&lt;b&gt;&amp;lt;&amp;lt;Actor&amp;gt;&amp;gt;&lt;/b&gt;&lt;br/&gt;&lt;b&gt;APXBuildingActor&lt;/b&gt;&lt;hr/&gt;- DefinitionId: int32&lt;br/&gt;- OwnerId: FString&lt;br/&gt;- BuildingState: EPXBuildingState&lt;br/&gt;- InteractionTrigger: UBoxComponent&lt;br/&gt;- InteractionWidget: Widget*&lt;hr/&gt;+ InitializeBuilding(...): void&lt;br/&gt;+ FinishConstruction(): void&lt;br/&gt;+ CanBeStoredBy(owner): bool&lt;br/&gt;+ ApplyDamage(damage): void&lt;br/&gt;+ CloseInteractionWidget(): void&lt;br/&gt;- OnInteractionTriggerBegin(...): void&lt;br/&gt;- OnInteractionTriggerEnd(...): void" style="swimlane;html=1;rounded=0;startSize=30;fillColor=#fff2cc;strokeColor=#d6b656;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="1190" y="120" width="410" height="345" as="geometry" />
        </mxCell>
        <mxCell id="input" value="&lt;b&gt;&amp;lt;&amp;lt;ActorComponent&amp;gt;&amp;gt;&lt;/b&gt;&lt;br/&gt;&lt;b&gt;UPXBuildingBagInputComponent&lt;/b&gt;&lt;hr/&gt;- BuildingOwnerId: FString&lt;br/&gt;- PlacementPreviewActor: AActor*&lt;br/&gt;- SelectedBuilding: APXBuildingActor*&lt;hr/&gt;+ StartBuildingPlacement(id): bool&lt;br/&gt;+ StartStoreSelection(): void&lt;br/&gt;+ StoreSelectedBuilding(): bool&lt;br/&gt;+ StoreBuildingForLocalPlayer(actor): bool&lt;br/&gt;+ CancelBuildingInteraction(): void&lt;br/&gt;- UpdateBuildingPlacement(): void&lt;br/&gt;- UpdateStoreSelection(): void&lt;br/&gt;- ResolveBuildingOwnerId(): FString" style="swimlane;html=1;rounded=0;startSize=30;fillColor=#dae8fc;strokeColor=#6c8ebf;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="70" y="130" width="420" height="335" as="geometry" />
        </mxCell>
        <mxCell id="widget" value="&lt;b&gt;&amp;lt;&amp;lt;CommonUI, UnLua&amp;gt;&amp;gt;&lt;/b&gt;&lt;br/&gt;&lt;b&gt;UPXBuildingInteractionWidget&lt;/b&gt;&lt;hr/&gt;- Building: APXBuildingActor*&lt;br/&gt;- LuaFileName: FString&lt;hr/&gt;+ SetBuilding(actor): void&lt;br/&gt;+ StoreBuilding(): bool&lt;br/&gt;+ CloseInteractionWidget(): void&lt;br/&gt;+ NativeOnDeactivated(): void" style="swimlane;html=1;rounded=0;startSize=30;fillColor=#f8cecc;strokeColor=#b85450;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="1190" y="620" width="390" height="235" as="geometry" />
        </mxCell>
        <mxCell id="types" value="&lt;b&gt;&amp;lt;&amp;lt;data types&amp;gt;&amp;gt;&lt;/b&gt;&lt;br/&gt;&lt;b&gt;PXBuildingTypes&lt;/b&gt;&lt;hr/&gt;FPXBuildingDefinition&lt;br/&gt;FPXBuildingPlacementResult&lt;br/&gt;FPXBuildingTerritory&lt;br/&gt;EPXBuildingMode&lt;br/&gt;EPXBuildingState&lt;br/&gt;EPXBuildingPlacementFailure" style="swimlane;html=1;rounded=0;startSize=30;fillColor=#f5f5f5;strokeColor=#666666;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="610" y="640" width="300" height="220" as="geometry" />
        </mxCell>
        <mxCell id="lua" value="&lt;b&gt;&amp;lt;&amp;lt;UnLua scripts&amp;gt;&amp;gt;&lt;/b&gt;&lt;br/&gt;PXBuildingBagWidget.lua&lt;br/&gt;PXBuildingInteractionWidget.lua&lt;br/&gt;PXBuildingSubsystem.lua" style="swimlane;html=1;rounded=0;startSize=30;fillColor=#e1d5e7;strokeColor=#9673a6;align=left;verticalAlign=top;spacingLeft=8;spacingTop=4;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="100" y="690" width="330" height="160" as="geometry" />
        </mxCell>
        <mxCell id="r1" value="spawns 0..*" style="edgeStyle=orthogonalEdgeStyle;html=1;endArrow=diamondThin;endFill=0;strokeColor=#82b366;" edge="1" parent="1" source="world" target="actor">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="r2" value="uses" style="edgeStyle=orthogonalEdgeStyle;html=1;dashed=1;endArrow=open;strokeColor=#6c8ebf;" edge="1" parent="1" source="input" target="world">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="r3" value="owns 0..1" style="edgeStyle=orthogonalEdgeStyle;html=1;endArrow=diamondThin;endFill=1;strokeColor=#d6b656;" edge="1" parent="1" source="actor" target="widget">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="r4" value="calls" style="edgeStyle=orthogonalEdgeStyle;html=1;dashed=1;endArrow=open;strokeColor=#b85450;" edge="1" parent="1" source="widget" target="input">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="r5" value="references" style="edgeStyle=orthogonalEdgeStyle;html=1;dashed=1;endArrow=open;strokeColor=#666666;" edge="1" parent="1" source="world" target="types">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="r6" value="implements callbacks" style="edgeStyle=orthogonalEdgeStyle;html=1;dashed=1;endArrow=open;strokeColor=#9673a6;" edge="1" parent="1" source="lua" target="world">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="r7" value="binds buttons" style="edgeStyle=orthogonalEdgeStyle;html=1;dashed=1;endArrow=open;strokeColor=#9673a6;" edge="1" parent="1" source="lua" target="widget">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="sequence" name="2. UML Sequence Diagram">
    <mxGraphModel dx="2050" dy="1200" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="2050" pageHeight="1200" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" value="UML Sequence: 触发盒收纳界面的打开、收纳与关闭" style="text;html=1;fontSize=24;fontStyle=1;align=center;" vertex="1" parent="1">
          <mxGeometry x="540" y="20" width="900" height="40" as="geometry" />
        </mxCell>
        <mxCell id="p" value="LocalPlayerPawn" style="shape=umlLifeline;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1">
          <mxGeometry x="70" y="100" width="140" height="900" as="geometry" />
        </mxCell>
        <mxCell id="a" value="APXBuildingActor" style="shape=umlLifeline;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" vertex="1" parent="1">
          <mxGeometry x="370" y="100" width="155" height="900" as="geometry" />
        </mxCell>
        <mxCell id="u" value="UPXUIManagerSubsystem" style="shape=umlLifeline;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" vertex="1" parent="1">
          <mxGeometry x="705" y="100" width="170" height="900" as="geometry" />
        </mxCell>
        <mxCell id="w" value="InteractionWidget" style="shape=umlLifeline;html=1;fillColor=#e1d5e7;strokeColor=#9673a6;" vertex="1" parent="1">
          <mxGeometry x="1050" y="100" width="165" height="900" as="geometry" />
        </mxCell>
        <mxCell id="i" value="BagInputComponent" style="shape=umlLifeline;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1">
          <mxGeometry x="1380" y="100" width="170" height="900" as="geometry" />
        </mxCell>
        <mxCell id="s" value="WorldSubsystem / Lua" style="shape=umlLifeline;html=1;fillColor=#f8cecc;strokeColor=#b85450;" vertex="1" parent="1">
          <mxGeometry x="1700" y="100" width="180" height="900" as="geometry" />
        </mxCell>
        <mxCell id="acta1" style="html=1;fillColor=#d6b656;strokeColor=#d6b656;" vertex="1" parent="1">
          <mxGeometry x="438" y="215" width="18" height="180" as="geometry" />
        </mxCell>
        <mxCell id="actu" style="html=1;fillColor=#82b366;strokeColor=#82b366;" vertex="1" parent="1">
          <mxGeometry x="781" y="290" width="18" height="95" as="geometry" />
        </mxCell>
        <mxCell id="actw" style="html=1;fillColor=#9673a6;strokeColor=#9673a6;" vertex="1" parent="1">
          <mxGeometry x="1124" y="445" width="18" height="300" as="geometry" />
        </mxCell>
        <mxCell id="acti" style="html=1;fillColor=#6c8ebf;strokeColor=#6c8ebf;" vertex="1" parent="1">
          <mxGeometry x="1456" y="605" width="18" height="130" as="geometry" />
        </mxCell>
        <mxCell id="acts" style="html=1;fillColor=#b85450;strokeColor=#b85450;" vertex="1" parent="1">
          <mxGeometry x="1781" y="650" width="18" height="115" as="geometry" />
        </mxCell>
        <mxCell id="m1" value="1: OnComponentBeginOverlap()" style="endArrow=block;html=1;strokeColor=#6c8ebf;" edge="1" parent="1" source="p" target="a">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m2" value="2: OnInteractionTriggerBegin() [Idle &amp;&amp; local]" style="endArrow=block;html=1;strokeColor=#d6b656;" edge="1" parent="1" source="a" target="u">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m3" value="3: PushWidgetToLayer(...InteractionWidgetClass)" style="endArrow=block;html=1;strokeColor=#82b366;" edge="1" parent="1" source="a" target="u">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m4" value="4: create + activate" style="endArrow=block;html=1;strokeColor=#82b366;" edge="1" parent="1" source="u" target="w">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m5" value="5: SetBuilding(this)" style="endArrow=open;html=1;dashed=1;strokeColor=#666666;" edge="1" parent="1" source="w" target="a">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m6" value="6: Button_Store.OnClicked → StoreBuilding()" style="endArrow=block;html=1;strokeColor=#9673a6;" edge="1" parent="1" source="w" target="w">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m7" value="7: StoreBuildingForLocalPlayer(Building)" style="endArrow=block;html=1;strokeColor=#9673a6;" edge="1" parent="1" source="w" target="i">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m8" value="8: StoreBuilding(Building, ResolveBuildingOwnerId(), PC)" style="endArrow=block;html=1;strokeColor=#6c8ebf;" edge="1" parent="1" source="i" target="s">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m9" value="9: CanBeStoredBy(owner) + RequestStoreBuilding()\nOnBuildingStored; Building.Destroy()" style="endArrow=open;html=1;dashed=1;strokeColor=#b85450;" edge="1" parent="1" source="s" target="a">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="m10" value="10: CloseInteractionWidget() → CloseWidgetByInstance(this)" style="endArrow=block;html=1;strokeColor=#b85450;" edge="1" parent="1" source="w" target="u">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="alt" value="alt\n[not Idle / owner mismatch / Lua returns false]\nStoreBuilding() returns false; UI remains open" style="swimlane;html=1;rounded=0;startSize=24;fillColor=none;strokeColor=#b85450;dashed=1;fontSize=13;" vertex="1" parent="1">
          <mxGeometry x="980" y="800" width="850" height="120" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="activity" name="3. UML Activity Diagram">
    <mxGraphModel dx="1800" dy="1250" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1800" pageHeight="1250" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" value="UML Activity: 建造放置与实时预览函数路径" style="text;html=1;fontSize=24;fontStyle=1;align=center;" vertex="1" parent="1">
          <mxGeometry x="540" y="20" width="700" height="40" as="geometry" />
        </mxCell>
        <mxCell id="start" style="ellipse;html=1;aspect=fixed;fillColor=#000000;strokeColor=#000000;" vertex="1" parent="1">
          <mxGeometry x="820" y="90" width="30" height="30" as="geometry" />
        </mxCell>
        <mxCell id="n1" value="PXBuildingBagWidget.OnBuildClicked()\n→ input.StartBuildingPlacement(DefinitionId)" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#e1d5e7;strokeColor=#9673a6;" vertex="1" parent="1">
          <mxGeometry x="650" y="160" width="370" height="65" as="geometry" />
        </mxCell>
        <mxCell id="n2" value="CancelBuildingInteraction()\nGet subsystem + CreatePlacementPreview()\nEnterBuildMode(); SetSelectedDefinition()" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1">
          <mxGeometry x="650" y="280" width="370" height="85" as="geometry" />
        </mxCell>
        <mxCell id="d1" value="Preview created?" style="rhombus;html=1;whiteSpace=wrap;fillColor=#fff2cc;strokeColor=#d6b656;" vertex="1" parent="1">
          <mxGeometry x="740" y="420" width="190" height="100" as="geometry" />
        </mxCell>
        <mxCell id="fail1" value="OnBuildPlacementFailed(InvalidDefinition)\nreturn false" style="rounded=1;html=1;fillColor=#f8cecc;strokeColor=#b85450;" vertex="1" parent="1">
          <mxGeometry x="1120" y="435" width="280" height="65" as="geometry" />
        </mxCell>
        <mxCell id="loop" value="loop [each TickComponent while preview exists]" style="swimlane;html=1;rounded=0;startSize=24;fillColor=none;strokeColor=#6c8ebf;dashed=1;" vertex="1" parent="1">
          <mxGeometry x="470" y="570" width="720" height="360" as="geometry" />
        </mxCell>
        <mxCell id="n3" value="UpdateBuildingPlacement()\n→ GetCursorHit()" style="rounded=1;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1">
          <mxGeometry x="645" y="630" width="360" height="60" as="geometry" />
        </mxCell>
        <mxCell id="d2" value="Cursor hit?" style="rhombus;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" vertex="1" parent="1">
          <mxGeometry x="745" y="730" width="160" height="85" as="geometry" />
        </mxCell>
        <mxCell id="n4" value="EvaluatePlacement(id, ImpactTransform)\n→ EvaluatePlacementInternal()\n→ Snap / definition / territory / overlap / ground / limit" style="rounded=1;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" vertex="1" parent="1">
          <mxGeometry x="535" y="845" width="580" height="65" as="geometry" />
        </mxCell>
        <mxCell id="n5" value="Set preview transform\nApplyPreviewMaterial(Failure):\nNone = valid green; other = invalid red\nUpdatePreview()" style="rounded=1;html=1;fillColor=#dae8fc;strokeColor=#6c8ebf;" vertex="1" parent="1">
          <mxGeometry x="585" y="965" width="480" height="85" as="geometry" />
        </mxCell>
        <mxCell id="d3" value="left mouse\nreleased?" style="rhombus;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" vertex="1" parent="1">
          <mxGeometry x="1280" y="720" width="160" height="95" as="geometry" />
        </mxCell>
        <mxCell id="d4" value="CurrentPlacementResult\nbCanPlace?" style="rhombus;html=1;fillColor=#fff2cc;strokeColor=#d6b656;" vertex="1" parent="1">
          <mxGeometry x="1280" y="865" width="160" height="100" as="geometry" />
        </mxCell>
        <mxCell id="n6" value="FinishBuildingPlacement()\nResolveBuildingOwnerId()\nConfirmPlacement(...)" style="rounded=1;html=1;fillColor=#d5e8d4;strokeColor=#82b366;" vertex="1" parent="1">
          <mxGeometry x="1210" y="1030" width="300" height="70" as="geometry" />
        </mxCell>
        <mxCell id="end" style="ellipse;html=1;aspect=fixed;shape=endState;fillColor=#000000;strokeColor=#000000;" vertex="1" parent="1">
          <mxGeometry x="1345" y="1150" width="35" height="35" as="geometry" />
        </mxCell>
        <mxCell id="e1" style="endArrow=block;html=1;" edge="1" parent="1" source="start" target="n1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e2" style="endArrow=block;html=1;" edge="1" parent="1" source="n1" target="n2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e3" style="endArrow=block;html=1;" edge="1" parent="1" source="n2" target="d1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e4" value="no" style="endArrow=block;html=1;" edge="1" parent="1" source="d1" target="fail1">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e5" value="yes" style="endArrow=block;html=1;" edge="1" parent="1" source="d1" target="n3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e6" style="endArrow=block;html=1;" edge="1" parent="1" source="n3" target="d2">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e7" value="yes" style="endArrow=block;html=1;" edge="1" parent="1" source="d2" target="n4">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e8" style="endArrow=block;html=1;" edge="1" parent="1" source="n4" target="n5">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e9" style="endArrow=block;html=1;" edge="1" parent="1" source="n5" target="d3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e10" value="no / loop" style="endArrow=block;html=1;" edge="1" parent="1" source="d3" target="n3">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e11" value="yes" style="endArrow=block;html=1;" edge="1" parent="1" source="d3" target="d4">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e12" value="yes" style="endArrow=block;html=1;" edge="1" parent="1" source="d4" target="n6">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="e13" style="endArrow=block;html=1;" edge="1" parent="1" source="n6" target="end">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="state" name="4. UML State Machine">
    <mxGraphModel dx="1800" dy="1100" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1800" pageHeight="1100" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="title" value="UML State Machine: APXBuildingActor.BuildingState 与交互界面行为" style="text;html=1;fontSize=24;fontStyle=1;align=center;" vertex="1" parent="1">
          <mxGeometry x="470" y="20" width="900" height="40" as="geometry" />
        </mxCell>
        <mxCell id="start" style="ellipse;html=1;aspect=fixed;fillColor=#000000;strokeColor=#000000;" vertex="1" parent="1">
          <mxGeometry x="180" y="240" width="30" height="30" as="geometry" />
        </mxCell>
        <mxCell id="construct" value="Constructing\nInteractionTrigger: NoCollision\nNavigation: disabled" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#dae8fc;strokeColor=#6c8ebf;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="300" y="200" width="230" height="100" as="geometry" />
        </mxCell>
        <mxCell id="idle" value="Idle\nInteractionTrigger: QueryOnly\nlocal pawn overlap can open UI" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#d5e8d4;strokeColor=#82b366;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="700" y="190" width="260" height="115" as="geometry" />
        </mxCell>
        <mxCell id="combat" value="Combat\nCloseInteractionWidget()\nInteractionTrigger: NoCollision" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#fff2cc;strokeColor=#d6b656;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="1130" y="200" width="250" height="100" as="geometry" />
        </mxCell>
        <mxCell id="dead" value="Dead\nHide actor; disable collision/navigation\nCloseInteractionWidget(); Destroy()" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#f8cecc;strokeColor=#b85450;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="1130" y="490" width="270" height="110" as="geometry" />
        </mxCell>
        <mxCell id="uiopen" value="Interaction UI Open\nOpenInteractionWidget()\nSetBuilding(this)" style="rounded=1;html=1;whiteSpace=wrap;fillColor=#e1d5e7;strokeColor=#9673a6;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="700" y="490" width="260" height="100" as="geometry" />
        </mxCell>
        <mxCell id="end" style="ellipse;html=1;aspect=fixed;shape=endState;fillColor=#000000;strokeColor=#000000;" vertex="1" parent="1">
          <mxGeometry x="1530" y="530" width="35" height="35" as="geometry" />
        </mxCell>
        <mxCell id="s1" style="endArrow=block;html=1;" edge="1" parent="1" source="start" target="construct">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s2" value="FinishConstruction()" style="endArrow=block;html=1;" edge="1" parent="1" source="construct" target="idle">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s3" value="OnInteractionTriggerBegin\n[local player]" style="endArrow=block;html=1;" edge="1" parent="1" source="idle" target="uiopen">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s4" value="OnInteractionTriggerEnd\nor CloseInteractionWidget" style="endArrow=block;html=1;" edge="1" parent="1" source="uiopen" target="idle">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s5" value="ApplyDamage(damage &gt; 0)" style="endArrow=block;html=1;" edge="1" parent="1" source="idle" target="combat">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s6" value="ApplyDamage(damage &gt; 0)" style="endArrow=block;html=1;" edge="1" parent="1" source="uiopen" target="combat">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s7" value="CurrentDurability &lt;= 0" style="endArrow=block;html=1;" edge="1" parent="1" source="combat" target="dead">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s8" value="StoreBuilding succeeds\nBuilding.Destroy()" style="endArrow=block;html=1;" edge="1" parent="1" source="idle" target="dead">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
        <mxCell id="s9" style="endArrow=block;html=1;" edge="1" parent="1" source="dead" target="end">
          <mxGeometry relative="1" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
