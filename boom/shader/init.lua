local LightWorld = require("libs.light_world.lib")

-- init shadow body world from physics world
local createShader = function ()
  -- new light world
  local lightWorld = LightWorld({
    ambient = {55,55,55},
    refractionStrength = 32.0,
    reflectionVisibility = 0.75,
  })
  return lightWorld
end

return createShader
