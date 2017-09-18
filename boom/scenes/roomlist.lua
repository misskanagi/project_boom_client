--管理房间列表
local roomlist = class("roomlist")
local game_state = require("libs.hump.gamestate")
local cam = require "boom.camera"

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
local scrollview = require("libs.Gspot_ext.scrollview")
require "./libs/gooi"
local lg = love.graphics
local events = require("boom.events")
local RoomListNetHandler = class("RoomListNetHandler", System)
local InputHandler = class("InputHandler", System)
local roomlist_net_handler = RoomListNetHandler()   --具体的handler实例
local input_handler = InputHandler()

local myId = nil   --当前玩家的id
--前置声明
local scroll_update, begin_move_scrollgroup, stop_move_scrollgroup, refresh, refresh_update, cancel_refresh, enter_room, remove_widgets, enter_update
--固定尺寸
local window_w = 960 --480
local window_h = 640 --320

--lbl_title的各项参数
local lbl_title = nil
local lbl_title_x = 20 --10
local lbl_title_y = 20 --10
local lbl_title_w = 920 --460
local lbl_title_h = 120 --60

--滚动列表的各项参数
local scrollgroup = nil
local scroll_focous_time_bound = 0.2  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_frame_time_gap_bound = 0.05  -- 按住方向键以后，每过150ms越过一个room_item
local room_item_num_per_page = 4 -- 一页显示几个room_item
local room_scroll_x = 20 --10
local room_scroll_y = 140 --70
local room_item_height = 105 --70   --room_item_height * room_item_num_per_page == room_scroll_h，这一点在这里就要保证，不然会出问题
local room_item_width = 904 --444
local room_infos = {}  --存放从Server拿到的所有的房间item的数据

--刷新相关值
local refreshing = false --是否在刷新中
local refresh_line_x1 = 480 --240
local refresh_line_x2 = 480 --240
local refresh_line_length_bound = 400 --200
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
end


function roomlist:enter(prev, init_table)
  gui:setOriginSize(window_w, window_h)
  cam:lookAt(window_w/2, window_h/2)
  eventmanager:addListener("GetRoomListRes", roomlist_net_handler, roomlist_net_handler.fireGetRoomListResEvent)
  eventmanager:addListener("EnterRoomRes", roomlist_net_handler, roomlist_net_handler.fireEnterRoomResEvent)
  eventmanager:addListener("RoomListInputPressed", input_handler, input_handler.firePressedEvent)
  eventmanager:addListener("RoomListInputReleased", input_handler, input_handler.fireReleasedEvent)
  
  myId = init_table and init_table["myId"]
  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]

  font_current = lg.getFont()
  font_big = lg.newFont("assets/font/Arimo-Bold.ttf", 26)
  font_small = lg.newFont("assets/font/Arimo-Bold.ttf", 20)
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
  refresh()   --刷新房间列表
end

function roomlist:update(dt)
  enter_update(dt)
  refresh_update(dt)
  if scrollgroup then
    scrollgroup:update(dt)
  end
  gui:update(dt)
  gooi.update(dt)
  if not test_on_windows then
    net:update(dt)
  end
end

--处理refresh更新的逻辑
refresh_update = function(dt)
  --判断当前scrollgroup是否正在刷新中
  if refreshing then
    if refresh_line_shrink then
      --收缩中
      if refresh_line_x2 - refresh_line_x1 > 0 then
        refresh_line_x2 = refresh_line_x2 - 12 --6
        refresh_line_x1 = refresh_line_x1 + 12 --6
      else
        refresh_line_x1 = 480 --240
        refresh_line_x2 = 480 --240
        refresh_line_shrink = false
      end
    else
      if refresh_line_x2 - refresh_line_x1 < refresh_line_length_bound then
        refresh_line_x1 = refresh_line_x1 - 24 --12
        refresh_line_x2 = refresh_line_x2 + 24 --12
      else
        refresh_line_x1 = -refresh_line_length_bound/2 + 480 --240 
        refresh_line_x2 = refresh_line_length_bound/2 + 480 --240
        refresh_line_shrink = true
      end
    end
  end
end

--正在进入房间的状态下的update函数
enter_update = function(dt)
  if entering then
    --正在进入中，更新等待动画
  end
