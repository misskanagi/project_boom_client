local Vector = require "libs.hump.vector"
local BoosterSync = class("BoosterSync", System)

local v = Vector(0, 0)

function BoosterSync:update(dt)
    for index, entity in pairs(self.targets) do
        local booster = entity:get("Booster")
        --init
        if not booster.init then
            booster.init_func()
        end
        local bfps = booster.booster_fire_ps
        bfps:update(dt)

        if booster.fuel > 0 then
            local body = booster.body_to_boost
            local force = -booster.thrust_force
            local nx, ny = body:getWorldVector(0, 1)
            local cx, cy = body:getWorldCenter()
            local ix, iy = 0, body:getMass() * booster.thrust_impulse_constant * -1
            v.x, v.y = ix, iy
            v:rotateInplace(body:getAngle())
            body:applyLinearImpulse( v.x, v.y, cx, cy)
            booster.fuel = booster.fuel - booster.fuel_usage_per_sec * dt
            body:setMass(body:getMass() - booster.fuel_usage_per_sec * dt * booster.mass_per_unit_fuel)
            if bfps:isStopped() then
              bfps:start()
            end
        else
            entity:remove("Booster")
        end
    end
end

function BoosterSync:requires()
    return {"Booster"}
end

return BoosterSync
