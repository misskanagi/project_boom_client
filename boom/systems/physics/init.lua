local Friction = require "boom.systems.physics.Friction"
local ShaderPolygonSync = require "boom.systems.physics.ShaderPolygonSync"
local ShaderCircleSync = require "boom.systems.physics.ShaderCircleSync"
local LightPhysicSync = require "boom.systems.physics.LightPhysicSync"
local STIObjectSync = require "boom.systems.physics.STIObjectSync"
local BoosterSync = require "boom.systems.physics.BoosterSync"
local ExplosiveSync = require "boom.systems.physics.ExplosiveSync"
local ImagePhysicSync = require "boom.systems.physics.ImagePhysicSync"
local PolygonPhysicSync = require "boom.systems.physics.PolygonPhysicSync"

local physics = {
  Friction = Friction(),
  ShaderPolygonSync = ShaderPolygonSync(),
  ShaderCircleSync = ShaderCircleSync(),
  LightPhysicSync = LightPhysicSync(),
  STIObjectSync = STIObjectSync(),
  BoosterSync = BoosterSync(),
  ExplosiveSync = ExplosiveSync(),
  ImagePhysicSync = ImagePhysicSync(),
  PolygonPhysicSync = PolygonPhysicSync(),
}

return physics
