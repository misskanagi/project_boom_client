local netLib = require "libtcp"
local json = require "libs.json"

--获取network单例并连接
local network = require("boom.network")
local net = network:instance()
if not net:testConnect() then
  --net:connect("192.168.1.108", 8080)
  print("connect!")
  net:connect("172.28.37.19", 8080)
  --net:connect("114.212.83.208", 8080)
  net:startReceiving()
end

