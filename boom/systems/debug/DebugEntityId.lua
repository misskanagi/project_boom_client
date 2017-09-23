local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugEntityId = class("DebugEntityId", System)

function DebugEntityId:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    local meter = love.physics.getMeter()
    for k, entity in pairs(self.targets) do
        local body = entity:get("Physic").body
        local cx, cy = body:getWorldCenter()
        local id = entity:get("EntityId").id
        love.graphics.setColor(255,255,255)
        love.graphics.print(("gid:%d"):format(id), cx, cy-meter/4)
    end
    --return to old canvas
    love.graphics.setCanvas(cvs)
end

function DebugEntityId:requires()
    return {"EntityId", "Physic"}
end

return DebugEntityId
