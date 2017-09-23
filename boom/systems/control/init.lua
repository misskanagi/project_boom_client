local DrivableSync = require "boom.systems.control.DrivableSync"
local GunFireSync = require "boom.systems.control.GunFireSync"
local TurretSpinSync = require "boom.systems.control.TurretSpinSync"
local LightControl = require "boom.systems.control.LightControl"
local LaunchableSync = require "boom.systems.control.LaunchableSync"
local SpawnableSync = require "boom.systems.control.SpawnableSync"

local control = {
  DrivableSync = DrivableSync(),
  GunFireSync = GunFireSync(),
  TurretSpinSync = TurretSpinSync(),
  LightControl = LightControl(),
  LaunchableSync = LaunchableSync(),
  SpawnableSync = SpawnableSync(),
}

return control
