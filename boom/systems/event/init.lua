local KeyboardHandler = require "boom.systems.event.KeyboardHandler"
local MouseHandler = require "boom.systems.event.MouseHandler"
local GamepadHandler = require "boom.systems.event.GamepadHandler"
local NetKeyboardHandler = require "boom.systems.event.NetKeyboardHandler"
local NetMouseHandler = require "boom.systems.event.NetMouseHandler"
local NetGamepadHandler = require "boom.systems.event.NetGamepadHandler"
local SnapshotReceivedHandler = require "boom.systems.event.SnapshotReceivedHandler"
local CollisionHandler = require "boom.systems.event.CollisionHandler"
local DamageHandler = require "boom.systems.event.DamageHandler"

local KeyboardHandler = KeyboardHandler()
local MouseHandler = MouseHandler()
local GamepadHandler = GamepadHandler()
local NetKeyboardHandler = NetKeyboardHandler()
local NetMouseHandler = NetMouseHandler()
local NetGamepadHandler = NetGamepadHandler()
local SnapshotReceivedHandler = SnapshotReceivedHandler()
local CollisionHandler = CollisionHandler()
local DamageHandler = DamageHandler()

eventmanager:addListener("KeyPressed", KeyboardHandler, KeyboardHandler.firePressedEvent)
eventmanager:addListener("MouseMoved", MouseHandler, MouseHandler.fireMovedEvent)
eventmanager:addListener("GamepadRightStickMoved", GamepadHandler, GamepadHandler.fireRightStickMovedEvent)
eventmanager:addListener("KeyReleased", KeyboardHandler, KeyboardHandler.fireReleasedEvent)
eventmanager:addListener("GamepadPressed", GamepadHandler, GamepadHandler.firePressedEvent)
eventmanager:addListener("GamepadReleased", GamepadHandler, GamepadHandler.fireReleasedEvent)
eventmanager:addListener("NetKeyPressed", NetKeyboardHandler, NetKeyboardHandler.fireNetPressedEvent)
eventmanager:addListener("NetKeyReleased", NetKeyboardHandler, NetKeyboardHandler.fireNetReleasedEvent)
eventmanager:addListener("NetMouseMoved", NetMouseHandler, NetMouseHandler.fireNetMouseMovedEvent)
eventmanager:addListener("NetGamepadPressed", NetGamepadHandler, NetGamepadHandler.fireNetPressedEvent)
eventmanager:addListener("NetGamepadReleased", NetGamepadHandler, NetGamepadHandler.fireNetReleasedEvent)
eventmanager:addListener("SnapshotReceived", SnapshotReceivedHandler, SnapshotReceivedHandler.fireSnapshotReceived)
eventmanager:addListener("BeginContact", CollisionHandler, CollisionHandler.fireBeginContact)
eventmanager:addListener("EndContact", CollisionHandler, CollisionHandler.fireEndContact)
eventmanager:addListener("PreSolve", CollisionHandler, CollisionHandler.firePreSolve)
eventmanager:addListener("PostSolve", CollisionHandler, CollisionHandler.firePostSolve)
eventmanager:addListener("Damage", DamageHandler, DamageHandler.fireDamage)

local event = {
  --KeyboardHandler = KeyboardHandler,
  --NetKeyboardHandler = NetKeyboardHandler,
  --CollisionHandler = CollisionHandler,
  GamepadHandler = GamepadHandler,
  MouseHandler = MouseHandler,
}

return event
