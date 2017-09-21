local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugGlobalEntityId = class("DebugGlobalEntityId", System)

function DebugGlobalEntityId:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    for k, entity in pairs(self.targets) do
        local body = entity:get("Physic").body
        local cx, cy = body:getWorldCenter()
        local id = entity:get("GlobalEntityId").id
        love.graphics.setColor(255,255,255)
        love.graphics.print(("gid:%d"):format(id), cx, cy)
    end
    --return to old canvas
    love.graphics.setCanvas(cvs)
end

function DebugGlobalEntityId:requires()
    return {"GlobalEntityId", "Physic"}
end

return DebugGlobalEntityId
