local particle_canvas = require("boom.systems.graphic.particle_canvas")
local ExplosiveDraw = class("ExplosiveDraw", System)

function ExplosiveDraw:draw()
    for index, entity in pairs(self.targets) do
        local exp = entity:get("Explosive")
        local body = exp.body
        if not exp.is_exploded then
            for _, fix in pairs(body:getFixtureList()) do
              local shape = fix:getShape()
              love.graphics.setColor(255, 89, 67)
              love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
              love.graphics.setColor(255, 255, 255)
            end
        else
            local cvs = love.graphics.getCanvas()
            love.graphics.setCanvas(particle_canvas:getCanvas())
            local cx, cy = body:getWorldCenter()
            love.graphics.draw(exp.explosion_ps, cx, cy)
            love.graphics.setCanvas(cvs)
        end
    end
end

function ExplosiveDraw:requires()
    return {"Explosive"}
end

return ExplosiveDraw
