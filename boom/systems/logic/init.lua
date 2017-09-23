local HealthSync = require "boom.systems.logic.HealthSync"
local WreckageSync = require "boom.systems.logic.WreckageSync"
local TimerSync = require "boom.systems.logic.TimerSync"

local logic = {
  HealthSync = HealthSync(),
  WreckageSync = WreckageSync(),
  TimerSync = TimerSync(),
}

return logic
