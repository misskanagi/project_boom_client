local netLib = require "libtcp"
local json = require "cjson"

--获取network单例并连接
local channel_connect = love.thread.getChannel("channel_connect")
--net:connect("192.168.1.105", 8080)
--net:connect("172.28.37.19", 8080)
--netLib.Lua_connect("114.212.83.208", 8080)
--netLib.Lua_connect("192.168.1.105", 8080)
--netLib.Lua_connect("192.168.233.181", 8080)
netLib.Lua_connect("114.212.84.164", 8080)
channel_connect:push(true)
