local Friction = require "boom.systems.physics.Friction"
local ShaderPolygonSync = require "boom.systems.physics.ShaderPolygonSync"
local ShaderCircleSync = require "boom.systems.physics.ShaderCircleSync"
local LightPhysicSync = require "boom.systems.physics.LightPhysicSync"
local STIObjectSync = require "boom.systems.physics.STIObjectSync"
local BoosterSync = require "boom.systems.physics.BoosterSync"
local ExplosiveSync = require "boom.systems.physics.ExplosiveSync"
local ImagePhysicSync = require "boom.systems.physics.ImagePhysicSync"
local PolygonPhysicSync = require "boom.systems.physics.PolygonPhysicSync"
local ItemSpin = require "boom.systems.physics.ItemSpin"
local PhysicLerpSync = require "boom.systems.physics.PhysicLerpSync"

local physics = {
  Friction(),
  ShaderPolygonSync(),
  ShaderCircleSync(),
  LightPhysicSync(),
  STIObjectSync(),
  BoosterSync(),
  ExplosiveSync(),
  ImagePhysicSync(),
  PolygonPhysicSync(),
  ItemSpin(),
  PhysicLerpSync(),
}

physics.names = {
  "Friction",
  "ShaderPolygonSync",
  "ShaderCircleSync",
  "LightPhysicSync",
  "STIObjectSync",
  "BoosterSync",
  "ExplosiveSync",
  "ImagePhysicSync",
  "PolygonPhysicSync",
  "ItemSpin",
  "PhysicLerpSync",
}

return physics
