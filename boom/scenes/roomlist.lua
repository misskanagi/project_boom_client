--管理房间列表
local roomlist = class("roomlist")
local game_state = require("libs.hump.gamestate")
local cam = require "boom.camera"
local camera = cam:instance()
local bgimg = love.graphics.newImage("assets/bgimg.jpg")

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
local scroll_update, begin_move_scrollgroup, stop_move_scrollgroup, refresh, refresh_update, cancel_refresh, enter_room, remove_widgets, enter_update, update_scrollgroup_widgets
--固定尺寸
local window_w = 960 --480
local window_h = 640 --320
--lbl_title的各项参数
local lbl_title = nil
local lbl_title_x = 20 --10
local lbl_title_y = 20 --10
local lbl_title_w = 920 --460
local lbl_title_h = 120 --60
--滚动列表各项抬头的lbl
local lbl_masterimg = nil
local lbl_roomid = nil
local lbl_mode = nil
local lbl_people = nil
local lbl_masterimg_pos = {x = 40, y = 140, w = 120, h = 40}
local lbl_roomid_pos = {x = 160, y = 140, w = 340, h = 40}
local lbl_mode_pos = {x = 500, y = 140, w = 200, h = 40}
local lbl_people_pos = {x = 700, y = 140, w = 200, h = 40}

--滚动列表的各项参数
local scrollgroup = nil
local scroll_focous_time_bound = 0.2  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_frame_time_gap_bound = 0.05  -- 按住方向键以后，每过150ms越过一个room_item
local room_item_num_per_page = 4 -- 一页显示几个room_item
local room_scroll_x = 20 --10
local room_scroll_y = 180 --70
local room_item_height = 105 --70   --room_item_height * room_item_num_per_page == room_scroll_h，这一点在这里就要保证，不然会出问题
local room_item_width = 904 --444
local room_infos = {}  --存放从Server拿到的所有的房间item的数据
--scrollgroup的item的各种尺寸
local scrollitem_img_pos = {20, 5, 120, 105}
local scrollitem_textid_pos = {140, 5, 340, 60}
local scrollitem_textmode_pos = {480, 5, 200, 60}
local scrollitem_textpeople_pos = {680, 5, 200, 60}
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
  camera:lookAt(window_w/2, window_h/2)
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
  style.font = font_small
  lbl_title = gooi.newLabel({text = "Room List", x = lbl_title_x, y = lbl_title_y, w = lbl_title_w, h = lbl_title_h}):center()
  lbl_masterimg = gooi.newLabel({text = "Master", x = lbl_masterimg_pos.x, y = lbl_masterimg_pos.y, w = lbl_masterimg_pos.w, h = lbl_masterimg_pos.h}):center():bg({255,0,0,255})
  lbl_roomid = gooi.newLabel({text = "RoomId", x = lbl_roomid_pos.x, y = lbl_roomid_pos.y, w = lbl_roomid_pos.w, h = lbl_roomid_pos.h}):center():bg({255,250,0,255})
  lbl_mode = gooi.newLabel({text = "Mode", x = lbl_mode_pos.x, y = lbl_mode_pos.y, w = lbl_mode_pos.w, h = lbl_mode_pos.h}):center():bg({255,0,250,255})
  lbl_people = gooi.newLabel({text = "Players", x = lbl_people_pos.x, y = lbl_people_pos.y, w = lbl_people_pos.w, h = lbl_people_pos.h}):center():bg({0,255,0,255})
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
      [1] = {["roomId"] = "lsm123", ["gameMode"] = "chaos", ["playersPerGroup"] = 4, ["playersInRoom"] = 3, ["lifeNumber"] = 10, ["mapType"] = 1},
      [2] = {["roomId"] = "james_room", ["gameMode"] = "chaos", ["playersPerGroup"] = 8, ["playersInRoom"] = 5, ["lifeNumber"] = 10, ["mapType"] = 1},
      [3] = {["roomId"] = "hackhao_www", ["gameMode"] = "chaos", ["playersPerGroup"] = 8, ["playersInRoom"] = 9, ["lifeNumber"] = 10, ["mapType"] = 1},
      [4] = {["roomId"] = "yuge_room", ["gameMode"] = "chaos", ["playersPerGroup"] = 8, ["playersInRoom"] = 16, ["lifeNumber"] = 10, ["mapType"] = 1},
      [5] = {["roomId"] = "kingdom", ["gameMode"] = "chaos", ["playersPerGroup"] = 3, ["playersInRoom"] = 2, ["lifeNumber"] = 10 ,["mapType"] = 1},
      [6] = {["roomId"] = "heheheh", ["gameMode"] = "chaos", ["playersPerGroup"] = 4, ["playersInRoom"] = 8, ["lifeNumber"] = 10 ,["mapType"] = 1},
    }
    update_scrollgroup_widgets()   --更新scrollgroup的显示
    refreshing = false
  end
end

