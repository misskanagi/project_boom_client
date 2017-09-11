local ShaderPolygon = Component.create("ShaderPolygon")

function ShaderPolygon:initialize(light_world, body, shape)
    self.body = body
    self.shape = shape
    local points = {shape:getPoints()}
    for i=1,#points do
      points[i] = math.floor(points[i])
    end
    self.polygon = light_world:newPolygon(body:getWorldPoints(unpack(points)))
end

return ShaderPolygon
