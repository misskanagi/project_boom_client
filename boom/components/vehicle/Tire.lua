local Tire = Component.create("Tire")

function Tire:initialize(world, x, y)
    local m = love.physics.getMeter()
    self.world = world
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.CONTROLSTATE = {
      forward = 0,
      backward = 1,
      left = 2,
      right = 3,
    }
    self.shape = love.physics.newRectangleShape(1*m, 1.618*m)
    self.fixture = love.physics.newFixture(self.body, self.shape, 0.5)
    --self.body:setUserData(self)
    -- speed
    self.max_forward_speed = -150
    self.max_backward_speed = 120
    self.max_drive_force = 1200
    self.torque_force = 1000
end

function Tire:getLateralVelocity()
    local nx, ny = self.body:getWorldVector(1, 0)
    local sx, sy = self.body:getLinearVelocity()
    return (nx*sx+ny*sy)*nx, (nx*sx+ny*sy)*ny
end

function Tire:getForwardVelocity()
    local nx, ny = self.body:getWorldVector(0, 1)
    local sx, sy = self.body:getLinearVelocity()
    return (nx*sx+ny*sy)*nx, (nx*sx+ny*sy)*ny
end

function Tire:updateDrive(controlState)
    local desiredSpeed = 0
    if controlState == self.CONTROLSTATE.forward then
      desiredSpeed = self.max_forward_speed
    elseif controlState == self.CONTROLSTATE.backward then
      desiredSpeed = self.max_backward_speed
    else
      return
    end

    local nx, ny = self.body:getWorldVector(0, 1)
    local sx, sy = self:getForwardVelocity()
    local cx, cy = self.body:getWorldCenter()
    local currentSpeed = nx*sx+ny*sy
    local force = 0

    if desiredSpeed > currentSpeed then
      force = self.max_drive_force
    elseif desiredSpeed < currentSpeed then
      force = -self.max_drive_force
    else
      return
    end

    self.body:applyForce( force * nx, force * ny, cx, cy)
end

function Tire:updateTurn(controlState)
    local desiredTorque = 0
    if controlState == self.CONTROLSTATE.left then
      desiredTorque = -self.torque_force
    elseif controlState == self.CONTROLSTATE.right then
      desiredTorque = self.torque_force
    end
    self.body:applyTorque(desiredTorque)
end

return Tire
