local PSM = require "boom.particle"
local Physic = require "boom.components.physic.Physic"
local DrawablePolygon = require "boom.components.graphic.DrawablePolygon"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local IsShell = require("boom.components.identifier.IsShell")
local Explosive = require("boom.components.vehicle.Explosive")
local Booster = require("boom.components.vehicle.Booster")
local CollisionCallbacks = require("boom.components.physic.CollisionCallbacks")
local events = require("boom.events")
local camera = require("boom.camera")

-- shell entity
local createHealShell = function(x, y, w, h, r, heal, range, world, light_world)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "dynamic")
    local shape = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, shape)
    local heal_to_dmg = heal or 100
    --print(heal_to_dmg)
    body:setAngle(r or 0)
    fixture:setSensor(true)
    e:add(DrawablePolygon({body:getWorldPoints(shape:getPoints())}, {r=0, g=255, b=0}, "fill"))
    e:add(Explosive(sx, sy, -heal_to_dmg, range, PSM:createParticleSystem("heal_explosion"), assets.sound.shell_heal_explosion))
    e:add(Booster(body))
    e:add(Physic(body, nil, nil, nil, 0.01))
    --local t = light_world and e:add(ShaderPolygon(light_world, body))
    local sg = light_world and e:add(Light(light_world, sx, sy, 4, nil, nil, nil, 80))
    e:add(IsShell())
    e:add(CollisionCallbacks(
        function(that_entity, coll)
            if e:getParent() ~= that_entity and not e:get("Explosive").is_exploded then
                -- explode!
                local body = e:get("Physic").body
                e:remove("Booster")
                body:setLinearVelocity(0, 0)
                e:get("Explosive").is_exploded = true
                e:get("Explosive").explosion_ps:start()
                --camera:instance():shake(20, true)
                light_world:remove(e:get("Light").light)
            end
        end
    ))
    body:setUserData(e)
    return e
end
return createHealShell
