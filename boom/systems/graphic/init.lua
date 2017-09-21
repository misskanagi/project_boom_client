local PolygonDraw = require "boom.systems.graphic.PolygonDraw"
local PlayerDraw = require "boom.systems.graphic.PlayerDraw"
local GunFireDraw = require "boom.systems.graphic.GunFireDraw"
local BoosterDraw = require "boom.systems.graphic.BoosterDraw"
local ExplosiveDraw = require "boom.systems.graphic.ExplosiveDraw"


local ShaderRefractionSync = require "boom.systems.graphic.ShaderRefractionSync"
local RefractionDraw = require "boom.systems.graphic.RefractionDraw"


local graphic = {
  PolygonDraw = PolygonDraw(),
  ExplosiveDraw = ExplosiveDraw(),
  PlayerDraw = PlayerDraw(),
  GunFireDraw = GunFireDraw(),
  ShaderRefractionSync = ShaderRefractionSync(),
  --RefractionDraw = RefractionDraw(),
}

return graphic
