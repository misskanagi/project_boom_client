local ControllableSync = class("ControllableSync", System)

function ControllableSync:update(dt)
    for k, entity in pairs(self.targets) do
      local tire = entity:get("Tire")
      local turret = entity:get("Turret")
      local cmd = entity:get("Controllable").cmd
      if cmd.forward == true then
        tire:updateDrive(tire.CONTROLSTATE.forward)
      end

      if cmd.backward == true then
        tire:updateDrive(tire.CONTROLSTATE.backward)
      end

      if cmd.turn_left == true then
        tire:updateTurn(tire.CONTROLSTATE.left)
      end

      if cmd.turn_right == true then
        tire:updateTurn(tire.CONTROLSTATE.right)
      end

      if cmd.turret_spin_neg == true then
        turret:updateSpin(turret.CONTROLSTATE.spin_negative)
      elseif cmd.turret_spin_pos == true then
        turret:updateSpin(turret.CONTROLSTATE.spin_positive)
      else
        turret:updateSpin(turret.CONTROLSTATE.no_spin)
      end
    end
end

function ControllableSync:requires()
    return {"Controllable"}
end

return ControllableSync
