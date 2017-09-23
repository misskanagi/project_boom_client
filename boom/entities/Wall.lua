local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

-- wall entity
local createWalls = function(x, y, w, h, r, world, light_world)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "static")
    local shape = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, shape)
    body:setAngle(r or 0)
    t = light_world and e:add(ShaderPolygon(light_world, body, 4))
    e:add(Physic(body))
    e:add(GlobalEntityId())
    body:setUserData(e)
    return e
end
return createWalls
