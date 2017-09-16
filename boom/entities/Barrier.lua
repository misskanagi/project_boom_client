local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local DrawableSTIObject = require("boom.components.graphic.DrawableSTIObject")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

local convex_hull = require("libs.cv.convex")

-- barrier entity
local createBarrier = function(object, map, world, light_world)
    local e = Entity()
    local o = object
    local other_objects = {}
    local is_multi_part = false
    if o.properties["is_multi_part"] then
      if not o.properties["is_main_part"] then return nil end
      is_multi_part = true
      for i=1,o.properties["other_parts_count"] do
        other_objects[#other_objects+1] = map.objects[o.properties[("other_parts_id_%d"):format(i)]]
      end
    end
    e:add(DrawableSTIObject(world, o, "dynamic", is_multi_part, other_objects))
    local body = e:get("DrawableSTIObject").body
    t = light_world and e:add(ShaderPolygon(light_world, body, 4))
    e:add(Physic(body))
    e:add(GlobalEntityId())
    return e
end
return createBarrier
