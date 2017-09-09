-- 专门用于选择房间的界面，在该界面的时候把room_thread起起来，进入实际的游戏的时候再关闭。
--[[
fix:
  1. 一开始的时候按向下键，是不scroll的，比如一个scroll显示3个item，那么滑至第3个item在按down才会滑出一格。同理向上滑动也是。
]]--
local gui = require("libs.Gspot")
--必须到package.loaded表中把"./libs/Gspot"为key的项删除，不然的话，其他文件中require "./libs/Gspot"会直接到package.loaded中先找，导致使用和这里gui同一个的对象
package.loaded["./libs/Gspot"] = nil
local networker = require("boom.system.networker")

local selectroom = {}
local first_time_to_update = true
local scroll_focous_time_bound = 0.8  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_focous_time_account = 0
local scroll_focous_flag = false
local scroll_frame_time_gap_bound = 0.15  -- 按住方向键以后，每过150ms越过一个room_item
local scroll_frame_time_gap_account = 0

local room_selected_index = 1
room_thread = nil -- 专门用于处理和房间相关的网络处理的thead
local channel_roomlist = nil -- 接收筛选的房间列表信息


--reset函数的作用是恢复selectroom的内容状态，比如选择了<返回上级目录>，以后，first_time_to_update要重置为false
local function reset()

end

function selectroom.load()
  --开辟一个thread，到服务器上拉取房间信息简介（为了减少耗时开销）
  room_thread = love.thread.newThread("room_thread.lua")
  channel_roomlist = love.thread.getChannel("channel_roomlist")
  room_thread:start()

  --创建各种控件
  gui.util.setfont(gui, "assets/font/fertigo_pro_regular.ttf", 32)
  --先来个大标题
  local room_title_width = love.graphics.getWidth()*2/3
  local room_title_height = 100
  local room_title_x = (love.graphics.getWidth()-room_title_width)/2
  local room_title_y = 0
  local room_title = gui:text("room", {x = room_title_x, y = room_title_y, w = room_title_width, h = room_title_height}, nil, nil, {0,0,0})


  local room_group_width = love.graphics.getWidth()*2/3
  local room_group_height = love.graphics.getHeight()*2/3
  local room_group_x = math.floor((love.graphics.getWidth() - room_group_width)/2)
  local room_group_y = 100

  local room_item_num_per_page = 3 -- 一页显示几个room_item
  local room_item_height = room_group_height / room_item_num_per_page
  local room_item_width = room_group_width

  --group = gui:group(nil, {gui.style.unit, 128, 256, 256})
  scrollgroup = gui:scrollgroup(nil, {room_group_x, room_group_y, room_group_width, room_group_height}, nil, 'vertical') -- scrollgroup will create its own scrollbar
	scrollgroup.scrollv.drop = function(this, direction, succeed)
    -- 滑动监听
    if (direction ~= nil and type(direction) == "string") or (succeed ~= nil and type(succeed) == "boolean") then
      if direction == "up" and succeed then
        room_selected_index = room_selected_index - 1
      elseif direction == "down" and succeed then
        room_selected_index = room_selected_index + 1
      end
      -- 播放一个"咻"的音效
    end
    -- 播放一个"吥"的滑到底了的音效
    gui:feedback('current focous room '..room_selected_index)
  end
  scrollgroup.scrollv.values.step = room_item_height -- 滑动一次的距离是一个room_item的高度
	--scrollgroup.scrollv.style.hs = "auto"

  for i = 1, 20 do
    scrollgroup:addchild(gui:text(""..i, {h = room_item_height, w = room_item_width}), 'vertical')
  end

end

