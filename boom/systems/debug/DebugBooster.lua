local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugBooster = class("DebugBooster", System)

function DebugBooster:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    for k, entity in pairs(self.targets) do
        local booster = entity:get("Booster")
        local body = booster.body_to_boost
        local x2, y2 = body:getWorldVector(0, -booster.thrust_force)
        local x1, y1 = body:getWorldCenter()
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.line(x1, y1, x1+x2, y1+y2)
        love.graphics.setColor(255, 255, 255, 255)
    end
    --return to old canvas
    love.graphics.setCanvas(cvs)
end

function DebugBooster:requires()
    return {"Booster"}
end

return DebugBooster
