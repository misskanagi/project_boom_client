local BoosterSync = class("BoosterSync", System)

function BoosterSync:update(dt)
    for index, entity in pairs(self.targets) do
        local booster = entity:get("Booster")
        local body = booster.body_to_boost
        local force = -booster.thrust_force
        local bfps = booster.booster_fire_ps
        local nx, ny = body:getWorldVector(0, 1)
        local sx, sy = body:getLinearVelocity()
        local cx, cy = body:getWorldCenter()
        local vx, vy = (nx*sx+ny*sy)*nx, (nx*sx+ny*sy)*ny
        body:applyForce( force * nx, force * ny, cx, cx)
        booster.fuel = booster.fuel - booster.fuel_usage_per_sec * dt
        if booster.fuel > 0 then
            body:setMass(body:getMass() - booster.fuel_usage_per_sec * dt * booster.mass_per_unit_fuel)
        end
        bfps:update(dt)
        if bfps:isStopped() then
          bfps:start()
        end
    end
end

function BoosterSync:requires()
    return {"Booster"}
end

return BoosterSync
