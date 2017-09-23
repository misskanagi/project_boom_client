local PolygonDraw = require "boom.systems.graphic.PolygonDraw"
local PlayerDraw = require "boom.systems.graphic.PlayerDraw"
local GunFireDraw = require "boom.systems.graphic.GunFireDraw"
local BoosterDraw = require "boom.systems.graphic.BoosterDraw"
local ExplosiveDraw = require "boom.systems.graphic.ExplosiveDraw"
local ImageDraw = require "boom.systems.graphic.ImageDraw"
local WreckageDraw = require "boom.systems.graphic.WreckageDraw"


local ShaderRefractionSync = require "boom.systems.graphic.ShaderRefractionSync"
local RefractionDraw = require "boom.systems.graphic.RefractionDraw"


local graphic = {
  PolygonDraw = PolygonDraw(),
  ExplosiveDraw = ExplosiveDraw(),
  BoosterDraw = BoosterDraw(),
  PlayerDraw = PlayerDraw(),
  GunFireDraw = GunFireDraw(),
  ImageDraw = ImageDraw(),
  WreckageDraw = WreckageDraw(),
  ShaderRefractionSync = ShaderRefractionSync(),
  --RefractionDraw = RefractionDraw(),
}

return graphic
