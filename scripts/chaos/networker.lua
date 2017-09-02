--[[
networker.lua负责与Server进行通讯。
send(string msg):Client向Server发消息。
string receive():Client接收从Server发送回来的消息。
]]--
local serialize = require "./libs/serialize"
local json = require "./libs/json"
local networker = {}

--local math = require "math"

math.randomseed(os.time())
local other_x = 100
local npc_direction = "left" 

--解码一个json格式的消息，返回解析以后的数据对象
function networker.decode(json_msg)
  return json.decode(json_msg)
end

--将一个数据对象封装成json格式的消息
function networker.encode(data)
  return json.encode(data)
end


function networker.send(msg)
  log.debug("networker.send():"..msg)
end

--fake参数是虚假的，用在这里以区分不同的receive调用点，然后receive函数会返回写死的数据。
function networker.receive(fake, ...)
  log.debug("networker.receive(fake) -- fake="..fake)
  if fake == "gamebegin" then
    --从文件中读取，包含地图id，其他坦克信息的字符串。（现在假设只有另外一台敌方坦克）
    local map = {["id"] = "mission3"}
    local tanks = {[1] = {["id"] = 1,["type"] = "tank_blue", ["x"] = 200, ["y"] = 90, ["speed"] = 500, ["direction"] = "up", ["hp"] = 100, ["status"] = ""},
                   [2] = {["id"] = 2,["type"] = "tank_green", ["x"] = 250, ["y"] = 100, ["speed"] = 500, ["direction"] = "left", ["hp"]  = 100,
                          ["weapons"] = {{["type"] = "bullet0",["count"] = 100}, {["type"] = "fireball",["count"] = 90},{["type"]="missile",["count"]=100}},
                          ["tools"] = {{["type"] = "hp_advance" ,["count"] = 3},{["type"] = "speed_advance",["count"] = 10},{["type"] = "hiding",["count"] = 10}},
                          ["fitting"] = "sharkskin", ["status"] = "hiding"}
                  }
    local obj = {map, tanks}
    local response =serialize.doit(obj)
    return response
  elseif fake == "hotdata" then
    --ranval = math.random(3,4)
    local directions = {[1] = "up", [2] = "down", [3] = "left", [4] = "right"}
    if npc_direction == "left" then
      if other_x == 30 then
        npc_direction = "right"
      else
        other_x = other_x - 1
      end
    else
      if other_x == 500 then
        npc_direction = "left"
      else
        other_x = other_x + 1
      end
    end

    local tanks = {[1] = {["id"] = 1, ["x"] = other_x, ["y"] = 100, ["speed"] = 500, ["direction"] = npc_direction, ["hp"] = 90, ["status"] = ""},
                   [2] = {["id"] = 2, ["x"] = 250, ["y"] = 100, ["speed"] = 500, ["direction"] = "left", ["status"] = "hiding"}}
    local response =serialize.doit(tanks)
    return response
  end
  return nil
end

function networker.test()
  log.debug("networker.test()")
end

return networker