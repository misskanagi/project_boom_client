-- 当一个玩家选择进入一个房间或者成功创建一个房间以后，进入room.lua
--[[

]]--
local networker = require("boom.system.networker")

local room = {}
local first_time_to_update = true
local channel_roominfo = nil

function room.load()
  channel_roominfo = love.thread.getChannel("channel_roominfo")
  -- 初始化一些控件


  -- 第一次从room_thread中获取房间信息时
end

function room.update(dt)
  if first_time_to_update then
    room.load()
    first_time_to_update = false
  end
  -- 初始化结束后，不断从room_thread处获取房间内每一个人的最新状态，保存下来以待绘制。
  if channel_roominfo then
    local data = channel_roominfo:pop()
    if data then
      -- 解析data，看data中是包含了<房间中的最新情况>/<准备战斗的信息>
      local battle_start = true -- 这里是分析出data的内容是开始战斗
      if battle_start then
        whereami = places["game"] -- 如果收到的是开始战斗的指令，那么此时跳转到game.lua

      else
        -- 更新好各种数据以供draw()
      end
    end
  end
end

function room.draw()
  love.graphics.print("room")
end

--修改自己的战车参数以及队伍/确认准备完成/退出房间
function room.keypressed(key,scancode,isrepeat)
  --[[
     简单起见这里直接按一个键就确认准备完成，等待room_thread发来准备战斗的信息
  ]]--
end

function room.keyreleased(key)
end


return room
