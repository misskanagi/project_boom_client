local vector = require "libs.hump.vector"

local STIObjectSync = class("STIObjectSync", System)

function STIObjectSync:update(dt)
    for k, entity in pairs(self.targets) do
      local body = entity:get("DrawableSTIObject").body
      local objects = entity:get("DrawableSTIObject").objects
      local offsets = entity:get("DrawableSTIObject").offsets
      local cx, cy = body:getWorldCenter()
      local cr = body:getAngle()
      for i=1, #objects do
        local o = objects[i]
        offsets[i]:rotateInplace(cr-o.rotation)
        o.x = cx + offsets[i].x
        o.y = cy + offsets[i].y
        o.rotation = cr
        local tab = o.tab
        local batch = o.tab.batch
        batch:set(tab.id, tab.quad, o.x, o.y, cr,
                  tab.sx, tab.sy, o.width/2, o.height/2)
      end
    end
end

function STIObjectSync:requires()
    return {"DrawableSTIObject"}
end

return STIObjectSync
