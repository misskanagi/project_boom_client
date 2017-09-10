local Physic = require "boom.components.physic.Physic"
local Position = require "boom.components.physic.Position"
local IsPlayer = require "boom.components.identifier.IsPlayer"
local Controllable = require "boom.components.control.Controllable"
local Tire = require "boom.components.vehicle_part.Tire"
local Turret = require "boom.components.vehicle_part.Turret"

-- player entity
local createPlayer = function(world, map)
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
        e:add(IsPlayer())
        e:add(Controllable())
        break
    end
    return e
end
return createPlayer
