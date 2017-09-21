local particle_canvas = require("boom.systems.graphic.particle_canvas")
local BoosterDraw = class("BoosterDraw", System)

function BoosterDraw:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(particle_canvas:getCanvas())
    for index, entity in pairs(self.targets) do
        local booster = entity:get("Booster")
        local body = booster.body_to_boost
        local cx, cy = body:getWorldPoint(0, 1.0 * love.physics.getMeter())
        local r = body:getAngle()
        love.graphics.draw(booster.booster_fire_ps, cx, cy, r+math.pi/2)
    end
    love.graphics.setCanvas(cvs)
end

function BoosterDraw:requires()
    return {"Booster"}
end

return BoosterDraw
