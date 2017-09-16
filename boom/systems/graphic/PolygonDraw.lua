local PolygonDraw = class("PolygonDraw", System)

function PolygonDraw:draw()
    for index, entity in pairs(self.targets) do
        if entity:get("DrawablePolygon").visible then
          --love.graphics.setColor(255, 0, 0, 128)
          love.graphics.polygon("fill", entity:get("DrawablePolygon").body:getWorldPoints(
              entity:get("DrawablePolygon").shape:getPoints()))
        end
    end
end

function PolygonDraw:requires()
    return {"DrawablePolygon"}
end

return PolygonDraw
