local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

-- wall entity
local createWalls = function(x, y, w, h, world, light_world)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    e:add(DrawablePolygon(world, sx, sy, w, h, "static", e, false))
    local body, fixture, shape = e:get("DrawablePolygon").body, e:get("DrawablePolygon").fixture, e:get("DrawablePolygon").shape
    t = light_world and e:add(ShaderPolygon(light_world, body, 4))
    e:add(Physic(body))
    e:add(GlobalEntityId())
    body:setUserData(e)
    return e
end
return createWalls
