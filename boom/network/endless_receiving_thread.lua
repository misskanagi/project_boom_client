--local netLib = require "library"
local netLib = require "libtcp"
--local json = require "libs.json"
local json = require "cjson"
--load some tool modules
--log = require("libs.log")
--require("alien")
--log.newfreshlog("logfile_receive.txt")
--log.logswitch(true)  --关闭log开关
local c = love.thread.getChannel("network_receive")
while true do
  local data = {netLib.Lua_receive()}
  --log.debug(data)
  --合并data
  for _, json_string in pairs(data) do
      --local t = netLib.Lua_getTime()
      local ddd = json.decode(json_string)
      --local dt = netLib.Lua_getTime() - t
      --log.debug(dt)
      c:supply(ddd)
  end
  --查看有没有关闭消息
  local msg = c:peek()
  if msg and msg == "stop" then
    break
  end
end
