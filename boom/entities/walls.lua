local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Position = require "boom.components.physic.Position"
local Physic = require "boom.components.physic.Physic"

-- wall entity
local createWalls = function(world, map)
    local walls = {}
    for _, o in pairs(map.layers["static_object_layer"].objects) do
        local e = Entity()
        local sx, sy = o.x + o.width/2, o.y + o.height/2
        e:add(DrawablePolygon(world, sx, sy, o.width, o.height, "static", e, false))
        local body, fixture, shape = e:get("DrawablePolygon").body, e:get("DrawablePolygon").fixture, e:get("DrawablePolygon").shape
        e:add(Physic(body, fixture, shape))
        e:add(Position(sx, sx))
        walls[#walls+1] = e
    end
    return walls
end
return createWalls
