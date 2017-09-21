local Physic = require "boom.components.physic.Physic"
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

-- shell entity
local createShell = function(x, y, w, h, r, world, light_world)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    e:add(Explosive(world, sx, sy, w, h, r))
    local body = e:get("Explosive").body
    e:add(Booster(body))
    e:add(Physic(body, nil, nil, nil, 0.01))
    --local t = light_world and e:add(ShaderPolygon(light_world, body))
    local sg = light_world and e:add(Light(light_world, sx, sy, 4, nil, nil, nil, 80))
    e:add(IsShell())
    e:add(GlobalEntityId())
    e:add(CollisionCallbacks(
        function(that_entity, coll)
            if e:getParent() ~= that_entity and not e:get("Explosive").is_exploded then
                -- explode!
                e:get("Explosive").is_exploded = true
                e:get("Explosive").explosion_ps:start()
                camera:instance():shake(20, true)
                -- damage to every body
                local x1, y1 = body:getWorldCenter()
                local range = e:get("Explosive").range_radius
                local dmg = e:get("Explosive").damage
                for _, entity in pairs(e:get("Explosive").in_range_entity) do
                    local x2, y2 = entity:get("Physic").body:getWorldCenter()
                    local dist = math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
                    eventmanager:fireEvent(events.Damage(e, entity, dmg, dist, range))
                end
                light_world:remove(e:get("Light").light)
            end
        end
    ))
    body:setUserData(e)
    return e
end
return createShell
