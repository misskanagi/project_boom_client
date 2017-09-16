local Controllable = Component.create("Controllable")

function Controllable:initialize()
    self.cmd = {
      forward = false,
      backward = false,
      turn_left = false,
      turn_right = false,
      turret_spin_pos = false,
      turret_spin_neg = false,
    }
end

return Controllable
