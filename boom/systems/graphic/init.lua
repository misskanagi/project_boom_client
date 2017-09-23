local PolygonDraw = require "boom.systems.graphic.PolygonDraw"
local PlayerDraw = require "boom.systems.graphic.PlayerDraw"
local GunFireDraw = require "boom.systems.graphic.GunFireDraw"
local BoosterDraw = require "boom.systems.graphic.BoosterDraw"
local ExplosiveDraw = require "boom.systems.graphic.ExplosiveDraw"
local ImageDraw = require "boom.systems.graphic.ImageDraw"
local WreckageDraw = require "boom.systems.graphic.WreckageDraw"

local graphic = {
  PolygonDraw = PolygonDraw(),
  ExplosiveDraw = ExplosiveDraw(),
  PlayerDraw = PlayerDraw(),
  GunFireDraw = GunFireDraw(),
  BoosterDraw = BoosterDraw(),
  ImageDraw = ImageDraw(),
  WreckageDraw = WreckageDraw(),
}

return graphic
