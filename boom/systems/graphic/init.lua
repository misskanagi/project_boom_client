local PolygonDraw = require "boom.systems.graphic.PolygonDraw"
local PlayerDraw = require "boom.systems.graphic.PlayerDraw"
local GunFireDraw = require "boom.systems.graphic.GunFireDraw"

local ShaderPolygonSync = require "boom.systems.graphic.ShaderPolygonSync"
local ShaderCircleSync = require "boom.systems.graphic.ShaderCircleSync"
local LightControl = require "boom.systems.graphic.LightControl"
local LightPhysicSync = require "boom.systems.graphic.LightPhysicSync"
local STIObjectSync = require "boom.systems.graphic.STIObjectSync"

local graphic = {
  PolygonDraw = PolygonDraw(),
  PlayerDraw = PlayerDraw(),
  GunFireDraw = GunFireDraw(),
  ShaderPolygonSync = ShaderPolygonSync(),
  ShaderCircleSync = ShaderCircleSync(),
  LightControl = LightControl(),
  LightPhysicSync = LightPhysicSync(),
  STIObjectSync = STIObjectSync(),
}

return graphic
