local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

-- light entity
local createLight = function(object, world, light_world, r, g, b, range)
    local e = Entity()
    local o = object
    local sx, sy = o.x + o.width/2, o.y + o.height/2
    --e:add(DrawablePolygon(world, sx, sy, o.width, o.height, "static", e, false))
    --local body, fixture, shape = e:get("DrawablePolygon").body, e:get("DrawablePolygon").fixture, e:get("DrawablePolygon").shape
    --e:add(Physic(body))
    local t = light_world and e:add(Light(light_world, sx, sy, 24))
    e:add(GlobalEntityId())
    return e
end

return createLight
