--管理房间列表
local roomlist = class("roomlist")
local game_state = require("libs.hump.gamestate")
local cam = require "boom.camera"

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
local scrollview = require("libs.Gspot_ext.scrollview")
require "./libs/gooi"
local lg = love.graphics

local myId = nil   --当前玩家的id
--前置声明
local scroll_update, begin_move_scrollgroup, stop_move_scrollgroup, refresh, refresh_update, cancel_refresh, enter_room, remove_widgets, enter_update
--固定尺寸
local window_w = 480
local window_h = 320

--lbl_title的各项参数
local lbl_title = nil
local lbl_title_x = 10
local lbl_title_y = 10
local lbl_title_w = 460
local lbl_title_h = 60

--滚动列表的各项参数
local scrollgroup = nil
--local room_selected_index = 1 --当前被选中的房间的index
local scroll_focous_time_bound = 0.2  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_frame_time_gap_bound = 0.05  -- 按住方向键以后，每过150ms越过一个room_item
local room_item_num_per_page = 3 -- 一页显示几个room_item
local room_scroll_x = 10
local room_scroll_y = 70
local room_item_height = 70   --room_item_height * room_item_num_per_page == room_scroll_h，这一点在这里就要保证，不然会出问题
local room_item_width = 444
local room_infos = {}  --存放从Server拿到的所有的房间item的数据

--刷新相关值
local refreshing = false --是否在刷新中
local refresh_line_x1 = 240
local refresh_line_x2 = 240
local refresh_line_length_bound = 200
local refresh_line_shrink = false
--申请进入房间的相关值
local entering = false

local roomNumbers = 0  --房间数量
local RoomInfos = {} --从服务器上拉下来的最新房间信息数据

function roomlist:leave()
  --
  room_selected_index = 1
  scroll_window_index = 1
  scroll_frame_time_gap_account = 0
  scroll_frame_time_gap_account = 0
  refreshing = false
  entering = false
  remove_widgets()
  room_infos = {}
  scroll_items = {}
end


function roomlist:enter(prev, init_table)
  myId = init_table and init_table["myId"]
  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]

  font_big = lg.newFont("assets/font/Arimo-Bold.ttf", 18)
  font_small = lg.newFont("assets/font/Arimo-Bold.ttf", 13)
  font_current = lg.getFont()
  style = {
      font = font_big,
      radius = 5,
      innerRadius = 3,
      showBorder = true,
  }

  gooi.setStyle(style)
  gooi.desktopMode()
  gooi.shadow()
  --创建lbl_title
  lbl_title = gooi.newLabel({text = "Room List", x = lbl_title_x, y = lbl_title_y, w = lbl_title_w, h = lbl_title_h}):center()
  --创建scollgroup
  scrollgroup = scrollview.createObject({x = room_scroll_x, y = room_scroll_y, item_width = room_item_width, item_height = room_item_height, item_num_per_page = room_item_num_per_page, time_before_fastscroll = scroll_focous_time_bound, time_between_fastscroll = scroll_frame_time_gap_bound, bgcolor = {255,255,255,20}, bgcolor_focous = {255,255,255,50}}, gui)
  refresh()   --enter的最后就
end

function roomlist:update(dt)
  enter_update(dt)
  refresh_update(dt)
  scrollgroup:update(dt)
  gui:update(dt)
  gooi.update(dt)
end

