local Physic = require "boom.components.physic.Physic"
local Position = require "boom.components.physic.Position"
local IsPlayer = require "boom.components.identifier.IsPlayer"

-- player entity
local createPlayer = function(world, map)
    local e
    for _, o in pairs(map.layers["dynamic_object_layer"].objects) do
        e = Entity()
        e:add(Position(o.x, o.y))
        local body = love.physics.newBody(world, o.x, o.y, "dynamic")
        local shape = love.physics.newRectangleShape(o.width, o.height)
        local fixture = love.physics.newFixture(body, shape, 0)
        fixture:setUserData(e)
        fixture:setRestitution(1)
        body:setMass(2)
        e:add(Physic(body, fixture, shape))
        e:add(IsPlayer())
        break
    end
    return e
end
return createPlayer
