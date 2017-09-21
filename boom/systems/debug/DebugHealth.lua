local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugHealth = class("DebugHealth", System)

function DebugHealth:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    local meter = love.physics.getMeter()
    for k, entity in pairs(self.targets) do
        local cx, cy = entity:get("Physic").body:getWorldCenter()
        love.graphics.setColor(255,255,255)
        love.graphics.print(("hp:%d"):format(entity:get("Health").value), cx, cy+meter/4)
    end
    --return to old canvas
    love.graphics.setCanvas(cvs)
end

function DebugHealth:requires()
    return {"Health", "Physic"}
end

return DebugHealth
