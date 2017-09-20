--local netLib = require "library"
local netLib = require "libtcp"
local json = require "libs.json"
--[[load some tool modules
log = require("libs.log")
--require("alien")
log.newfreshlog("logfile_receive.txt")
log.logswitch(true)  --关闭log开关]]
local c = love.thread.getChannel("network")
while true do
  local data = {netLib.Lua_receive()}
  --log.debug(data)
  --合并data
  c:push(data)
  --查看有没有关闭消息
  --[[local msg = c:pop()
  if msg and msg == "stop" then
    break
  end]]
end