--处理refresh更新的逻辑
refresh_update = function(dt)
  --判断当前scrollgroup是否正在刷新中
  if refreshing then
    if refresh_line_shrink then
      --收缩中
      if refresh_line_x2 - refresh_line_x1 > 0 then
        refresh_line_x2 = refresh_line_x2 - 3
        refresh_line_x1 = refresh_line_x1 + 3
      else
        refresh_line_x1 = 240
        refresh_line_x2 = 240
        refresh_line_shrink = false
      end
    else
      if refresh_line_x2 - refresh_line_x1 < refresh_line_length_bound then
        refresh_line_x1 = refresh_line_x1 - 6
        refresh_line_x2 = refresh_line_x2 + 6
      else
        refresh_line_x1 = 240 - refresh_line_length_bound/2
        refresh_line_x2 = 240 + refresh_line_length_bound/2
        refresh_line_shrink = true
      end
    end

    --检查Server最新response数据是否到来
    local hotdata = 1
    --hotdata中包含的是roomNumbers以及所有的RoomInfo的数组
    roomNumbers = 6
    RoomInfos = {
      [1] = {["roomId"] = "lsm123", ["gameMode"] = "chaos", ["roomState"] = 1, ["playersPerGroup"] = 4, ["playersInRoom"] = 3, ["lifeNumber"] = 10, ["mapType"] = 1, ["roomState"] = 1},
      [2] = {["roomId"] = "hackhaoxxx", ["gameMode"] = "chaos", ["roomState"] = 1, ["playersPerGroup"] = 8, ["playersInRoom"] = 6, ["lifeNumber"] = 10, ["mapType"] = 1, ["roomState"] = 1},
      [3] = {["roomId"] = "yuge123", ["gameMode"] = "chaos", ["roomState"] = -1, ["playersPerGroup"] = 4, ["playersInRoom"] = 2, ["lifeNumber"] = 10, ["mapType"] = 1, ["roomState"] = 1},
      [4] = {["roomId"] = "james0909", ["gameMode"] = "chaos", ["roomState"] = 1, ["playersPerGroup"] = 3, ["playersInRoom"] = 6, ["lifeNumber"] = 10, ["mapType"] = 1, ["roomState"] = 1},
      [5] = {["roomId"] = "hahaha", ["gameMode"] = "chaos", ["roomState"] = 1, ["playersPerGroup"] = 4, ["playersInRoom"] = 2, ["lifeNumber"] = 10, ["mapType"] = 1, ["roomState"] = 1},
      [6] = {["roomId"] = "hehehe", ["gameMode"] = "chaos", ["roomState"] = 1, ["playersPerGroup"] = 4, ["playersInRoom"] = 3, ["lifeNumber"] = 10, ["mapType"] = 1, ["roomState"] = 1},
      }

    if hotdata then
      --hotdata中有最新的房间信息，添加到scrollgroup
      scrollgroup:removeAllChildren()
      --添加新的控件
      for i = 1, roomNumbers do
        --w一共是444
        local roomInfo_item = RoomInfos[i]
        local room_image = 'assets/room.jpg'   --x = 10, y = 5, w = 60, h = 60
        local room_id = roomInfo_item["roomId"]       --x = 70, y = 5, w = 170, h = 60
        local room_mode = roomInfo_item["gameMode"]  --x = 240, y = 5, w = 100, h = 60,
        local room_people = roomInfo_item["playersInRoom"].."/"..(roomInfo_item["playersPerGroup"]*2)        --x = 340, y = 5, w = 104 , h = 60,
        --[[一个item需要显示的内容：
        1.room image
        2.room id
        3.mode
        4.人数情况:5/8
        ]]--
        local gi = gui:group('', {w = room_item_width, h = room_item_height})
        gi.bgcolor = {255,255,255,0}
        local widget_room_image = gui:image("", {10, 5, 60, 60}, gi, room_image)  --放置对应的战斗模式图片作为房间图像
        local widget_room_id = gui:text(room_id, {70, 5, 170, 60}, gi, false)
        local widget_room_mode = gui:text(room_mode, {240, 5, 100, 60}, gi, false)--, {255,255,255,20})
        local widget_room_people = gui:text(room_people, {340, 5, 100, 60}, gi, false)--, {255,255,255,20})
        scrollgroup:addChild(gi)
      end
      scrollgroup:allChildAdded()
      scrollgroup:scrollToTop()
      refreshing = false
    end
  end
end

