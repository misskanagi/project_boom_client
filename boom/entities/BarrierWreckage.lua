local PSM = require "boom.particle"
local Wreckage = require("boom.components.vehicle.Wreckage")

-- barrier entity
local createBarrierWreckage = function(x, y)
    local e = Entity()
    e:add(Wreckage(x, y, PSM:createParticleSystem("barrier_wreckage")))
    return e
end
return createBarrierWreckage
