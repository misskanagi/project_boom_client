local HUDMyInfo = require "boom.systems.HUD.HUDMyInfo"
local HUDUpdate = require "boom.systems.HUD.HUDUpdate"

local HUD = {
  HUDMyInfo = HUDMyInfo(),
  HUDUpdate = HUDUpdate(),
}


return HUD