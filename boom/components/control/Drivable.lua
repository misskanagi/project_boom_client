local Drivable = Component.create("Drivable")

function Drivable:initialize()
    self.cmd = {
      forward = false,
      backward = false,
      turn_left = false,
      turn_right = false,
      turret_spin_pos = false,
      turret_spin_neg = false,
      toggle_light = false,
    }
end

return Drivable
