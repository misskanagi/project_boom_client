--实现水面效果
local ShaderRefraction = require("boom.components.graphic.ShaderRefraction")
--local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

local createWaters = function(x, y, w, h, r, world, light_world)
    --print("createWaters()")
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    e:add(ShaderRefraction(light_world, sx, sy, w, h))
    --e:add(GlobalEntityId())
    return e
end
return createWaters
