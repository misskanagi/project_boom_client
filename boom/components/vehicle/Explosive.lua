local PSM = require "boom.particle"
local Explosive = Component.create("Explosive")

function Explosive:initialize(x, y, dmg, range, ps)
    local meter = love.physics.getMeter()
    self.x = x
    self.y = y
    self.damage = dmg or 100
    self.range_radius = range or (5 * meter)
    self.explosion_ps = ps or PSM:createParticleSystem("explosion")
    self.in_range_entity = {}
    self.is_exploded = false
end

return Explosive
