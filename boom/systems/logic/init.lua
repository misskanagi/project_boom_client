local HealthSync = require "boom.systems.logic.HealthSync"
local WreckageSync = require "boom.systems.logic.WreckageSync"
local TimerSync = require "boom.systems.logic.TimerSync"
local GroupSync = require "boom.systems.logic.GroupSync"

local logic = {
  HealthSync(),
  WreckageSync(),
  TimerSync(),
  GroupSync()
}

logic.names = {
  "HealthSync",
  "WreckageSync",
  "TimerSync",
  "GroupSync",
}

return logic
