local netLib = require "library"
local json = require "libs.json"
--[[load some tool modules
log = require("libs.log")
--require("alien")
log.newfreshlog("logfile_receive.txt")
log.logswitch(true)  --关闭log开关]]
local c = love.thread.getChannel("network")
local fd = c:demand()
while true do
  local data = {netLib.Lua_receive(fd)}
  --log.debug(data)
  --合并data
  c:supply(data)
  --查看有没有关闭消息
  local msg = c:pop()
  if msg and msg == "stop" then
    break
  end
end
