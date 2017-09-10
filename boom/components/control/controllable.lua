local Controllable = Component.create("Controllable")

function Controllable:initialize()
    self.cmd = {
      w = false,
      s = false,
      a = false,
      d = false,
      left = false,
      right = false,
    }
end

function Controllable:execute(body, entity)
    local tire = entity:get("Tire")
    local turret = entity:get("Turret")
    if self.cmd.w == true then
      --body:applyLinearImpulse( 0, -1 )
      tire:updateDrive(tire.CONTROLSTATE.forward)
    end

    if self.cmd.s == true then
      --body:applyLinearImpulse( 0, 1 )
      tire:updateDrive(tire.CONTROLSTATE.backward)
    end

    if self.cmd.a == true then
      --body:applyLinearImpulse( -1, 0 )
      tire:updateTurn(tire.CONTROLSTATE.left)
    end

    if self.cmd.d == true then
      --body:applyLinearImpulse( 1, 0 )
      tire:updateTurn(tire.CONTROLSTATE.right)
    end

    if self.cmd.left == true then
      --body:applyLinearImpulse( 1, 0 )
      turret:updateSpin(turret.CONTROLSTATE.spin_negative)
    elseif self.cmd.right == true then
      turret:updateSpin(turret.CONTROLSTATE.spin_positive)
    else
      turret:updateSpin(turret.CONTROLSTATE.no_spin)
    end

end

return Controllable
