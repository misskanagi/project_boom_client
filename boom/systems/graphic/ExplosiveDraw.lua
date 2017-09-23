local particle_canvas = require("boom.systems.graphic.particle_canvas")
local ExplosiveDraw = class("ExplosiveDraw", System)

function ExplosiveDraw:draw()
    for index, entity in pairs(self.targets) do
        local exp = entity:get("Explosive")
        if exp.is_exploded then
            local cvs = love.graphics.getCanvas()
            love.graphics.setCanvas(particle_canvas:getCanvas())
            love.graphics.draw(exp.explosion_ps, exp.x, exp.y, 0, 1.618, 1.618)
            love.graphics.setCanvas(cvs)
        end
    end
end

function ExplosiveDraw:requires()
    return {"Explosive"}
end

return ExplosiveDraw
