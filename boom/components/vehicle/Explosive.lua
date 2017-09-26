local PSM = require "boom.particle"
local events = require "boom.events"
local Explosive = Component.create("Explosive")
local camera = require("boom.camera")

function Explosive:initialize(x, y, dmg, range, ps, exploded_sound, exploded_callback)
    local meter = love.physics.getMeter()
    self.x = x
    self.y = y
    self.damage = dmg or 100
    self.range_radius = range or (5 * meter)
    self.explosion_ps = ps or PSM:createParticleSystem("explosion")
    self.in_range_entity = {}
    self.is_exploded = false
    --self.exploded_sound = exploded_sound or assets.sound.landmine_explosion_2
    self.exploded_sound = exploded_sound or assets.sound.shell_normal_explosion
    self.exploded_callback_executed = false
    self.exploded_callback = function(src_entity)
        -- damage to every body
        local range = self.range_radius
        local dmg = self.damage
        local x1, y1 = self.x, self.y
        -- give shake
        if dmg > 0 then
            local cx, cy = camera:position()
            local dist = math.sqrt(math.pow(x1-cx, 2) + math.pow(y1-cy, 2))
            local shake = 0
            if dist < 640 then shake = -(4.883e-05)*dist*dist + 30 end
            camera:instance():shake(shake, true)
        end
        -- give damage
        for _, entity in pairs(self.in_range_entity) do
            local x2, y2 = entity:get("Physic").body:getWorldCenter()
            local dist = math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
            eventmanager:fireEvent(events.Damage(src_entity, entity, dmg, dist, range))
        end
    end
end

return Explosive
