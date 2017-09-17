local DrivableSync = require "boom.systems.control.DrivableSync"
local GunFireSync = require "boom.systems.control.GunFireSync"

local control = {
  DrivableSync = DrivableSync(),
  GunFireSync = GunFireSync(),
}

return control
