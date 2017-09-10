local PhysicsPositionSync = require "boom.systems.physics.PhysicsPositionSync"
local Friction = require "boom.systems.physics.Friction"

local physics = {
  PhysicsPositionSync = PhysicsPositionSync(),
  Friction = Friction(),
}

return physics
