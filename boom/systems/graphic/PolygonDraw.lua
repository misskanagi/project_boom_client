local PolygonDraw = class("PolygonDraw", System)

function PolygonDraw:draw()
    for index, entity in pairs(self.targets) do
        local rec = entity:get("DrawablePolygon")
        love.graphics.setColor(rec.color.r, rec.color.g, rec.color.b)
        if #rec.points > 0 then
            love.graphics.polygon(rec.mode, unpack(rec.points))
        end
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function PolygonDraw:requires()
    return {"DrawablePolygon"}
end

return PolygonDraw
