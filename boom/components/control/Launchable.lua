local PSM = require "boom.particle"
local Launchable = Component.create("Launchable")

function Launchable:initialize(light_world)
    self.cmd = {
      launch = false,
    }
end

return Launchable
