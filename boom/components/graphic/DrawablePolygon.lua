local DrawablePolygon = Component.create("DrawablePolygon")

function DrawablePolygon:initialize(points, color, mode)
    self.points = points or {}
    self.color = color or {r=255, g=255, b=255}
    self.mode = mode or "fill"
end

return DrawablePolygon