end


--刷新房间列表
refresh = function()
  if scrollgroup then
    scrollgroup:clean()
  end
  --向server发送获取房间列表的请求
  print("refresh:"..myId)
  refreshing = true
  if not test_on_windows then
    net:requestGetRoomList(myId)
  else
    --模拟已经获取到了最新的数据
    --更新显示房间列表
    --添加新的控件
    roomNumbers = 6
    RoomInfos = {
      [1] = {["roomId"] = "lsm123", ["gameMode"] = "chaos", ["playersPerGroup"] = 4, ["playersInRoom"] = 3},
      [2] = {["roomId"] = "james_room", ["gameMode"] = "chaos", ["playersPerGroup"] = 8, ["playersInRoom"] = 5},
      [3] = {["roomId"] = "hackhao_www", ["gameMode"] = "chaos", ["playersPerGroup"] = 8, ["playersInRoom"] = 9},
      [4] = {["roomId"] = "yuge_room", ["gameMode"] = "chaos", ["playersPerGroup"] = 8, ["playersInRoom"] = 16},
      [5] = {["roomId"] = "kingdom", ["gameMode"] = "chaos", ["playersPerGroup"] = 3, ["playersInRoom"] = 2},
      [6] = {["roomId"] = "heheheh", ["gameMode"] = "chaos", ["playersPerGroup"] = 4, ["playersInRoom"] = 8},
    }
    --创建scollgroup
    scrollgroup = scrollview.createObject({x = room_scroll_x, y = room_scroll_y, item_width = room_item_width, item_height = room_item_height, item_num_per_page = room_item_num_per_page, time_before_fastscroll = scroll_focous_time_bound, time_between_fastscroll = scroll_frame_time_gap_bound, bgcolor = {255,255,255,20}, bgcolor_focous = {255,255,255,50}}, gui)
    for i = 1, roomNumbers do
    --w一共是444
      local roomInfo_item = RoomInfos[i]
      local room_image = 'assets/room.jpg'   --x = 10, y = 5, w = 60, h = 60
      local room_id = roomInfo_item["roomId"]       --x = 70, y = 5, w = 170, h = 60
      local room_mode = roomInfo_item["gameMode"]  --x = 240, y = 5, w = 100, h = 60,
      local room_people = roomInfo_item["playersInRoom"].."/"..(roomInfo_item["playersPerGroup"]*2)        --x = 340, y = 5, w = 104 , h = 60,
      local gi = gui:group('', {x = 0, y = 0, w = room_item_width, h = room_item_height})
      gi.lsm = true
      gi.bgcolor = {255,255,255,0}
      --local widget_room_image = gui:image("", {10, 5, 60, 60}, gi, room_image)  --放置对应的战斗模式图片作为房间图像
      --local widget_room_id = gui:text(room_id, {70, 5, 170, 60}, gi, false)
      --local widget_room_mode = gui:text(room_mode, {240, 5, 100, 60}, gi, false)--, {255,255,255,20})
      --local widget_room_people = gui:text(room_people, {340, 5, 100, 60}, gi, false)--, {255,255,255,20})
      local widget_room_image = gui:image("", {10, 5, 120, 60}, gi, room_image)  --放置对应的战斗模式图片作为房间图像
      local widget_room_id = gui:text(room_id, {140, 5, 340, 60}, gi, false)
      local widget_room_mode = gui:text(room_mode, {480, 5, 200, 60}, gi, false)--, {255,255,255,20})
      local widget_room_people = gui:text(room_people, {680, 5, 200, 60}, gi, false)--, {255,255,255,20})
      widget_room_id:setfont(font_small)
      widget_room_mode:setfont(font_small)
      widget_room_people:setfont(font_small)
      scrollgroup:addChild(gi)
    end
    scrollgroup:allChildAdded()
    scrollgroup:scrollToTop()
    refreshing = false
  end
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
  --将自己的id和要进入的房间id一同发送给Server
  entering  = true
  if not test_on_windows then
    net:requestEnterRoom(selected_room_item["roomId"], myId)
  else
    --模拟成功进入了房间
    --成功进入房间，带着myId,roomId,groupId,roomMasterId,playersInfo,gameMode,mapType,lifeNumber,playersPerGroup,进入room.lua
    local init_table = {}
    init_table["myId"] = myId
    init_table["roomId"] = selected_room_item["roomId"]   --
    init_table["groupId"] = 2
    init_table["roomMasterId"] = "root"
    init_table["playersInfo"] = {}
    init_table["gameMode"] = selected_room_item["gameMode"]   --
    init_table["mapType"] = 2
    init_table["lifeNumber"] = 5
    init_table["playersPerGroup"] = selected_room_item["playersPerGroup"]  --
    --init_table[""] = 
    local room = require("boom.scenes.room")
    game_state.switch(room, init_table)
  end
