-- coding: UTF-8 

_G=_G or (env or {})
--------------------------------------------|*****************|
GLOBAL.setmetatable(_G, {__index=GLOBAL})---|by: czfshine*****|
--------------------------------------------|*****************|

do --some require 
--require=GLOBAL.require
require 'map/terrain'
require 'class'
require 'constants'
--require "gamelogic"

end
--[[ DON'T NEED !!!!!!!!!
do --some Global value
io          = GLOBAL.io
--os        = GLOBAL.os
GetTime     = GLOBAL.GetTime
GetPlayer   = GLOBAL.GetPlayer
GetWorld    = GLOBAL.GetWorld
SpawnPrefab = GLOBAL.SpawnPrefab
TheSim      = GLOBAL.TheSim
TheInput    = GLOBAL.TheInput
RECIPETABS  = GLOBAL.RECIPETABS
Recipes     = GLOBAL.Recipes
GROUND      = GLOBAL.GROUND
GROUND_NAMES= GLOBAL.GROUND_NAMES
math        = GLOBAL.math
end
--]]

--- 整个Mod的基本类
-- 定义了整个mod的环境与常用功能
-- @classmod  TheMod
-- @usage TheMod=(require 'themod' )()
TheMod=Class(function (self)
  
	self.DEBUG=true   --debug模式
	self.EFFIC=false  --性能优化
  
  self.languagedata=GetModConfigData("Language")
  if self.languagedata==2 then 
    self.ischinese=true 
  else
    self.isenglish=true
  end
  
  
  self.oldlogstate=""
  self.logfile=io.open("Modlog"..tostring(GetTime())..".txt","wb")
  print(self.logfile)
  if self.logfile then 
    
  end
  
  
  self.tile_spec_defaults = {
    noise_texture = "images/square.tex",
    runsound = "dontstarve/movement/run_dirt",
    walksound = "dontstarve/movement/walk_dirt",
    snowsound = "dontstarve/movement/run_ice",
    mudsound = "dontstarve/movement/run_mud",
  }
  

end)

---写入日志
-- @param state 日志状态
-- @param logstr 日志信息
function TheMod:Log(state,logstr)
	if self.logfile then
    if state==self.oldlogstate then 
      self.logfile:write("\t\""..logstr.."\",\n")
    else 
      self.logfile:write("[\""..state.."\"] = ".."\""..logstr.."\",\n")
      self.oldlogstate=state
    end
		if self.DEBUG and self.EFFIC then
			self.logfile:flush()
		end
  else
    print(state,logstr)
	end
end

---载入模块
-- @param module_name 模块名
function TheMod:Require(module_name,import)
	if module_name then
    if import then 
      self:Log("Mod Import File" ,module_name)
      modimport(module_name..".lua")
      return 
    end
		if require then
			self:Log("Mod Require File" ,module_name)
			require (module_name)
		end
	end
end

--- sqwan something to player
function TheMod:SqawnST2Player(STname)
  if  not self.player then 
     self.player=GetPlayer()
  end
  local x, y, z = self.player.Transform:GetWorldPosition()
	print("spawning item")
	local prefab = SpawnPrefab(STname)
  prefab.Transform:SetPosition( x, y, z )
end

function TheMod:LoadPrefabsFile()
  self:Require("prefabfiles",true)
  return self
end

function TheMod:LoadAssetsFile()
  self:Require("assets",true)
  return self
end

--- the language
function TheMod:LoadStringFile()
  if self.ischinese then 
     self:Require("string_cn",true)
  else 
     self:Require("string_en",true)
  end
  return self
end

--- find someting  for inst
--@return repre the first prefabs or nil(not found)
--@return prefabnum the prefabs count or 0 
function TheMod:HasPrefabNear(inst,prefab,radius)
  local repre
  local prefabnum=0
  
  if inst and inst:IsValid() then
    local x,y,z = inst.Transform:GetWorldPosition()
    
		local ents = TheSim:FindEntities(x,y,z,radius) -- or we could 
		for k, v in pairs(ents) do
      
			if v ~= inst 
        and v.entity:IsValid() 
        and v.entity:IsVisible() 
        and v.prefab==prefab then
          
          if not repre then 
            repre=v
          end
          
          prefabnum=prefabnum+1
            
			end
		end
	end
  return repre,prefabnum
end

---get how many prefab in the world 
function TheMod:GetWorldPrefabNum(prefabname)
  
  if  not self.player then 
     self.player=GetPlayer()
  end
  
  local _,num=self:HasPrefabNear(self.player,prefabname,9001)
  print(prefabname,num)
  return num or 0
end

