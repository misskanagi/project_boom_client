local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Position = require "boom.components.physic.Position"
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")

-- wall entity
local createLights = function(world, map, light_world, r, g, b, range)
    local lights = {}
    local objects = map.layers["light_object_layer"] and map.layers["light_object_layer"].objects or {}
    for _, o in pairs(objects) do
        local e = Entity()
        local sx, sy = o.x + o.width/2, o.y + o.height/2
        e:add(DrawablePolygon(world, sx, sy, o.width, o.height, "static", e, false))
        local body, fixture, shape = e:get("DrawablePolygon").body, e:get("DrawablePolygon").fixture, e:get("DrawablePolygon").shape
        e:add(Physic(body, fixture, shape))
        e:add(Position(sx, sx))
        local t = light_world and e:add(Light(light_world, sx, sy, 16))
        lights[#lights+1] = e
    end
    return lights
end
return createLights
