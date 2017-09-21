local PSM = require "boom.particle"
local Booster = Component.create("Booster")

function Booster:initialize(body)
    self.body_to_boost = body
    self.fuel = 200
    self.mass_per_unit_fuel = 0.025
    self.fuel_usage_per_sec = 20
    -- add fuel
    self.body_to_boost:setMass(self.body_to_boost:getMass() + self.fuel * self.mass_per_unit_fuel)
    self.thrust_force = 200
    self.booster_fire_ps = PSM:createParticleSystem("booster_fire")
    local cx, cy = body:getWorldCenter()
    self.x = cx
    self.y = cy
end

return Booster
