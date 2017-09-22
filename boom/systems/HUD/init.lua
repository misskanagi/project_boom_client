local HUDMyInfo = require "boom.systems.HUD.HUDMyInfo"
local HUDBattle = require "boom.systems.HUD.HUDBattle"
local HUDUpdate = require "boom.systems.HUD.HUDUpdate"

local HUD = {
  HUDMyInfo = HUDMyInfo(),
  HUDBattle = HUDBattle(),
  HUDUpdate = HUDUpdate(),
}

return HUD