--正在进入房间的状态下的update函数
enter_update = function(dt)
  if not entering then return end
  --首先，检查Server是否发回了准许进入房间的response
  local enter_succeed = true
  if enter_succeed then
    --Server准许进入房间
    local roomMasterId_res = "lsm" --Server的response信息
    --把该带的东西带上进入room.lua
    local room_selected_index = scrollgroup.getSelectedIndex()
    local selected_roominfo_item = RoomInfos[room_selected_index]
    local init_table = {}
    init_table["myId"] = myId
    init_table["roomId"] = selected_roominfo_item["roomId"]
    init_table["groupId"] = 1  --房主默认在1号队
    init_table["roomMasterId"] = roomMasterId_res
    init_table["gameMode"] = selected_roominfo_item["gameMode"]  --"chaos"
    init_table["mapType"] = selected_roominfo_item["mapType"]  --"as_snow"
    init_table["lifeNumber"] = selected_roominfo_item["lifeNumber"]
    init_table["playersPerGroup"] = selected_roominfo_item["playersPerGroup"]
    init_table["playersInRoom"] = selected_roominfo_item["playersInRoom"]
    local room = require("boom.scenes.room")
    game_state.switch(room, init_table)
  else
    --未准许
    entering = false
    --弹框说明一下
    gui:feedback("sorry, you cannot enter the room")
  end

end


--刷新房间列表
refresh = function()
  --向server发送获取房间列表的请求
  --[[
  message GetRoomListReq {
    string playerId = 1;
  }
  ]]--

  refreshing = true
end

--取消刷新房间列表的操作
cancel_refresh = function()
  refreshing = false
end

--进入房间
enter_room = function()
  --先检查一下是否被选中的房间的人数还未满，当人数未满的时候才可以加入
  local room_selected_index = scrollgroup:getSelectedIndex()
  local selected_room_item = RoomInfos[room_selected_index]
  if not (selected_room_item and selected_room_item["playersInRoom"] ~= selected_room_item["playersPerGroup"] * 2) then
    gui:feedback("sorry, the room is full!")
    return
  end

  --将自己的id和要进入的房间id一同发送给Server，Server准入以后，切换场景

  entering  = true
end

--移除所有的控件
remove_widgets = function()
  gooi.removeComponent(lbl_title)
  scrollgroup:clean()
end


function roomlist:draw()
  cam:attach()
  if refreshing then
    --绘制一个
    lg.line(refresh_line_x1, window_h/2, refresh_line_x2, window_h/2)
  end

  local r,g,b,a = lg.getColor()
  --绘制lbl_title的底框
  lg.setColor(0, 0, 0, 100)
  lg.rectangle("fill", lbl_title_x, lbl_title_y, lbl_title_w, lbl_title_h)

  lg.setColor(r,g,b,a)
  local fresh_string = "L1-refresh"
  local help_string = "R1-create a room"
  lg.print(fresh_string, 20, window_h-font_current:getHeight() - 20)
  lg.print(help_string, window_w-font_current:getWidth(help_string) - 20, window_h-font_current:getHeight() - 20)
  gui:draw()
  gooi.draw()
  cam:detach()
end


function roomlist:textinput(text)
    gooi.textinput(text)
end

function roomlist:gamepadpressed(joystick, button)
  -- 此处直接处理所有的手柄操作
  if entering then return end   --如果正在进入房间，禁止按键操作，直到收到一个返回
  if button == "b" then
    --remove_widgets()
    enter_room()
  elseif button == 'dpup' then
    if not refreshing then scrollgroup:scrollUp() end--begin_move_scrollgroup("up") end
  elseif button == 'dpdown' then
    if not refreshing then scrollgroup:scrollDown() end--begin_move_scrollgroup("down") end
  elseif button == 'rightshoulder' then
    cancel_refresh()
    local init_table = {}
    game_state.switch(create_room, init_table)
  elseif button == 'leftshoulder' then
    refresh()
  elseif button == "a" then
    cancel_refresh()
  end
end

function roomlist:gamepadreleased(joystick, button)
  if button == "dpup" or button == "dpdown" then
    if not(joystick and (joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown"))) then
      --stop_move_scrollgroup()
      scrollgroup:stop_move()
    end
  end
end

function roomlist:keypressed(key, scancode, isrepeat)
  if key == "b" then
    --game_state.switch(test_place)
  elseif key == 'up' then
    if not refreshing then begin_move_scrollgroup("up") end
  elseif key == 'down' then
    if not refreshing then begin_move_scrollgroup("down") end
  elseif key == 'r' then
    local init_table = {}

    game_state.switch(create_room, init_table)
  end
end

function roomlist:keyreleased(key)
  if key == "up" or key == "down" then
    if not(love.keyboard.isDown("up") or love.keyboard.isDown("down")) then
      stop_move_scrollgroup()
    end
  end
end

return roomlist
