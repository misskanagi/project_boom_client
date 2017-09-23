local PSM = require "boom.particle"
local events = require "boom.events"
local Explosive = Component.create("Explosive")

function Explosive:initialize(x, y, dmg, range, ps, exploded_callback)
    local meter = love.physics.getMeter()
    self.x = x
    self.y = y
    self.damage = dmg or 100
    self.range_radius = range or (5 * meter)
    self.explosion_ps = ps or PSM:createParticleSystem("explosion")
    self.in_range_entity = {}
    self.is_exploded = false
    self.exploded_callback = function(src_entity)
        -- damage to every body
        local range = self.range_radius
        local dmg = self.damage
        for _, entity in pairs(self.in_range_entity) do
            local x1, y1 = self.x, self.y
            local x2, y2 = entity:get("Physic").body:getWorldCenter()
            local dist = math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
            eventmanager:fireEvent(events.Damage(src_entity, entity, dmg, dist, range))
        end
    end
end

return Explosive