end

--移除所有的控件
remove_widgets = function()
  gooi.removeComponent(lbl_title)
  if scrollgroup then
    scrollgroup:clean()
  end
end


function roomlist:draw()
  local bgimg = lg.newImage("assets/bgimg.jpg")
  lg.draw(bgimg,0,0)
  cam:attach()
  if refreshing then
    --绘制一个
    lg.line(refresh_line_x1, window_h/2, refresh_line_x2, window_h/2)
  end

  local r,g,b,a = lg.getColor()
  lg.setColor(0, 0, 0, 100)
  lg.rectangle("fill", 0, 0, window_w, window_h)
  --绘制lbl_title的底框
  lg.setColor(0, 0, 0, 100)
  lg.rectangle("fill", lbl_title_x, lbl_title_y, lbl_title_w, lbl_title_h)

  lg.setColor(r,g,b,a)
  local fresh_string = "L1-refresh"
  local help_string = "R1-create a room"
  lg.print(fresh_string, 40, window_h-font_current:getHeight() - 40)  --origin:20
  lg.print(help_string, window_w-font_current:getWidth(help_string) - 40, window_h-font_current:getHeight() - 40) --origin:20
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
    --enter_room()
    eventmanager:fireEvent(events.RoomListInputPressed("a"))
  elseif button == 'dpup' then
    --if not refreshing then scrollgroup:scrollUp() end--begin_move_scrollgroup("up") end
    eventmanager:fireEvent(events.RoomListInputPressed("up"))
  elseif button == 'dpdown' then
    --if not refreshing then scrollgroup:scrollDown() end--begin_move_scrollgroup("down") end
    eventmanager:fireEvent(events.RoomListInputPressed("down"))
  elseif button == 'rightshoulder' then
    --[[local init_table = {}
    init_table["myId"] = myId
    game_state.switch(create_room, init_table)]]--
    eventmanager:fireEvent(events.RoomListInputPressed("r1"))
  elseif button == 'leftshoulder' then
    --refresh()
    eventmanager:fireEvent(events.RoomListInputPressed("l1"))
  elseif button == "guide" then
    eventmanager:fireEvent(events.RoomListInputPressed("esc"))
  end
end

