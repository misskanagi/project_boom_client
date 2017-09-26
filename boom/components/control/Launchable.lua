local PSM = require "boom.particle"
local Launchable = Component.create("Launchable")

function Launchable:initialize()
    self.cmd = {
      launch = false,
    }
    self.shell_name = "NormalShell"
    self.shell_count = 10
    self.cool_down_time = 1
    self.need_cool_down = false
    self.launch_sound = assets.sound.shell_normal_launch
end

return Launchable
