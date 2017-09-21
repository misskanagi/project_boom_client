local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

-- light entity
local createLight = function(x, y, w, h, r, world, light_world, r, g, b, range)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    e:add(DrawablePolygon(world, sx, sy, w, h, "static", e, false))
    local body, fixture, shape = e:get("DrawablePolygon").body, e:get("DrawablePolygon").fixture, e:get("DrawablePolygon").shape
    e:add(Physic(body))
    local t = light_world and e:add(Light(light_world, sx, sy, 24))
    e:add(GlobalEntityId())
    return e
end

return createLight
