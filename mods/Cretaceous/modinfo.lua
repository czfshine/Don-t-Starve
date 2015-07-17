name = "Cretaceous"

author = "PioneerMakeTeam"

version = "alpha-0.0.1"

id = "Cretaceous"

branch = "dev"

description = "Cretaceous!"

dont_starve_compatible = true
reign_of_giants_compatible = true

dst_compatible = false

all_clients_require_mod = false
clients_only_mod = false

forumthread = ""

api_version = 6

--dst_api_version = 10

--[[
icon_atlas = ".xml"
icon = ".tex"
]]

priority = -1

if not _PARSING_ENV and branch ~= "master" then
	name = name.." ("..branch..")"
end

------------------------------------------------------------------------
-- CFG
------------------------------------------------------------------------

local function NamedSwitch(on_desc, off_desc)
	return function(name, label, default_value)
		return {
			name = name,
			label = label,
			options = {
				{description = on_desc, data = true},
				{description = off_desc, data = false},
			},
			default = default_value and true or false,
		}
	end
end

local EnableSwitch = NamedSwitch("Enabled", "Disabled")
local OnSwitch = NamedSwitch("On", "Off")
local YesSwitch = NamedSwitch("Yes", "No")

------------------------------------
configuration_options = {
	EnableSwitch("DEBUG", "Debugging Mode", true),
  
	 {
      name = "Language",
      label = "Language",
      options = {
        {description = "English", data = 1},
        {description = "Chinese", data = 2},
       -- {description = "Text Only", data = 1},
      },
      default = 1,
    },    

}

