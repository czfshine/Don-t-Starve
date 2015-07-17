local Assets =
{
	Asset("ANIM", "anim/testfood.zip")
  
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	inst.AnimState:SetBank("testfood")
	inst.AnimState:SetBuild("testfood")
	inst.AnimState:PlayAnimation("idle", false)
	
	inst:AddTag("preparedfood")

	inst:AddComponent("edible")
	inst.components.edible.healthvalue = TUNING.HEALING_SMALL
	inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.foodtype = "GENERIC"
	inst.components.edible.sanityvalue = 0

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/testfood.xml"

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")
	
	inst:AddComponent("tradable")
	
	return inst
end

STRINGS.NAMES.TESTFOOD = "Generic food"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TESTFOOD = "It could not get more bland."

return Prefab( "common/inventory/dough", fn, Assets )