local Wreckage = require("boom.components.vehicle.Wreckage")

-- wreckage entity
local createDefaultWreckage = function(x, y)
    local e = Entity()
    e:add(Wreckage(x, y))
    return e
end
return createDefaultWreckage
