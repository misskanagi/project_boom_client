local PSM = require "boom.particle"
local Wreckage = Component.create("Wreckage")

function Wreckage:initialize(x, y, ps)
    self.x = x
    self.y = y
    self.wreckage_ps = ps or PSM:createParticleSystem("default_wreckage")
    self.wreckage_ps:start()
end

return Wreckage
