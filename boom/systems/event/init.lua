local KeyboardEvent = require "boom.systems.event.KeyboardEvent"

local KeyboardEvent = KeyboardEvent()
eventmanager:addListener("KeyPressed", KeyboardEvent, KeyboardEvent.fireEvent)
