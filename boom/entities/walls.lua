local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Position = require "boom.components.physic.Position"

-- wall entity
local createWalls = function(world, map)
    local walls = {}
    for _, o in pairs(map.layers["static_object_layer"].objects) do
        if o.properties["collidable"] then
            local e = Entity()
            e:add(DrawablePolygon(world, o.x, o.y, o.width, o.height, "static", e, false))
            e:add(Position(x, y))
            walls[#walls+1] = e
        end
    end
    return walls
end
return createWalls