--根据roomNumbers/RoomInfos的内容来scrollgroup的child建立起来
update_scrollgroup_widgets = function()
  --更新显示房间列表
  --创建scollgroup
  scrollgroup = scrollview.createObject({x = room_scroll_x, y = room_scroll_y, item_width = room_item_width, item_height = room_item_height, item_num_per_page = room_item_num_per_page, time_before_fastscroll = scroll_focous_time_bound, time_between_fastscroll = scroll_frame_time_gap_bound, bgcolor = {255,255,255,20}, bgcolor_focous = {255,255,255,50}}, gui)
  for i = 1, roomNumbers do
  --w一共是444
    if not RoomInfos[i] then break end   --以防万一的操作
    local roomInfo_item = RoomInfos[i]
    local room_image = 'assets/room.jpg'   --x = 10, y = 5, w = 60, h = 60
    local room_image_ = "assets/gamemode/"
    local j = 2
    
    local room_id = roomInfo_item["roomId"]       --x = 70, y = 5, w = 170, h = 60
    local room_mode = roomInfo_item["gameMode"]  --x = 240, y = 5, w = 100, h = 60,
    local room_people = roomInfo_item["playersInRoom"].."/"..(roomInfo_item["playersPerGroup"]*2)        --x = 340, y = 5, w = 104 , h = 60,
    local gi = gui:group('', {x = 0, y = 0, w = room_item_width, h = room_item_height})
    gi.lsm = true
    gi.bgcolor = {255,255,255,0}
    local widget_room_image = gui:image("", scrollitem_img_pos, gi, room_image_..j..".jpg")  --放置对应的战斗模式图片作为房间图像
    local widget_room_id = gui:text(room_id, scrollitem_textid_pos, gi, false, {255, 255, 255, 0})
    local widget_room_mode = gui:text(room_mode, scrollitem_textmode_pos, gi, false, {255, 255, 255, 0})--, {255,255,255,20})
    local widget_room_people = gui:text(room_people, scrollitem_textpeople_pos, gi, false, {255, 255, 255, 0})--, {255,255,255,20})
    widget_room_id:setfont(font_small)
    widget_room_mode:setfont(font_small)
    widget_room_people:setfont(font_small)
    scrollgroup:addChild(gi)
  end
  scrollgroup:allChildAdded()
  scrollgroup:scrollToTop()
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
    init_table["groupId"] = 1
    init_table["roomMasterId"] = "root"
    init_table["playersInfo"] = {}
    init_table["gameMode"] = selected_room_item["gameMode"]   --
    init_table["mapType"] = selected_room_item["mapType"]
    init_table["lifeNumber"] = selected_room_item["lifeNumber"]
    init_table["playersPerGroup"] = selected_room_item["playersPerGroup"]  --
    init_table["PlayerInfos"] = {
      [1] = {
        [1] = {["playerId"] = "lsm", ["playerStatus"] = 1, ["tankType"] = 1},
        [2] = {["playerId"] = "hackhao", ["playerStatus"] = 1, ["tankType"] = 4},
        [3] = {["playerId"] = "yuge", ["playerStatus"] = 2, ["tankType"] = 3},
        [4] = {["playerId"] = "james", ["playerStatus"] = 1, ["tankType"] = 1}
      },--groupId为1的所有players
      [2] = {
        [1] = {["playerId"] = "lsm2", ["playerStatus"] = 1, ["tankType"] = 1},
        [2] = {["playerId"] = "hackhao2", ["playerStatus"] = 1, ["tankType"] = 6},
        [3] = {["playerId"] = "yuge2", ["playerStatus"] = 1, ["tankType"] = 7},
      }--groupId为2的所有players
    }
    --init_table[""] = 
    local room = require("boom.scenes.room")
    game_state.switch(room, init_table)
  end
end

--移除所有的控件
remove_widgets = function()
  gooi.removeComponent(lbl_title)
  gooi.removeComponent(lbl_masterimg)
  gooi.removeComponent(lbl_roomid)
  gooi.removeComponent(lbl_mode)
  gooi.removeComponent(lbl_people)
  if scrollgroup then
    scrollgroup:clean()
  end
end


function roomlist:draw()
  --local bgimg = lg.newImage("assets/bgimg.jpg")
  lg.draw(bgimg,0,0)
  camera:attach()
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
  camera:detach()
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
    print("there is 0 rooms!")
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
  update_scrollgroup_widgets()   --更新scrollgroup的显示
  refreshing = false
end

--收到服务器对进入房间请求的响应
function RoomListNetHandler:fireEnterRoomResEvent(event)
  print("RoomListNetHandler:fireEnterRoomResEvent")
  local responseCode = event.responseCode
  local groupId = event.groupId + 1
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
    local PlayerInfos = {[1] = {}, [2] = {}}
    if playersInfo[1] then
      PlayerInfos[1] = playersInfo[1]
    end
    if playersInfo[2] then
      PlayerInfos[2] = playersInfo[2]
    end 
    init_table["PlayerInfos"] = PlayerInfos
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