function roomlist:gamepadreleased(joystick, button)
  if button == "dpup" then
    eventmanager:fireEvent(events.RoomListInputReleased("up"))
  elseif button == "dpdown" then
    --[[if not(joystick and (joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown"))) then
      --stop_move_scrollgroup()
      scrollgroup:stop_move()
    end]]--
    eventmanager:fireEvent(events.RoomListInputReleased("down"))
  end
end

function roomlist:keypressed(key, scancode, isrepeat)
  if entering then return end   --如果正在进入房间，禁止按键操作，直到收到一个返回
  if key == "a" then
    --enter_room()
    eventmanager:fireEvent(events.RoomListInputPressed("a"))
  elseif key == 'up' then
    --if not refreshing then scrollgroup:scrollUp() end--begin_move_scrollgroup("up") end
    eventmanager:fireEvent(events.RoomListInputPressed("up"))
  elseif key == 'down' then
    --if not refreshing then scrollgroup:scrollDown() end--begin_move_scrollgroup("down") end
    eventmanager:fireEvent(events.RoomListInputPressed("down"))
  elseif key == 'r' then
    --[[local init_table = {}
    init_table["myId"] = myId
    game_state.switch(create_room, init_table)]]--
    eventmanager:fireEvent(events.RoomListInputPressed("r1"))
  elseif key == 'l' then
    --refresh()
    eventmanager:fireEvent(events.RoomListInputPressed("l1"))
  elseif key == "escape" then
    eventmanager:fireEvent(events.RoomListInputPressed("esc"))
  end
end

function roomlist:keyreleased(key)
  if key == "up" then
    eventmanager:fireEvent(events.RoomListInputReleased("up"))
  elseif key == "down" then
    --[[if not(joystick and (joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown"))) then
      --stop_move_scrollgroup()
      scrollgroup:stop_move()
    end]]--
    eventmanager:fireEvent(events.RoomListInputReleased("down"))
  end
end


--网络事件处理
--收到服务器对获取房间列表请求的响应
function RoomListNetHandler:fireGetRoomListResEvent(event)
  print("RoomListNetHandler:fireGetRoomListResEvent")
  if scrollgroup then
    scrollgroup:clean()
  end
  roomNumbers = event.roomNumbers
  if roomNumbers == -1 then
    --没有任何房间数据
    RoomInfos = {}
    roomNumbers = 0
    refreshing = false
    return
  end
  
  RoomInfos = {}
  for k,v in pairs(event.roomsInfo) do
    RoomInfos[#RoomInfos + 1] = v
  end
  --更新显示房间列表
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

--收到服务器对进入房间请求的响应
function RoomListNetHandler:fireEnterRoomResEvent(event)
  print("RoomListNetHandler:fireEnterRoomResEvent")
  local responseCode = event.responseCode
  local groupId = event.groupId
  local roomMasterId = event.roomMasterId
  local playersInfo = event.playersInfo
  local room_selected_index = scrollgroup:getSelectedIndex()
  local selected_room_item = RoomInfos[room_selected_index]
  if responseCode == 1 then
    --成功进入房间，带着myId,roomId,groupId,roomMasterId,playersInfo,gameMode,mapType,lifeNumber,playersPerGroup,进入room.lua
    local init_table = {}
    init_table["myId"] = myId
    init_table["roomId"] = selected_room_item["roomId"]   --
    init_table["groupId"] = groupId
    init_table["roomMasterId"] = roomMasterId
    init_table["playersInfo"] = playersInfo
    init_table["gameMode"] =selected_room_item["gameMode"]   --
    init_table["mapType"] = selected_room_item["mapType"]   --
    init_table["lifeNumber"] = selected_room_item["lifeNumber"]  --
    init_table["playersPerGroup"] = selected_room_item["playersPerGroup"]  --
    --init_table[""] = 
    local room = require("boom.scenes.room")
    game_state.switch(room, init_table)
  else
  end
end

function InputHandler:firePressedEvent(event)
  local cmd = event.cmd
  if cmd == "up" then
    if not refreshing then scrollgroup:scrollUp() end--begin_move_scrollgroup("up") end
  elseif cmd == "down" then
    if not refreshing then scrollgroup:scrollDown() end--begin_move_scrollgroup("down") end
  elseif cmd == "left" then
    
  elseif cmd == "right" then
    
  elseif cmd == "a" then
    --remove_widgets()
    enter_room()
  elseif cmd == "b" then
    
  elseif cmd == "x" then
    
  elseif cmd == "y" then
    
  elseif cmd == "l1" then
    refresh()
  elseif cmd == "l2" then
    
  elseif cmd == "r1" then
    local init_table = {}
    init_table["myId"] = myId
    game_state.switch(create_room, init_table)
  elseif cmd == "r2" then
    
  elseif cmd == "esc" then
    love.event.quit()
  end
end

function InputHandler:fireReleasedEvent(event)
  local cmd = event.cmd
  if cmd == "up" then
    if not(joystick and (joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown"))) and not(love.keyboard.isDown("down") or love.keyboard.isDown("up")) then
      --stop_move_scrollgroup()
      scrollgroup:stop_move()
    end
  elseif cmd == "down" then
    if not(joystick and (joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown")))  and not(love.keyboard.isDown("down") or love.keyboard.isDown("up")) then
      --stop_move_scrollgroup()
      scrollgroup:stop_move()
    end
  end
end


return roomlist
