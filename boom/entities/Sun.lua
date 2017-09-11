local Light = require("boom.components.graphic.Light")

-- sun entity
local createSun = function(map, light_world)
    local sun
    local w, h = map.width*map.tilewidth, map.height*map.tileheight
    local e = Entity()
    local r, g, b = 255, 127, 63
    local z = 10000
    local range = math.max(w, h)*1.5
    local glow = 0.85
    e:add(Light(light_world, w/2, h/2, z, r, g, b, range, glow))
    return e
end
return createSun
