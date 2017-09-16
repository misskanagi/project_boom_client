local vector = require "libs.hump.vector"
local ShaderPolygon = Component.create("ShaderPolygon")

function ShaderPolygon:initialize(light_world, body, zheight)
    self.body = body
    self.shape_list = {}
    self.polygon_list = {}
    self.offsets = {}
    for _, fix in pairs(body:getFixtureList()) do
        local shape = fix:getShape()
        if shape:getType() == "polygon" then
          local points = {shape:getPoints()}
          local cx, cy = 0, 0
          for i=1,#points,2 do
            points[i] = math.floor(points[i])
            points[i+1] = math.floor(points[i+1])
            cx = cx + points[i]
            cy = cy + points[i+1]
          end
          cx, cy = cx/(#points/2), cy/(#points/2)
          self.offsets[#self.offsets+1] = vector(cx, cy)
          local polygon = light_world:newPolygon(body:getWorldPoints(unpack(points)))
          polygon:setZHeight(zheight or 1)
          self.polygon_list[#self.polygon_list+1] = polygon
          self.shape_list[#self.shape_list+1] = shape
        end
    end

end

return ShaderPolygon
