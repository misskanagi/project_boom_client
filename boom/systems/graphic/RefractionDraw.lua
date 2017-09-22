local RefractionDraw = class("RefractionDraw", System)

function RefractionDraw:draw()
 -- print("ShaderRefractionSync:draw()")
  for k, entity in pairs(self.targets) do
    local water = entity:get("ShaderRefraction").waterimg
    local refraction = entity:get("ShaderRefraction").refraction
    love.graphics.draw(water, refraction.x-refraction.ox, refraction.y-refraction.oy)
  end
end

function RefractionDraw:requires()
  return {"ShaderRefraction"}
end

return RefractionDraw