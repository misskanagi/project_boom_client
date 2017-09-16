local Light = Component.create("Light")

function Light:initialize(light_world, x, y, z, r, g, b, range, glow, meter)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 1
    self.r = r or 255
    self.g = g or 127
    self.b = b or 63
    self.range = range or 500
    self.meter = meter or 32
    -- new light
    self.light = light_world:newLight(x, y, r, g, b, range)
    self.light:setGlowStrength(glow or 0.3)
    self.light:setPosition(x, y ,z)
end

return Light
