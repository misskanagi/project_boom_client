local BoosterSync = class("BoosterSync", System)

function BoosterSync:update(dt)
    for index, entity in pairs(self.targets) do
        local booster = entity:get("Booster")
        local bfps = booster.booster_fire_ps
        bfps:update(dt)

        if booster.fuel > 0 then
            local body = booster.body_to_boost
            local force = -booster.thrust_force
            local nx, ny = body:getWorldVector(0, 1)
            local cx, cy = body:getWorldCenter()
            body:applyForce( force * nx, force * ny, cx, cy)
            booster.fuel = booster.fuel - booster.fuel_usage_per_sec * dt
            body:setMass(body:getMass() - booster.fuel_usage_per_sec * dt * booster.mass_per_unit_fuel)
            if bfps:isStopped() then
              bfps:start()
            end
        end
    end
end

function BoosterSync:requires()
    return {"Booster"}
end

return BoosterSync