--[[------------------------------------------------
-- the key has four mode :)
-------------------------------
-- alt ctrl shift   one      two               three                   four 
-- 0    0     0    0+key  0001+key      {false,false,false,key}   {alt=flase,ctrl=false,shift=false,key=key}  
-- 0    0     1    1+key  0011+key      {false,false,true,key}    {alt=flase,ctrl=false,shift=true,key=key}   
-- 0    1     0    2+key  0101+key      {false,true,false,key}    {alt=flase,ctrl=true,shift=false,key=key}   
-- 0    1     1    3+key  0111+key      {false,true,true,key}     {alt=flase,ctrl=true,shift=true,key=key}    
-- 1    0     0    4+key  1001+key      {true,false,false,key}    {alt=true,ctrl=false,shift=false,key=key}   
-- 1    0     1    5+key  1011+key      {true,false,true,key}     {alt=true,ctrl=false,shift=true,key=key}    
-- 1    1     0    6+key  1101+key      {true,true,false,key}     {alt=true,ctrl=true,shift=false,key=key}    
-- 1    1     1    7+key  1111+key      {true,true,true,key}      {alt=true,ctrl=true,shift=true,key=key}     
---------------------------------------------------]]
function TheMod:AddKeyClick(key,fn)
  
  local has_alt,has_ctrl,has_shift,thekey
  
  local KEY_ALT ,KEY_CTRL ,KEY_SHIFT = 400,401 ,402
  
  if type(key)=="table" then 
    if key.key then 
      thekey=key.key
      has_alt=key.alt
      has_ctrl=key.ctrl
      has_shift=key.shift 
    else 
      has_alt=key[1]
      has_ctrl=key[2]
      has_shift=key[3]
      thekey=key[4]
    end
  elseif type(key)=="number" and key < 10000 then 
      thekey=key%1000
      has_alt= key >= 4000
      local two=math.floor(key/1000)
      has_ctrl= two==2 or two==3 or two==6 or two==7 
      has_shift= two==1 or two==3 or two==5 or two==7 
  elseif type(key)=="number" then 
    thekey=key%1000
    has_alt=math.floor(key/1000)%10 == 1
    has_ctrl=math.floor(key/10000)%10 == 1
    has_shift=math.floor(key/100000)%10 == 1
  end
  
  if thekey and thekey>0 then 
    
    TheInput:AddKeyDownHandler(thekey,function ()
        
        if not((has_alt   and (not TheInput:IsKeyDown(KEY_ALT)))
            or (has_ctrl  and (not TheInput:IsKeyDown(KEY_CTRL)))
            or (has_shift and (not TheInput:IsKeyDown(KEY_SHIFT)))) then
            fn()
            
        end
    end)
  end
end

---change layer for world 
function TheMod:RebuildLayer(pt,id)
  
  if pt then 
    
    local ground = GetWorld()
    if ground then
      
			local original_tile_type = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
			local x, y = ground.Map:GetTileCoordsAtPoint(pt.x, pt.y, pt.z)

			ground.Map:SetTile( x, y, id)
			ground.Map:RebuildLayer( original_tile_type, x, y )
			ground.Map:RebuildLayer( id, x, y )
			
			local minimap = TheSim:FindFirstEntityWithTag("minimap")
			if minimap then
				minimap.MiniMap:RebuildLayer( original_tile_type, x, y )
				minimap.MiniMap:RebuildLayer( id, x, y )
			end  
			return true
		end
	end
  
end

function TheMod:GetNewTileId()
  local used = {}
  
	for k, v in pairs(GROUND) do
		used[v] = true
	end
  
	local i = 1
	while used[i] and i < GROUND.UNDERGROUND do
		i = i + 1
	end
	return i
end


--===================================
-- !!!!!!!No Complete-----------------
-------------------------------------
function TheMod:AddTile(idname,id,name,specs, minispecs)
    
    local specs = specs or {}
    local minispecs = minispecs or {}
    
    if not id or id==0 then 
      id=self:GetNewTileId()
    end
    
    GROUND[idname] = id
    GROUND_NAMES[id] = name
    
    local real_specs = { name = name }
    
    for k, default in pairs(self.tile_spec_defaults) do
      if specs[k] == nil then
        real_specs[k] = default
      else
        real_specs[k] = specs[k]
      end
    end
    
end
    
function TheMod:AddMemFix()
  self:Require("memspikefix",true)
  ApplyMemFixGlobally()
  return self
end

function TheMod:AddLevel(...)
  self:Require("map/level")
  self:Require("map/levels")
  AddLevel(...)
  
  return self
end

function TheMod:StartNewWolrd()
  local function onsaved()
		    StartNextInstance({reset_action=RESET_ACTION.LOAD_SLOT, save_slot = SaveGameIndex:GetCurrentSaveSlot()}, true)
		end  
		
		--GetPlayer().sg:GoToState("teleportato_teleport")
		--ProfileStatsSet("portal_accepted", true)
		SaveGameIndex:StartAdventure(onsaved) 
    
end
  
  
function TheMod:RemoveRecipetabs(name)
  local count
    
  if RECIPETABS then 
    for k,v in pairs(RECIPETABS) do 
      if k==name then 
          
        count= RECIPETABS[k].sort
        RECIPETABS[k]=nil
      end
    end
  else 
    self:Log("error","no RECIPETABS ")
  end
    
  for k,v in pairs(Recipes) do 
    if v.tab.sort == count then 
      Recipes[k]=nil
    end
  end
  
  return self
end
  
  
function TheMod:FreeBuild()
  
	if not self.player then
    self.player=GetPlayer()
  end
  if self.DEBUG then 
    if self.player.components.builder.freebuildmode then
			self.player.components.builder.freebuildmode = false
    else
			self.player.components.builder.freebuildmode = true
    end
		self.player:PushEvent("unlockrecipe")
  end
end

function TheMod:AddWand(name)
  end


  
return TheMod