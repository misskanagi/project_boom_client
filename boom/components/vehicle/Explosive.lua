local PSM = require "boom.particle"
local Explosive = Component.create("Explosive")

function Explosive:initialize(world, x, y, w, h, r, dmg, range)
    local meter = love.physics.getMeter()
    self.damage = dmg or 100
    self.range_radius = range or (5 * meter)
    self.body = love.physics.newBody(world, x or 0, y or 0, "dynamic")
    self.body:setAngle(r or 0)
    self.shape = love.physics.newRectangleShape(w or 0.3 * meter, h or 1.0 * meter)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setSensor(true)
    self.explosion_ps = PSM:createParticleSystem("explosion")
    self.in_range_entity = {}
    self.is_exploded = false
end

return Explosive
