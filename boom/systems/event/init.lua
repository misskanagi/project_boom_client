local KeyboardHandler = require "boom.systems.event.KeyboardHandler"
local NetKeyboardHandler = require "boom.systems.event.NetKeyboardHandler"
local SnapshotReceivedHandler = require "boom.systems.event.SnapshotReceivedHandler"
local CollisionHandler = require "boom.systems.event.CollisionHandler"
local DamageHandler = require "boom.systems.event.DamageHandler"
local EntityDestroyHandler = require "boom.systems.event.EntityDestroyHandler"

KeyboardHandler = KeyboardHandler()
NetKeyboardHandler = NetKeyboardHandler()
SnapshotReceivedHandler = SnapshotReceivedHandler()
CollisionHandler = CollisionHandler()
DamageHandler = DamageHandler()
EntityDestroyHandler = EntityDestroyHandler()

eventmanager:addListener("KeyPressed", KeyboardHandler, KeyboardHandler.firePressedEvent)
eventmanager:addListener("KeyReleased", KeyboardHandler, KeyboardHandler.fireReleasedEvent)
eventmanager:addListener("NetKeyPressed", NetKeyboardHandler, NetKeyboardHandler.fireNetPressedEvent)
eventmanager:addListener("NetKeyReleased", NetKeyboardHandler, NetKeyboardHandler.fireNetReleasedEvent)
eventmanager:addListener("SnapshotReceived", SnapshotReceivedHandler, SnapshotReceivedHandler.fireSnapshotReceived)
eventmanager:addListener("BeginContact", CollisionHandler, CollisionHandler.fireBeginContact)
eventmanager:addListener("EndContact", CollisionHandler, CollisionHandler.fireEndContact)
eventmanager:addListener("PreSolve", CollisionHandler, CollisionHandler.firePreSolve)
eventmanager:addListener("PostSolve", CollisionHandler, CollisionHandler.firePostSolve)
eventmanager:addListener("Damage", DamageHandler, DamageHandler.fireDamage)
eventmanager:addListener("EntityDestroy", EntityDestroyHandler, EntityDestroyHandler.fireEntityDestroy)

local event = {
  --KeyboardHandler = KeyboardHandler,
  --NetKeyboardHandler = NetKeyboardHandler,
  --CollisionHandler = CollisionHandler,
}

return event
