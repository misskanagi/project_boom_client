local vector = require("libs.hump.vector")
local DrawableSTIObject = Component.create("DrawableSTIObject")

-- 注意！！！，tile object的x, y和shape object的x, y不一样！！！！！！！！！！！！！！！！
function DrawableSTIObject:initialize(world, object, type, multipart, other_objects)
    local cx, cy = 0, 0
    self.objects = {}
    self.objects[#self.objects+1] = object
    self.offsets = {}
    self.map = map
    if multipart then
      for _, o in pairs(other_objects) do
        self.objects[#self.objects+1] = o
      end
    end
    -- calculate center points
    for _,o in pairs(self.objects) do
      cx, cy = cx+o.x+o.width/2, cy+o.y-o.height/2
    end
    cx, cy = cx/#self.objects, cy/#self.objects
    self.body = love.physics.newBody(world, cx, cy, type or "static")
    -- build physic shape
    for _,o in pairs(self.objects) do
      local ox, oy = o.x-cx+o.width/2, o.y-cy-o.height/2
      local shape = love.physics.newRectangleShape(ox, oy, o.width, o.height)
      local fixture = love.physics.newFixture(self.body, shape)
      self.offsets[#self.offsets+1] = vector(ox, oy)
    end
end

return DrawableSTIObject
