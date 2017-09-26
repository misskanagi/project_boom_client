local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")

-- light entity
local createLight = function(x, y, w, h, angle, world, light_world, r, g, b, range, height, glow)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "static")
    local shape = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, shape)
    body:setAngle(angle or 0)
    --e:add(DrawablePolygon({body:getWorldPoints(shape:getPoints())}, {r=r or 255, g=g or 255, b=b or 255}, "fill"))
    e:add(Physic(body))
    local t = light_world and e:add(Light(light_world, sx, sy, height or 24, r, g, b, range, glow))
    return e
end

return createLight
