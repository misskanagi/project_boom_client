--room_thread.lua 专门用于在查看房间列表，查看房间详情，创建房间等情况下使用。
-- 注意，这里的log和networker不可以使用local的，因为在这里调用networker中function的时候，networker会使用调用它的thread环境里的log等，如果local则找不到了（不会找main.lua中的全局log对象）
log = require "./libs/log"
networker = require "./boom/chaos/networker"

log.newfreshlog("./log/logfile_room_thread.txt")
log.debug("room_thread start!")

channel_createroom = love.thread.getChannel("channel_createroom") --用于向main thread发送Server对创建房间请求的反馈
channel_enterroom = love.thread.getChannel("channel_enterroom") --用于向main thread发送Server对进入房间请求的反馈
channel_roominfo = love.thread.getChannel("channel_roominfo") --用于通知main thread房间里的最新情况
channel_roomlist = love.thread.getChannel("channel_roomlist") --发送给main thread其想要的房间列表筛选数据


repeat
  local data = networker.receive("room")  --"room"会得到Server有关房间的所有可能的数据，在此处分类，发往不同的channel
  -- 解析data属于哪一种数据

  -- 此时先是fake的，所以往channel_createroom， channel_enterroom各发一个ok
  channel_createroom:push("")
  channel_enterroom:push("")
  channel_roominfo:push("")
until false
