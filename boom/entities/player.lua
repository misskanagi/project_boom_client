local Physic = require "boom.components.physic.Physic"
local Position = require "boom.components.physic.Position"
local IsPlayer = require "boom.components.identifier.IsPlayer"
local Controllable = require "boom.components.control.Controllable"
local Tire = require "boom.components.vehicle_part.Tire"
local Turret = require "boom.components.vehicle_part.Turret"
local ShaderCircle = require("boom.components.graphic.ShaderCircle")
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")

-- player entity
local createPlayer = function(world, map, light_world)
    local e
    for _, o in pairs(map.layers["dynamic_object_layer"].objects) do
        e = Entity()
        local sx, sy = o.x + o.width/2, o.y + o.height/2
        local tire = Tire(world, sx, sy)
        local turret = Turret(world, sx, sy)
        local cx, cy = tire.body:getWorldCenter()
        local revolute_joint = love.physics.newRevoluteJoint(
            tire.body, turret.body, cx, cy, false)
        e:add(tire)
        e:add(turret)
        e:add(Position(sx, sy))
        e:add(Physic(tire.body, tire.fixture, tire.shape, {turret.body}))
        t = light_world and e:add(ShaderPolygon(light_world, tire.body, tire.shape))
        sdt = light_world and e:add(Light(light_world, sx, sy, 2))
        e:get("Light").light:setAngle(math.pi/4)
        e:get("Light").light:setGlowStrength(1.0)
        e:add(IsPlayer())
        e:add(Controllable())
        tire.body:setUserData(e)
        break
    end
    return e
end
return createPlayer
