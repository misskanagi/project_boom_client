local KeyPressed = require("boom.events.KeyPressed")
local MousePressed = require("boom.events.MousePressed")
local KeyReleased = require("boom.events.KeyReleased")
local MouseReleased = require("boom.events.MouseReleased")
local NetKeyPressed = require("boom.events.NetKeyPressed")
local NetKeyReleased = require("boom.events.NetKeyReleased")
local SnapshotReceived = require("boom.events.SnapshotReceived")

local events = {
    KeyPressed = KeyPressed,
    MousePressed = MousePressed,
    KeyReleased = KeyReleased,
    MouseReleased = MouseReleased,
    NetKeyPressed = NetKeyPressed,
    NetKeyReleased = NetKeyReleased,
    SnapshotReceived = SnapshotReceived,
}
return events
