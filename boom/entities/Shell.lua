local Physic = require "boom.components.physic.Physic"
local ShaderCircle = require("boom.components.graphic.ShaderCircle")
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")
local IsShell = require("boom.components.identifier.IsShell")
local Explosive = require("boom.components.vehicle.Explosive")
local Booster = require("boom.components.vehicle.Booster")
local CollisionCallbacks = require("boom.components.physic.CollisionCallbacks")

-- shell entity
local createShell = function(x, y, w, h, world, light_world)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    e:add(Explosive(world, sx, sy, w, h))
    local body = e:get("Explosive").body
    e:add(Booster(body))
    e:add(Physic(body))
    --local t = light_world and e:add(ShaderPolygon(light_world, body))
    local sg = light_world and e:add(Light(light_world, sx, sy, 4, nil, nil, nil, 80))
    e:add(IsShell())
    e:add(GlobalEntityId())
    e:add(CollisionCallbacks(
        function(that_entity, coll)
            e:get("Explosive").is_exploded = true
            e:get("Explosive").explosion_ps:start()
        end
    ))
    body:setUserData(e)
    return e
end
return createShell
