-- 注意，这里的log和networker不可以使用local的，因为在这里调用networker中function的时候，networker会使用调用它的thread环境里的log等，如果local则找不到了（不会找main.lua中的全局log对象）
log = require("libs/log")
log.logswitch(false)  --关闭log开关
networker = require("boom.system.networker")

function network_delay(degree)
  local j = 0
  while j < degree do
    j = j + 1
  end
end

-- 实现与Server的数据更新操作
log.newfreshlog("./log/logfile_game_thread.txt")
log.debug("game thread start!")
-- channel可以是每一种从S端得到的广播类型单独有一个channel，例如所有车辆子弹的用一个channel，所有地图道具的用一个channel，这样可以减轻main thread的解析压力。
channel_tank = love.thread.getChannel("channel_tank")  --channel_tank是发送最新的坦克数据的通道。
channel_maptool = love.thread.getChannel("channel_maptool") --channel_maptool是发送最新的道具数据的通道。
channel_tilebreak = love.thread.getChannel("channel_tilebreak") --channel_tilebreak是发送地形块对象毁坏信息的通道
channel_control = love.thread.getChannel("channel_control") --channel_control是发送游戏控制信息的通道，例如gamebegin/gameover

local i = 0
--第一次从服务器上先拉一个完整的数据
local initialstring = networker.receive("gamebegin")
channel_tank:push(initialstring)

repeat
  --[[
  1. data = receive
  2. data是一个json，解码data到一个对象data_obj中
  3. 归类data_obj属于control/tank/maptool/mapcoll中的哪一类信息，将其发到对应的通道上
  ]]--
  log.debug("ask networker for hotdata no."..i)
  local hotdata = networker.receive("hotdata")
  --此时判断一下hotdata是tank信息还是tool信息。分类发送给不同通道。
  -- 先假设判断是tank信息。
  log.debug("got hot fresh tanks data no."..i.." :"..hotdata)
  -- 模拟网络时延
  -- network_delay(15000)
  --channel_tank:clear() --这一句是要的，但是由于现在是模拟的networker.receive，没有阻塞，所以会很快得到新数据，真实场景下是不会出现这种情况的。
  channel_tank:push(hotdata)
  log.debug("send hot fresh tanks data no."..i.."  to main thread!")
  i = i + 1
until false
