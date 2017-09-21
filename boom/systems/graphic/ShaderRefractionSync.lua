local ShaderRefractionSync = class("ShaderRefractionSync", System)

function ShaderRefractionSync:update(dt)
  --print("ShaderRefractionSync:update(dt)")
  for k, entity in pairs(self.targets) do
    local tileX = entity:get("ShaderRefraction").tileX
    local tileY = entity:get("ShaderRefraction").tileY
    tileX = tileX + dt * 32.0
    tileY = tileY + dt * 8.0
    entity:get("ShaderRefraction").tileX = tileX
    entity:get("ShaderRefraction").tileY = tileY
    entity:get("ShaderRefraction").refraction:setNormalTileOffset(tileX, tileY)
    --entity:get("ShaderRefraction").light_world:update(dt)
  end
end

function ShaderRefractionSync:requires()
  --print("ShaderRefractionSync:requires()")
  return {"ShaderRefraction"}
end

return ShaderRefractionSync