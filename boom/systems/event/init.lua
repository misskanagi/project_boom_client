local KeyboardHandler = require "boom.systems.event.KeyboardHandler"
local NetKeyboardHandler = require "boom.systems.event.NetKeyboardHandler"
local SnapshotReceivedHandler = require "boom.systems.event.SnapshotReceivedHandler"

local KeyboardHandler = KeyboardHandler()
local NetKeyboardHandler = NetKeyboardHandler()
local SnapshotReceivedHandler = SnapshotReceivedHandler()

eventmanager:addListener("KeyPressed", KeyboardHandler, KeyboardHandler.firePressedEvent)
eventmanager:addListener("KeyReleased", KeyboardHandler, KeyboardHandler.fireReleasedEvent)
eventmanager:addListener("NetKeyPressed", NetKeyboardHandler, NetKeyboardHandler.fireNetPressedEvent)
eventmanager:addListener("NetKeyReleased", NetKeyboardHandler, NetKeyboardHandler.fireNetReleasedEvent)
eventmanager:addListener("SnapshotReceived", SnapshotReceivedHandler, SnapshotReceivedHandler.fireSnapshotReceived)

local event = {
  --KeyboardHandler = KeyboardHandler,
  --NetKeyboardHandler = NetKeyboardHandler,
}

return event
