local PolygonDraw = require "boom.systems.graphic.PolygonDraw"
local PlayerDraw = require "boom.systems.graphic.PlayerDraw"

local graphic = {
  PolygonDraw = PolygonDraw(),
  PlayerDraw = PlayerDraw(),
}

return graphic
