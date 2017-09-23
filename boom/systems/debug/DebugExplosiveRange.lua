local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugExplosiveRange = class("DebugExplosiveRange", System)

function DebugExplosiveRange:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    for k, entity in pairs(self.targets) do
        local body = entity:get("Physic").body
        local radius = entity:get("Explosive").range_radius
        local x1, y1 = body:getWorldCenter()
        for _, e in pairs(entity:get("Explosive").in_range_entity) do
            local target_body = e:get("Physic") and e:get("Physic").body or nil
            if target_body and not target_body:isDestroyed() then
                local x2, y2 = target_body:getWorldCenter()
                love.graphics.line(x1, y1, x2, y2)
            end
        end
        -- draw range
        love.graphics.circle("line", x1, y1, radius)
    end
    --return to old canvas
    love.graphics.setCanvas(cvs)
end

function DebugExplosiveRange:requires()
    return {"Explosive", "Physic"}
end

return DebugExplosiveRange
