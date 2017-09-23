local PSM = require "boom.particle"
local Launchable = Component.create("Launchable")

function Launchable:initialize()
    self.cmd = {
      launch = false,
    }
    self.shell_name = "NormalShell"
    self.shell_count = 10
end

return Launchable
