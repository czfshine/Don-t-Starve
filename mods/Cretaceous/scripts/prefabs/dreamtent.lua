require "prefabutil"
local BigPopupDialogScreen = require "screens/bigpopupdialog"
local assets =
{
	Asset("ANIM", "anim/tent.zip"),
}

local function OnActivate(inst)
	--do popup confirmation
	--do portal presentation
	--save and do restart
    ProfileStatsSet("portal_used", true)
	SetPause(true,"portal")

	local function startadventure()
    TheFrontEnd:PopScreen()
    SetPause(false)
    TheMod:StartNewWolrd()
	end

	local function rejectadventure()
		TheFrontEnd:PopScreen()
		SetPause(false)
		inst.components.activatable.inactive = true
		ProfileStatsSet("portal_rejected", true)
	end
  
	TheFrontEnd:PushScreen(BigPopupDialogScreen(
      STRINGS.UI.DREAMLOAD.TITLE,
      STRINGS.UI.DREAMLOAD.BODY,
			{{text=STRINGS.UI.DREAMLOAD.YES, cb = startadventure},
			 {text=STRINGS.UI.DREAMLOAD.NO, cb = rejectadventure}  }))
end




local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
  inst.Transform:SetScale(2.5,2.5,2.5)
	inst.entity:AddSoundEmitter()
	inst:AddTag("dreamtent")
  MakeObstaclePhysics(inst, 1)

  anim:SetBank("tent")
  anim:SetBuild("tent")
  anim:PlayAnimation("idle", true)
  local minimap = inst.entity:AddMiniMapEntity()
  minimap:SetIcon( "tent.png" )
  inst:AddComponent("inspectable")
  inst:AddComponent("activatable")
  inst.components.activatable.OnActivate = OnActivate
  inst.components.activatable.inactive = true
  inst.components.activatable.quickaction = true
  MakeSnowCovered(inst, .01)
  MakeLargeBurnable(inst, nil, nil, true)
  MakeLargePropagator(inst)
  return inst
end


return Prefab( "common/objects/dreamtent", fn, assets)
