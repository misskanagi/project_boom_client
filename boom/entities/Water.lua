--实现水面效果
local ShaderRefraction = require("boom.components.graphic.ShaderRefraction")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")

local createWaters = function(object, world, light_world)
    print("createWaters()")
    local e = Entity()
    local o = object
    local sx, sy = o.x + o.width/2, o.y + o.height/2
    e:add(ShaderRefraction(light_world, sx, sy, o.width, o.height))
    e:add(GlobalEntityId())
    return e
end
return createWaters
