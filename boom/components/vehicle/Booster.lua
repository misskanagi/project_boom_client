local PSM = require "boom.particle"
local Booster = Component.create("Booster")

function Booster:initialize(body, thrust_force)
    self.body_to_boost = body
    self.fuel = 200
    self.mass_per_unit_fuel = 0.025
    self.fuel_usage_per_sec = 20
    -- add fuel
    self.init = false
    self.init_func = function()
        if not self.init then
          self.body_to_boost:setMass(self.body_to_boost:getMass() + self.fuel * self.mass_per_unit_fuel)
          self.init = true
        end
    end
    self.thrust_force = thrust_force or 2000
    self.booster_fire_ps = PSM:createParticleSystem("booster_fire")
    local cx, cy = body:getWorldCenter()
    self.x = cx
    self.y = cy
end

return Booster
