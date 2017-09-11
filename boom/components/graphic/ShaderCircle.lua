local ShaderCircle = Component.create("ShaderCircle")

function ShaderCircle:initialize(light_world, body, shape, meter)
    self.body = body
    self.shape = shape
    self.meter = meter or 32
    local cx, cy = body:getWorldCenter()
    self.circle = light_world:newCircle(
      math.floor(cx), math.floor(cy), math.floor(shape:getRadius()*self.meter))
end

return ShaderCircle
