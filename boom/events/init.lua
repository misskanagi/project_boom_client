local KeyPressed = require("boom.events.KeyPressed")
local MousePressed = require("boom.events.MousePressed")
local KeyReleased = require("boom.events.KeyReleased")
local MouseReleased = require("boom.events.MouseReleased")
local NetKeyPressed = require("boom.events.NetKeyPressed")
local NetKeyReleased = require("boom.events.NetKeyReleased")
local SnapshotReceived = require("boom.events.SnapshotReceived")
local LoginRes = require("boom.events.LoginRes")
local CreateRoomRes = require("boom.events.CreateRoomRes")
local EnterRoomBroadcast = require("boom.events.EnterRoomBroadcast")
local EnterRoomRes = require("boom.events.EnterRoomRes")
local GameBeginBroadcast = require("boom.events.GameBeginBroadcast")
local GameCancelReadyBroadcast = require("boom.events.GameCancelReadyBroadcast")
local GameReadyBroadcast = require("boom.events.GameReadyBroadcast")
local GetRoomListRes = require("boom.events.GetRoomListRes")
local QuitRoomBroadcast = require("boom.events.QuitRoomBroadcast")

local events = {
    KeyPressed = KeyPressed,
    MousePressed = MousePressed,
    KeyReleased = KeyReleased,
    MouseReleased = MouseReleased,
    NetKeyPressed = NetKeyPressed,
    NetKeyReleased = NetKeyReleased,
    SnapshotReceived = SnapshotReceived,
    LoginRes = LoginRes,
    CreateRoomRes = CreateRoomRes,
    EnterRoomBroadcast = EnterRoomBroadcast,
    EnterRoomRes = EnterRoomRes,
    GameBeginBroadcast = LoginRes,
    GameCancelReadyBroadcast = GameCancelReadyBroadcast,
    GameReadyBroadcast = GameReadyBroadcast,
    GetRoomListRes = GetRoomListRes,
    QuitRoomBroadcast = QuitRoomBroadcast,
}
return events
