--[[
	Add modded symbol switching support to cookpot stewer component
]]--

local function SwapToModdedProductAnim(inst, product)
	if not inst:HasTag("burnt") then
		local product = inst.components.stewer.product
		if GLOBAL.ModManager:IsModdedCookerProduct(inst.prefab, product) then
			inst.AnimState:OverrideSymbol("swap_cooked", product, product)
		end
	end
end

local function AddModdedCookpotProductSupport(inst)
	if inst.components.stewer then
		local ondonecooking_base = inst.components.stewer.ondonecooking
		if ondonecooking_base then
			inst.components.stewer.ondonecooking = function(inst)
				ondonecooking_base(inst)
				SwapToModdedProductAnim(inst)
			end
		end

		local oncontinuedone_base = inst.components.stewer.oncontinuedone
		if oncontinuedone_base then
			inst.components.stewer.oncontinuedone = function(inst)
				oncontinuedone_base(inst)
				SwapToModdedProductAnim(inst)
			end
		end

		local onspoil_base = inst.components.stewer.onspoil
		if onspoil_base then
			inst.components.stewer.onspoil = function(inst)
				onspoil_base(inst)
				SwapToModdedProductAnim(inst)
			end
		end
	end
end

AddPrefabPostInit("cookpot", AddModdedCookpotProductSupport)

--[[
	Have ModManager keep track of recipes added by mods
]]--

local ModWrangler = GLOBAL.ModManager

-- add a function to check if a product was added by a mod
function ModWrangler:IsModdedCookerProduct(cooker, name)
	for i,modname in ipairs(self.enabledmods) do
		local mod = self:GetMod(modname)
		if mod.cookerrecipes and mod.cookerrecipes[cooker] and table.contains(mod.cookerrecipes[cooker], name) then
			return true
		end
	end
	return false
end

-- add a table that will keep track of modded recipes
env.cookerrecipes = {}

-- patch the environment's AddCookerRecipe function to keep track of modded recipes
local AddCookerRecipe_base = env.AddCookerRecipe or function() end
env.AddCookerRecipe = function(cooker, recipe)
	AddCookerRecipe_base(cooker, recipe)
	if env.cookerrecipes[cooker] == nil then
		env.cookerrecipes[cooker] = {}
	end
	if recipe.name then
		table.insert(env.cookerrecipes[cooker], recipe.name)
	end
end