local KeyboardEvent = require "boom.systems.event.KeyboardEvent"

local KeyboardEvent = KeyboardEvent()
eventmanager:addListener("KeyPressed", KeyboardEvent, KeyboardEvent.firePressedEvent)
eventmanager:addListener("KeyReleased", KeyboardEvent, KeyboardEvent.fireReleasedEvent)

local event = {
  KeyboardEvent = KeyboardEvent
}

return event
