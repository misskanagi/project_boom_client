local DrawablePolygon = require("boom.components.graphic.DrawablePolygon")
local Physic = require "boom.components.physic.Physic"
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local DrawableSTIObject = require("boom.components.graphic.DrawableSTIObject")
local EntityId = require("boom.components.identifier.EntityId")
local Explosive = require("boom.components.vehicle.Explosive")
local HasWreckage = require("boom.components.identifier.HasWreckage")

local Health = require("boom.components.logic.Health")

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
    local cx, cy = body:getWorldCenter()
    e:add(HasWreckage("BarrierWreckage"))
    e:add(Physic(body))
    e:add(Health(20))
    -- global entity id
    e:add(EntityId(object.id))
    body:setUserData(e)
    return e
end
return createBarrier