function selectroom.update(dt)
  if first_time_to_update then
    selectroom.load()
    first_time_to_update = false
  end

  -- 判断用户是否正在上下查看房间
  local scroll = scrollgroup.scrollv
  if scroll_focous_flag == true then
    scroll_focous_time_account = scroll_focous_time_account + dt
    if scroll_focous_time_account >= scroll_focous_time_bound then
      --已经达到了可以开始飞速滑动的时间线
      scroll_frame_time_gap_account = scroll_frame_time_gap_account + dt
      if scroll_frame_time_gap_account >= scroll_frame_time_gap_bound then
        scroll_frame_time_gap_account = 0
        local scroll_old_position = scroll.values.current
        if love.keyboard.isDown("up") then
          scroll.values.current = math.max(scroll.values.min, scroll.values.current - scroll.values.step)
          if scroll.values.current == scroll_old_position then
            scroll:drop("up", false) --向上滑动但实际上并未改变scroll的值
          else
            scroll:drop("up", true) --向上滑动且实际上改变scroll的值
          end
        end
        if love.keyboard.isDown("down") then
          scroll.values.current = math.min(scroll.values.max, scroll.values.current + scroll.values.step)
          if scroll.values.current == scroll_old_position then
            scroll:drop("down", false) --向下滑动但实际上并未改变scroll的值
          else
            scroll:drop("down", true) --向下滑动且实际上改变scroll的值
          end
        end
      end
    end
  end

  gui:update(dt)

end

function selectroom.draw()
  gui:draw()
end

function selectroom.keypressed(key, scancode, isrepeat)
  log.debug("selectroom.keypressed!")
  -- "l/b" : 返回上级菜单
  -- "r" : 创建新房间
  -- "up/down" : 上下选择房间
  -- "return" : 选中当前房间
  -- "left/right" : 切换过虑不同的赛制（全部->经典->夺旗->夺点->乱斗->全部）
  if key == 'l' or key == 'b' then
    reset()
    whereami = places["titlemenu"]

  elseif key == 'r' then
    --直接跳转到另一个createroom.lua中。也可以按b回来
    whereami = places["createroom"]

  elseif key == 'up' then
    scroll_focous_flag = true
    scroll_focous_time_account = 0
    local scroll = scrollgroup.scrollv
    local scroll_old_position = scroll.values.current
		scroll.values.current = math.max(scroll.values.min, scroll.values.current - scroll.values.step)
    if scroll.values.current == scroll_old_position then
      scroll:drop("up", false)
    else
      scroll:drop("up", true)
    end


  elseif key == 'down' then
    scroll_focous_flag = true
    scroll_focous_time_account = 0
    local scroll = scrollgroup.scrollv
    local scroll_old_position = scroll.values.current
		scroll.values.current = math.min(scroll.values.max, scroll.values.current + scroll.values.step)
    if scroll.values.current == scroll_old_position then
      scroll:drop("down", false)
    else
      scroll:drop("down", true)
    end
  elseif key == 'a' then
    --[[
      选中了一个room_item，此时进入房间，跳转到room.lua
      由于可能一瞬间同时很多玩家选中一个房间，所以需要先发送自己的id和选中的room id，由Server裁决是否可以进入房间:
        如果抢到了，Server会返回一个确认信息，拿到这个确认信息以后，就可以进入room.lua；
        如果没抢到，Server会返回一个失败信息，那么告诉玩家房间已满，玩家继续停留在selectroom.lua中。
      ]]--
    whereami = places["room"]

  elseif key == 'return' then

  elseif key == "left" then

  elseif key == "right" then

  end


end

function selectroom.keyreleased(key)
  if key == "up" then
    scroll_focous_time_account = 0
    if love.keyboard.isDown("down") then
      --松开了up但是down还按着，那么此时重新开始计时
      scroll_focous_flag = true
    else
      scroll_focous_flag = false
    end
  end
  if key == "down" then
    scroll_focous_time_account = 0
    if love.keyboard.isDown("up") then
      scroll_focous_flag = true
    else
      scroll_focous_flag = false
    end
  end

end

function selectroom.mousepressed(x, y, button)
	--gui:mousepress(x, y, button) -- pretty sure you want to register mouse events
end

function selectroom.mousereleased(x, y, button)
	--gui:mouserelease(x, y, button)
end



return selectroom
