local Physic = require "boom.components.physic.Physic"
local CollisionCallbacks = require("boom.components.physic.CollisionCallbacks")
local events = require("boom.events")
local IsItem = require("boom.components.identifier.IsItem")
local Explosive = require("boom.components.vehicle.Explosive")
local PSM = require "boom.particle"

local createBloodSpringItem = function(x, y, r, world, light_world)
    local e = Entity()
    local w, h = image:getWidth(), image:getHeight()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "dynamic")
    body:setAngle(r)
    local meter = love.physics.getMeter()
    local shape = love.physics.newRectangleShape(3 * meter, 3 * meter)
    local fixture = love.physics.newFixture(body, shape)
    fixture:setSensor(true)
    e:add(IsItem())
    e:add(Explosive(sx, sy, -5, 3 * meter, PSM:createParticleSystem("heal_explosion")))
    e:add(Physic(body))
    e:add(CollisionCallbacks(
        function(that_entity, coll)
            if that_entity:has("IsPlayer") and that_entity:has("Health") then
                --[[local H = that_entity:get("Health")
                local max_value = H.max_value
                H.value = H.value + max_value * 0.05
                if H.value > max_value then
                  H.value = max_value
                end]]
                e:get("Explosive").is_exploded = true
                e:get("Explosive").explosion_ps:start()
            end
        end
    ))
    body:setUserData(e)
    return e
end
return createBloodSpringItem
