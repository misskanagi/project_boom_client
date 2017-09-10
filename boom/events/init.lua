local KeyPressed = require("boom.events.KeyPressed")
local MousePressed = require("boom.events.MousePressed")
local KeyReleased = require("boom.events.KeyReleased")
local MouseReleased = require("boom.events.MouseReleased")

local events = {
    KeyPressed = KeyPressed,
    MousePressed = MousePressed,
    KeyReleased = KeyReleased,
    MouseReleased = MouseReleased,
}
return events
