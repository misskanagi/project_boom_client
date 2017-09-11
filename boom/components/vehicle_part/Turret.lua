local Turret = Component.create("Turret")

function Turret:initialize(world, x, y)
    local m = love.physics.getMeter()
    self.world = world
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.CONTROLSTATE = {
      no_spin = -1,
      spin_positive = 0,
      spin_negative = 1,
    }
    --self.body:setUserData(self)

    -- turret spinner
    local shape = love.physics.newCircleShape(0.38*m)
    local fixture = love.physics.newFixture(self.body, shape, 0.5)

    -- turret cannon
    shape = love.physics.newRectangleShape(0, -0.5*m, 0.2*m, 1.0*m)
    fixture = love.physics.newFixture(self.body, shape, 0.2)

    -- speed
    self.spin_speed = 1
    self.spin_torque = 1000
end

function Turret:updateSpin(controlState)
    local desiredSpeed = 0
    local desiredTorque = 0
    local startSpin = false
    if controlState == self.CONTROLSTATE.spin_positive then
      startSpin = true
      desiredTorque = self.spin_torque
      desiredSpeed = self.spin_speed
    elseif controlState == self.CONTROLSTATE.spin_negative then
      startSpin = true
      desiredTorque = self.spin_torque
      desiredSpeed = -self.spin_speed
    end

    for _, joint in pairs(self.body:getJointList()) do
      if joint:typeOf("RevoluteJoint") then
          joint:setMaxMotorTorque(desiredTorque)
          joint:setMotorSpeed(desiredSpeed)
          joint:setMotorEnabled(startSpin)
      end
    end
end

return Turret
