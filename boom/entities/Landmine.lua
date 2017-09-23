local Physic = require "boom.components.physic.Physic"
local DrawableImage = require("boom.components.graphic.DrawableImage")
local ShaderCircle = require("boom.components.graphic.ShaderCircle")
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")
local IsShell = require("boom.components.identifier.IsShell")
local Explosive = require("boom.components.vehicle.Explosive")
local Booster = require("boom.components.vehicle.Booster")
local CollisionCallbacks = require("boom.components.physic.CollisionCallbacks")
local events = require("boom.events")
local camera = require("boom.camera")
local AssetsManager = require("assets")
local PSM = require "boom.particle"

-- shell entity
local createLandmine = function(x, y, w, h, r, dmg, range, world, light_world, color)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "dynamic")
    --local shape = love.physics.newRectangleShape(w, h)
    local shape = love.physics.newRectangleShape(32, 32)
    local fixture = love.physics.newFixture(body, shape)
    local shell_color = color or {r=102, g=102, b=102}
    body:setAngle(r or 0)
    fixture:setSensor(true)
    e:add(DrawableImage(AssetsManager:instance().images.landmine, x, y, r))
    e:add(Explosive(sx, sy, dmg or 120, range or 3 * love.physics.getMeter(), PSM:createParticleSystem("landmine_explosion")))
    --e:add(Booster(body))
    e:add(Physic(body, nil, nil, nil, 0.01))
    --local t = light_world and e:add(ShaderPolygon(light_world, body))
    --local sg = light_world and e:add(Light(light_world, sx, sy, 4, nil, nil, nil, 80))
    e:add(IsShell())
    e:add(GlobalEntityId())
    e:add(CollisionCallbacks(
        function(that_entity, coll)
            if e:getParent() ~= that_entity and not e:get("Explosive").is_exploded then
                -- explode!
                local x1, y1 = body:getWorldCenter()
                local cx, cy = camera:position()
                e:get("Explosive").is_exploded = true
                e:get("Explosive").explosion_ps:start()
                local dist = math.sqrt(math.pow(x1-cx, 2) + math.pow(y1-cy, 2))
                local shake = 0
                if dist < 640 then shake = -(4.883e-05)*dist*dist + 25 end
                camera:instance():shake(shake, true)
                -- damage to every body
                local range = e:get("Explosive").range_radius
                local dmg = e:get("Explosive").damage
                for _, entity in pairs(e:get("Explosive").in_range_entity) do
                    local x2, y2 = entity:get("Physic").body:getWorldCenter()
                    local dist = math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
                    eventmanager:fireEvent(events.Damage(e, entity, dmg, dist, range))
                end
                --light_world:remove(e:get("Light").light)
            end
        end
    ))
    body:setUserData(e)
    return e
end
return createLandmine
