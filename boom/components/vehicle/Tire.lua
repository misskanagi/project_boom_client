local Vector = require "libs.hump.vector"
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
    self.max_forward_speed = -120
    self.max_backward_speed = 100
    self.max_drive_force = 1000
    self.torque_force = 1000

    -- for impulse
    self.max_drive_impulse_constant = 10
    self.torque_impulse_constant = 20
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

local v = Vector(0, 0)

function Tire:updateDrive(controlState)
    local desiredSpeed = 0
    local direction = 0
    if controlState == self.CONTROLSTATE.forward then
      desiredSpeed = self.max_forward_speed
      direction = -1
    elseif controlState == self.CONTROLSTATE.backward then
      desiredSpeed = self.max_backward_speed
      direction = 1
    else
      return
    end

    local nx, ny = self.body:getWorldVector(0, 1)
    local sx, sy = self:getForwardVelocity()
    local cx, cy = self.body:getWorldCenter()
    local currentSpeed = nx*sx+ny*sy
    --local force = 0

    --[[if desiredSpeed > currentSpeed then
      force = self.max_drive_force
    elseif desiredSpeed < currentSpeed then
      force = -self.max_drive_force
    else
      return
    end]]

    if math.abs(desiredSpeed) < math.abs(currentSpeed) then
        direction = 0
    end

    local ix, iy = 0.0, self.body:getMass() * self.max_drive_impulse_constant * direction
    v.x, v.y = ix, iy
    v:rotateInplace(self.body:getAngle())
    --self.body:applyForce( force * nx, force * ny, cx, cy)
    self.body:applyLinearImpulse( v.x, v.y, cx, cy)
end

function Tire:updateTurn(controlState)
    --local desiredTorque = 0
    local direction = 0
    if controlState == self.CONTROLSTATE.left then
      --desiredTorque = -self.torque_force
      direction = -1
    elseif controlState == self.CONTROLSTATE.right then
      --desiredTorque = self.torque_force
      direction = 1
    end
    --self.body:applyAngularImpulse(desiredTorque)
    self.body:applyAngularImpulse(self.torque_impulse_constant * self.body:getMass() * direction)
end

return Tire
