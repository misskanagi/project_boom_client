local HUDMyInfo = require "boom.systems.HUD.HUDMyInfo"
local HUDBattle = require "boom.systems.HUD.HUDBattle"
local HUDAssist = require "boom.systems.HUD.HUDAssist"
local HUDUpdate = require "boom.systems.HUD.HUDUpdate"

local HUD = {
  HUDMyInfo(),
  HUDAssist(),
  HUDBattle(),
  HUDUpdate(),
}

HUD.names = {
  "HUDMyInfo",
  "HUDAssist",
  "HUDBattle",
  "HUDUpdate",
}

return HUD
