local Physic = require "boom.components.physic.Physic"
local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local ShaderCircle = require("boom.components.graphic.ShaderCircle")
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local IsShell = require("boom.components.identifier.IsShell")
local Explosive = require("boom.components.vehicle.Explosive")
local Booster = require("boom.components.vehicle.Booster")
local CollisionCallbacks = require("boom.components.physic.CollisionCallbacks")
local events = require("boom.events")
local camera = require("boom.camera")

-- shell entity
local createNormalShell = function(x, y, w, h, r, dmg, range, world, light_world, color)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "dynamic")
    local shape = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, shape)
    local shell_color = color or {r=102, g=102, b=153}
    body:setAngle(r or 0)
    fixture:setSensor(true)
    e:add(DrawablePolygon({body:getWorldPoints(shape:getPoints())}, shell_color, "fill"))
    e:add(Explosive(sx, sy, dmg, range))
    e:add(Booster(body))
    e:add(Physic(body, nil, nil, nil, 0.01))
    --local t = light_world and e:add(ShaderPolygon(light_world, body))
    local sg = light_world and e:add(Light(light_world, sx, sy, 4, nil, nil, nil, 80))
    e:add(IsShell())
    e:add(CollisionCallbacks(
        function(that_entity, coll)
            if e:getParent() ~= that_entity and not e:get("Explosive").is_exploded then
                -- explode!
                e:get("Explosive").is_exploded = true
                e:get("Explosive").explosion_ps:start()
                local x1, y1 = body:getWorldCenter()
                local cx, cy = camera:position()
                local dist = math.sqrt(math.pow(x1-cx, 2) + math.pow(y1-cy, 2))
                local shake = 0
                if dist < 640 then shake = -(4.883e-05)*dist*dist + 20 end
                camera:instance():shake(shake, true)
                -- remove light
                light_world:remove(e:get("Light").light)
            end
        end
    ))
    body:setUserData(e)
    return e
end
return createNormalShell
