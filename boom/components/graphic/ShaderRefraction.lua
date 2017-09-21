local ShaderRefraction = Component.create("ShaderRefraction")
local refraction_normal = love.graphics.newImage("libs/light_world/examples/gfx/refraction_normal.png")
local water = love.graphics.newImage("libs/light_world/examples/gfx/water.png")

function ShaderRefraction:initialize(light_world, cx, cy,width, height, meter, zheight)
  print("ShaderRefraction:initialize()")
    self.meter = meter or 32
    self.refraction = light_world:newRefraction(refraction_normal,cx,cy,width,height)
    self.waterimg = water
    self.tileX = 0
    self.tileY = 0
    self.light_world = light_world
end

return ShaderRefraction