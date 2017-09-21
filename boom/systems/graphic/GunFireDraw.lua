local particle_canvas = require("boom.systems.graphic.particle_canvas")
local GunFireDraw = class("GunFireDraw", System)

function GunFireDraw:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(particle_canvas:getCanvas())
    for index, entity in pairs(self.targets) do
        local cmd = entity:get("Firable").cmd
        local fps = entity:get("Firable").fire_ps
        local turret_body = entity:get("Turret").body
        local cx, cy = turret_body:getWorldCenter()
        local r = turret_body:getAngle()
        if cmd.fire == true then
            love.graphics.draw(fps, cx, cy, r-math.pi/2, 1, 1, -32, 0)
        end
        -- hit
        if entity:get("Firable").hit_active > 0 then
            local fire = entity:get("Firable")
            for i = 1, fire.hit_max, 1 do
                local x, y, r = fire.all_hit_pos[i].x, fire.all_hit_pos[i].y,
                                fire.all_hit_pos[i].r
                if x then
                    love.graphics.draw(fire.all_hit_ps[i], x, y, r)
                end
            end
        end
    end
    love.graphics.setCanvas(cvs)
end

function GunFireDraw:requires()
    return {"Firable", "Turret"}
end

return GunFireDraw
