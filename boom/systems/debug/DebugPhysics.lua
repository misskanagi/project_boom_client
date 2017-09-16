local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugPhysics = class("DebugPhysics", System)

function DebugPhysics:draw()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    for k, entity in pairs(self.targets) do
        local body = entity:get("Physic").body
        for _, fix in pairs(body:getFixtureList()) do
          local shape = fix:getShape()
          if shape:getType() == "polygon" then
            love.graphics.setColor(255,0,0)
            love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
            love.graphics.setColor(255,255,255)
          end
        end
    end
    --return to old canvas
    love.graphics.setCanvas()
end

function DebugPhysics:requires()
    return {"Physic"}
end

return DebugPhysics
