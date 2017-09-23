local HealthSync = require "boom.systems.logic.HealthSync"
local WreckageSync = require "boom.systems.logic.WreckageSync"
local TimerSync = require "boom.systems.logic.TimerSync"

local logic = {
  HealthSync(),
  WreckageSync(),
  TimerSync(),
}

logic.names = {
  "HealthSync",
  "WreckageSync",
  "TimerSync",
}

return logic
