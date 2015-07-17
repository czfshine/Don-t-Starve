modimport'themod.lua'
modimport"cookpotfix.lua"
require  = GLOBAL.require
io       = GLOBAL.io

--LEVELTYPE= GLOBAL.LEVELTYPE
--print(LEVELTYPE)

require 'constants'
--[[
require 'map/tasks/the_task'
require 'map/rooms/the_room']]
require("map/level")
require("map/levels")



TheMod=TheMod()
GLOBAL.TheMod=TheMod


if TheMod.DEBUG then
    GLOBAL.CHEATS_ENABLED=true
    require "debugkeys"
end

TheMod:LoadPrefabsFile()
      :LoadStringFile()
      :LoadAssetsFile()
      --:AddMemFix()
      --:RemoveRecipetabs("MAGIC")
      --[[
      :AddLevel(LEVELTYPE.SURVIVAL,{
          id="MY",
          name="m",
          desc="mm",
          overrides={
            --{"start_setpeice","DefaultStart"},
           -- {"start_node","Clearing"},
          },
          tasks={
            "The_Task",
          },
        })]]


function SimInit(player)

  --TheMod:SqawnST2Player("dreamtent")
  --TheMod:SqawnST2Player("bearger")
  TheMod:SqawnST2Player("test")
  TheMod:SqawnST2Player("wheat")
  TheMod:SqawnST2Player("wheatseeds")
  TheMod:SqawnST2Player("dough")

  TheMod:AddKeyClick(1108,function ()
      TheMod:GetWorldPrefabNum("rabbit")
    end)

  TheMod:AddKeyClick(2102,function ()
  TheMod:FreeBuild()
  end)

  TheMod:AddKeyClick(1109,function ()
    print("1109")
    local x,y,z = player.Transform:GetWorldPosition()
    print(pt)
    TheMod:RebuildLayer({x=x,y=y,z=z},25)
    end)
end

AddSimPostInit(SimInit )


