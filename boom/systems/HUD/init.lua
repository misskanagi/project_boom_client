local HUDMyInfo = require "boom.systems.HUD.HUDMyInfo"
local HUDBattle = require "boom.systems.HUD.HUDBattle"
local HUDAssist = require "boom.systems.HUD.HUDAssist"
local HUDGroup = require "boom.systems.HUD.HUDGroup"
local HUDUpdate = require "boom.systems.HUD.HUDUpdate"

local HUD = {
  HUDMyInfo(),
  HUDAssist(),
  HUDBattle(),
  HUDGroup(),
  HUDUpdate(),
}

HUD.names = {
  "HUDMyInfo",
  "HUDAssist",
  "HUDBattle",
  "HUDGroup",
  "HUDUpdate",
}

return HUD
