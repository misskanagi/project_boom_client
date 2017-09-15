--进入房间以后的ui,
local room = class("room")

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local game_state = require("libs.hump.gamestate")
local lg = love.graphics
--init_table中带入的数据
local myId = nil   --玩家自己的Id
local roomId = ""
local groupId = 1
local roomMasterId = ""
local gameMode = 1
local mapType = 1
local lifeNumber = 3
local playersPerGroup = 1
local roomState = nil   --waiting or gaming
local playersInRoom = 1
local PlayerInfos = nil   --包含房间内所有人的PlayerInfo, string playerId = 1;int32 playerStatus = 2;int32 groupId = 3;int32 tankType = 4;
local room_people = 4 --每队几个人

local img_ready = lg.newImage("assets/sign_bullet.png")
local img_blank = lg.newImage("assets/blank_32.png")

--固定尺寸
local window_w = 480
local window_h = 320
local gridRoominfo_x = 10
local gridRoominfo_y = 10
local gridRoominfo_w = 140
local gridRoominfo_h = 100
local grid_enemies_x = 160
local grid_enemies_y = 10
local grid_enemies_w = 300
local grid_enemies_h = 145
local grid_friends_x = 160
local grid_friends_y = 165
local grid_friends_w = 300
local grid_friends_h = 145

local gridRoominfo = nil
local lbl_title = nil
local lbl_mode = nil
local lbl_people = nil
local lbl_life = nil
local lbl_map = nil
local grid_enemies = nil  --放置每一个地方的信息
local grid_friends = nil
local friend_widgets = {}--敌方和我方的players信息展示控件
local enemy_widgets = {}  --有序
local gooi_widgets = {}
local scrollgroup = nil --坦克背包
--坦克背包scrollgroup的各项参数
local tank_selected_index = 1 --当前被选中的战车的index
local scroll_window_index = 1 --变化范围是1~scroll_item_num_per_page
local scroll_focous_time_bound = 0.2  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_focous_time_account = 0
local scroll_focous_flag = false
local scroll_frame_time_gap_bound = 0.05  -- 按住方向键以后，每过150ms越过一个room_item
local scroll_frame_time_gap_account = 0
local scroll_item_num_per_page = 3 -- 一页显示几个room_item
local scrollgroup_x = 10
local scrollgroup_y = 120
local scrollgroup_w = 120   --scroll条占16pixel宽
local scrollgroup_h = 150
local scroll_item_height = 50   --scroll_item_height * scroll_item_num_per_page == scrollgroup_h，这一点在这里就要保证，不然会出问题
local scroll_item_width = 120
local scroll_items = {} --存放滑动列表中的所有的items

--控制信息
local isready = false

local tankbag = {
  [1] = "tank1",
  [2] = "tank2",
  [3] = "tank3",
  [4] = "tank4",
  [5] = "tank5",
  [6] = "tank6",
  [7] = "tank7",
  [8] = "tank8",
  [9] = "tank9",
}  --存放所有的tank

--local enemy_players = {}  --存放所有的敌方玩家信息
local enemy_infos = {
  [1] = {["playerId"] = "lsm", ["playerStatus"] = 1},
  [2] = {["playerId"] = "hackhao", ["playerStatus"] = 1},
  [3] = {["playerId"] = "yuge", ["playerStatus"] = 2},
  [4] = {["playerId"] = "james", ["playerStatus"] = 1}
  }
local friend_infos = {
  [1] = {["playerId"] = "lsm2", ["playerStatus"] = 1},
  [2] = {["playerId"] = "hackhao2", ["playerStatus"] = 1},
  [3] = {["playerId"] = "yuge2", ["playerStatus"] = 2},
  --[4] = {["playerId"] = "james2", ["playerStatus"] = false}
}  --存放所有的我方玩家信息
--存放所有的玩家的信息，groupId作key
local all_players_infos = {
  [1] = {
    [1] = {["playerId"] = "lsm", ["playerStatus"] = 1},
    [2] = {["playerId"] = "hackhao", ["playerStatus"] = 1},
    [3] = {["playerId"] = "yuge", ["playerStatus"] = 2},
    [4] = {["playerId"] = "james", ["playerStatus"] = 1}
    },--groupId为1的所有players
  [2] = {
    [1] = {["playerId"] = "lsm2", ["playerStatus"] = 1},
    [2] = {["playerId"] = "hackhao2", ["playerStatus"] = 1},
    [3] = {["playerId"] = "yuge2", ["playerStatus"] = 2},
    }--groupId为2的所有players
  }

--前置声明
local update_players_widgets, ready, cancel_ready, remove_widgets, scroll_update, begin_move_scrollgroup, stop_move_scrollgroup, quit_room, begin_game,
isMaster, get_enterroom_broadcast, get_quitroom_broadcast, get_gamebegin_broadcast,get_gamecancelready_broadcast, get_gamereadybroadcast, handle_broadcast

--将获取到的广播内容直接传入handle_broadcast进行解析，调用相应的broadcast处理函数
handle_broadcast = function(broadcast)
end
--获取一个进入房间的广播以后的处理，新进入的玩家是playerId，组别是groupId
get_enterroom_broadcast = function(playerId, groupId)
  
end
--获取一个退出房间的广播以后的处理，退出的玩家是playerId，组别是groupId
get_quitroom_broadcast = function(isMaster, playerId, groupId)
  
end
--获取一个游戏开始的广播
get_gamebegin_broadcast = function()
  
end
--获取一个玩家取消ready状态的广播
get_gamecancelready_broadcast = function(playerId)
  
end
--获取一个玩家进入ready状态的广播
get_gamereadybroadcast = function(playerId, tankType)
  
end

--更新players的相应的控件
update_players_widgets = function()
  --当前的玩家
  --直接拿着新的friend_infos数据进行friend_widgets的更新
  for i = 1, 8 do
    if i <= #friend_infos then
      local f_widget = friend_widgets[i]
      local f_info_item = friend_infos[i]
      f_widget:setText(f_info_item["playerId"])
      if f_info_item["playerStatus"] == 1 then
        --设置一个坦克缩略图
        --f_widget:setIcon()
      else
        --设置一个空白图
        f_widget:setIcon(img_blank)
      end
    elseif i <= room_people then
      local f_widget = friend_widgets[i]
      f_widget:setText("")
      f_widget:setIcon(nil)
    else 
      break
    end
  end
  --直接拿着新的enemy_infos数据进行enemy_widgets的更新
  for i = 1, 8 do
    if i <= #enemy_infos then
      local e_widget = enemy_widgets[i]
      local e_info_item = enemy_infos[i]
      e_widget:setText(e_info_item["playerId"])
      if e_info_item["playerStatus"] == 1 then
        --设置一个准备完成的图片
        e_widget:setIcon(img_ready)
      else
        --设置一个空白图
        e_widget:setIcon(img_blank)
      end
    elseif i <= room_people then
      local e_widget = enemy_widgets[i]
      e_widget:setText("")
      e_widget:setIcon(nil)
    else 
      break
    end
  end
end

--判断当前玩家是否是房主
isMaster = function()
  return roomMasterId == myId
end

--ready
ready = function()
  isready = true
  --[[message GameReadyReq {
    string playerId = 1;
    string roomId = 2;
    int32 tankType = 3;}]]--
--发送

  gui:feedback("ready with the tank no."..tank_selected_index)
  --network args : myId, roomId,tank_selected_index
  
end
--cancel_ready
cancel_ready = function()
  isready = false
  --[[message GameCancelReady {
    string playerId = 1;
    string roomId = 2;
}]]--
  --发送
  gui:feedback("cancel ready")
  --network args : myId, roomId
  
end

--离开时移除所有的组件
remove_widgets = function()
  gui:feedback("remove_widgets")
  for k,v in pairs(gooi_widgets) do
    gooi.removeComponent(v)
    --gooi_widgets[k] = nil
  end
  gooi_widgets = {}
  enemy_widgets = {}
  friend_widgets = {}
  gui:rem(scrollgroup)
  scroll_items = {}
end  

--离开房间
quit_room = function()
  --[[message QuitRoomReq {
    string roomId = 1;
    string playerId = 2;}]]--
  --返回到roomlist中
  --network args : roomId, myId
  
  local roomlist = require("boom.scenes.roomlist")
  local init_table = {}
  init_table["myId"] = myId
  game_state.switch(roomlist, init_table)
end

--房主开始游戏
begin_game = function()
  --不是房主你开始个p啊
  if not isMaster() then
    return
  end
  --检查是否是已经全员到齐且全员ready
  if #friend_infos == room_people and #enemy_infos == room_people then
    for k, v in friend_infos do
      if not v["playerStatus"] == 1 then
        return
      end
    end
    for k, v in enemy_infos do
      if not v["playerStatus"] == 1 then
        return
      end
    end
  else
    return
  end
  --此时已经通过了全员到齐且ready的检查
  --向Server发送GameBeginReq的请求
  --[[message GameBeginReq {
    string roomId = 1;   //"-fail"
  }]]--
  --network args : roomId
end

--[[room的入口，有两种进入的可能：
1.roomlist:带入除了create_room带入的内容以外，还有所有PlayerInfo的集合
2.create_room:带入roomId,groupId,roomMasterId,gameMode,mapType,lifeNumber,playersPerGroup,roomState
]]--
function room:enter(pre, init_table)
  font_big = lg.newFont("assets/font/Arimo-Bold.ttf", 18)
  font_small = lg.newFont("assets/font/Arimo-Bold.ttf", 13)
  font_current = lg.getFont()
  style = {
      font = font_small,
      radius = 5,
      innerRadius = 3,
      showBorder = true,
  }
  gooi.setStyle(style)
  gooi.desktopMode()
  gooi.shadow()
  
  --把从init_table带进来的数据拿出来
  myId = init_table and init_table["myId"]
  roomId = init_table and init_table["roomId"]
  roomMasterId = init_table and init_table["roomMasterId"]
  groupId = init_table and init_table["groupId"]
  gameMode = init_table and init_table["gameMode"]
  mapType = init_table and init_table["mapType"]
  lifeNumber = init_table and init_table["lifeNumber"]
  playersPerGroup = init_table and init_table["playersPerGroup"]
  roomState = init_table and init_table["roomState"]
  PlayerInfos = init_table and init_table["PlayerInfos"]
  playersInRoom = init_table and init_table["playersInRoom"]
  --playersInfo = init_table and init_table["playersInfo"] or {}
  
  
  --init_table中有roomId,roomMasterId,groupId,playersInfo
  gridRoominfo = gooi.newPanel({x = gridRoominfo_x, y = gridRoominfo_y , w = gridRoominfo_w, h = gridRoominfo_h, layout = "grid 5x1"})
  
  lbl_title = gooi.newLabel({text = roomId}):left()
  lbl_mode = gooi.newLabel({text = "mode:"..gameMode}):left()
  lbl_people = gooi.newLabel({text = "people:"..playersPerGroup.." vs "..playersPerGroup}):left()
  lbl_life = gooi.newLabel({text = "life:"..lifeNumber}):left()
  lbl_map = gooi.newLabel({text = "map:"..mapType}):left()
  gridRoominfo:add(lbl_title, "1,1")
  gridRoominfo:add(lbl_mode, "2,1")
  gridRoominfo:add(lbl_people, "3,1")
  gridRoominfo:add(lbl_life, "4,1")
  gridRoominfo:add(lbl_map, "5,1")
  table.insert(gooi_widgets, gridRoominfo)
  table.insert(gooi_widgets, lbl_title)
  table.insert(gooi_widgets, lbl_mode)
  table.insert(gooi_widgets, lbl_people)
  table.insert(gooi_widgets, lbl_life)
  table.insert(gooi_widgets, lbl_map)
  
  --创建敌方的显示列表
  
  --创建groupId==1的显示列表
  grid_enemies = gooi.newPanel({x = grid_enemies_x, y = grid_enemies_y, w = grid_enemies_w, h = grid_enemies_h, layout = "grid 4x2"})
  for i = 1, 8 do
    local lbl_enemy = nil
    if i <= #enemy_infos then
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      lbl_enemy = gooi.newLabel({text = enemy_infos[i]["playerId"]}):left()
      if enemy_infos[i]["playerStatus"]==1 then
        lbl_enemy:setIcon(img_ready)
      else
        --lbl_enemy设置一个空的图片作为icon
        lbl_enemy:setIcon(img_blank)
      end
      grid_enemies:add(lbl_enemy, r..","..c)
    elseif i <= room_people then
      --还未到来的选手
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      lbl_enemy = gooi.newLabel({text = ""}):left()
      grid_enemies:add(lbl_enemy, r..","..c)
    else
      --永远的空位
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      lbl_enemy = gooi.newLabel({text = "————"}):center()
      grid_enemies:add(lbl_enemy, r..","..c)
    end
    enemy_widgets[#enemy_widgets+1] = lbl_enemy
    table.insert(gooi_widgets, lbl_enemy)
  end
  table.insert(gooi_widgets, grid_enemies)
  
  --创建我方的显示列表
  grid_friends = gooi.newPanel({x = grid_friends_x, y = grid_friends_y, w = grid_friends_w, h = grid_friends_h, layout = "grid 4x2"})
  for i = 1, 8 do
    local lbl_friend = nil
    if i <= #friend_infos then
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      lbl_friend = gooi.newLabel({text = friend_infos[i]["playerId"]}):left()
      if friend_infos[i]["playerStatus"]==1 then
        --设置该玩家的tankType对应的tank缩略图作为icon
        lbl_friend:setIcon(img_ready)
      else
        --如果没有ready，就设置一个空icon
        lbl_friend:setIcon(img_blank)
      end
      grid_friends:add(lbl_friend, r..","..c)
    elseif i <= room_people then
      --还未到来的选手
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      lbl_friend = gooi.newLabel({text = ""}):left()
      grid_friends:add(lbl_friend, r..","..c)
    else
      --永远的空位
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      lbl_friend = gooi.newLabel({text = "————"}):center()
      grid_friends:add(lbl_friend, r..","..c)
    end
    friend_widgets[#friend_widgets+1] = lbl_friend
    table.insert(gooi_widgets, lbl_friend)
  end
  table.insert(gooi_widgets, grid_friends)
  
  --创建一个选择tank的列表
  --创建scollgroup
  scrollgroup = gui:scrollgroup(nil, {scrollgroup_x, scrollgroup_y, scrollgroup_w, scrollgroup_h}, nil, 'vertical', {255,255,255,20}) -- scrollgroup will create its own scrollbar
  -- 设置scrollgroup的滑动监听函数
  scrollgroup.scrollv.drop = function(self, direction) 
    --参数的类型检查
    if (direction ~= nil and type(direction) == "string") then
      if direction == "up" then
        if scroll_window_index > 1 then
          --滑动窗口还没有到最底下
          scroll_window_index = scroll_window_index - 1
          tank_selected_index = tank_selected_index - 1
          self:update_focous(tank_selected_index+1, tank_selected_index)
        else
          local scroll_old_position = self.values.current
          local new_position = math.max(self.values.min, self.values.current - self.values.step) 
          if new_position == scroll_old_position then
            --无法在继续向上滑动了
            if tank_selected_index ~= 1 then
              tank_selected_index = tank_selected_index - 1
              self:update_focous(tank_selected_index+1, tank_selected_index)
            end
          else
            --可以继续向上滑动
            tank_selected_index = tank_selected_index - 1
            self:update_focous(tank_selected_index+1, tank_selected_index)
            if tank_selected_index > #scroll_items - scroll_item_num_per_page then
              --此时不更新滑动
            else
              self.values.current = new_position
            end
          end
        end
        --gui:feedback(""..tank_selected_index)
      elseif direction == "down" then
        if scroll_window_index < scroll_item_num_per_page then
          --滑动窗口还没有到最底下
          scroll_window_index = scroll_window_index + 1
          tank_selected_index = tank_selected_index + 1
          self:update_focous(tank_selected_index-1, tank_selected_index)
        else
          local scroll_old_position = self.values.current
          local new_position = math.min(self.values.max, self.values.current + self.values.step) 
          if new_position == scroll_old_position then
            --无法在继续向下滑动了
            if tank_selected_index ~= #scroll_items then
              tank_selected_index = tank_selected_index + 1
              self:update_focous(tank_selected_index-1, tank_selected_index)
            end
          else
            --可以继续向下滑动
            tank_selected_index = tank_selected_index + 1
            self:update_focous(tank_selected_index-1, tank_selected_index)
            if tank_selected_index <= scroll_item_num_per_page then
              --此时不更新滑动
            else
              self.values.current = new_position
            end
          end
        end
        --gui:feedback(""..tank_selected_index)
      end
      -- 播放一个"咻"的音效
    end
    -- 播放一个"吥"的滑到底了的音效
    --gui:feedback('current focous room '..tank_selected_index)
  end
  
  scrollgroup.scrollv.update_focous = function(self, prev_index, current_index)
    if not(prev_index < 1 or prev_index > #scroll_items) then
      local old_item = scroll_items[prev_index]
      old_item.bgcolor = {255,255,255,20}
    end
    if not(current_index < 1 or current_index > #scroll_items) then
      local new_item = scroll_items[current_index]
      new_item.bgcolor = {255,255,255,50}
    end
  end
  scrollgroup.scrollv.values.step = scroll_item_height -- 滑动一次的距离是一个room_item的高度
  for i = 1, #tankbag do
    local tank_text = gui:text(tankbag[i], {0, 0, 140, 50}, nil, false, {255,255,255,20})
    scrollgroup:addchild(tank_text, 'vertical')
    scroll_items[#scroll_items+1] = tank_text
  end
  scrollgroup.scrollv:update_focous(0, 1)
  
end

function room:leave()
  gui:feedback("room:leave")
  remove_widgets()
end

function room:update(dt)
  --判断此时是否有服务器的broadcast
  --如果有的话，那么更新一下
  --GameCancelReadyBroadcast/EnterRoomBroadcast/QuitRoomBroadcast/EnterRoomBroadcast
  local broadcast = 1
  handle_broadcast(broadcast)
  update_players_widgets()  --根据最新的enemy_infos,friend_infos的内容更新所有的控件
  scroll_update(dt)
  gui:update(dt)
  gooi.update()
end

function room:draw()
  local r,g,b,a = lg.getColor()
  --绘制出两个玩家表格的格线
  --grid_enemies
  for i = 1, 5 do
    lg.line(grid_enemies_x, grid_enemies_y+(i-1)*grid_enemies_h/4, grid_enemies_x + grid_enemies_w, grid_enemies_y+(i-1)*grid_enemies_h/4)
  end
  for i = 1, 3 do
    lg.line(grid_enemies_x+(i-1)*grid_enemies_w/2, grid_enemies_y, grid_enemies_x+(i-1)*grid_enemies_w/2, grid_enemies_y+grid_enemies_h)
  end
  
  --grid_friends
  for i = 1, 5 do
    lg.line(grid_friends_x, grid_friends_y+(i-1)*grid_friends_h/4, grid_friends_x + grid_friends_w, grid_friends_y+(i-1)*grid_friends_h/4)
  end
  for i = 1, 3 do
    lg.line(grid_friends_x+(i-1)*grid_friends_w/2, grid_friends_y, grid_friends_x+(i-1)*grid_friends_w/2, grid_friends_y+grid_friends_h)
  end
  --绘制提示文字
  local font_current = lg.getFont()
  local ready_string = "O-ready/X-cancel ready"
  local quit_string = "L1-quit room"
  local begin_string = "R1-master begin game"
  lg.print(ready_string, 10, 270)
  lg.print(quit_string, 10, 270 + font_current:getHeight())
  lg.print(begin_string, 10, 270 + 2*font_current:getHeight())
  lg.setColor(0, 0, 0, 127)
  lg.rectangle("fill", gridRoominfo_x, gridRoominfo_y, gridRoominfo_w, gridRoominfo_h)
  lg.setColor(r,g,b,a)
  gui:draw()
  gooi.draw()
end

--上下键翻阅坦克背包，O键选中tank并ready，X键取消ready，L键退房间，房主R键开始游戏！
function room:gamepadpressed(joystick, button)
  if button == "dpup" then
    if isready then return end
    begin_move_scrollgroup("up")
  elseif button == "dpdown" then
    if isready then return end
    begin_move_scrollgroup("down")
  elseif button == "b" then  --O键
    ready()
  elseif button == "a" then  --X键
    cancel_ready()
  elseif button == "leftshoulder" then
    quit_room()
  elseif button == "rightshoulder" then
    begin_game()
  end
end

function room:gamepadreleased(joystick, button)
  if button == "dpup" or button == "dpdown" then
    if not(joystick and (joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown"))) then
      stop_move_scrollgroup()
    end
  end
end

function room:keypressed(key, scancode, isrepeat)
end

function room:keyreleased(key)
end


--该函数可以实现长按快速滑动的功能
scroll_update = function (dt)
  -- 判断用户是否正在上下查看房间
  local scroll = scrollgroup.scrollv
  if scroll_focous_flag == true then
    scroll_focous_time_account = scroll_focous_time_account + dt
    if scroll_focous_time_account >= scroll_focous_time_bound then
      --已经达到了可以开始飞速滑动的时间线
      scroll_frame_time_gap_account = scroll_frame_time_gap_account + dt
      if scroll_frame_time_gap_account >= scroll_frame_time_gap_bound then
        scroll_frame_time_gap_account = 0
        if love.keyboard.isDown("up") or (joystick and joystick:isGamepadDown("dpup")) then
          scroll:drop("up")
        end
        if love.keyboard.isDown("down") or (joystick and joystick:isGamepadDown("dpdown")) then
          scroll:drop("down")
        end
      end
    end
  end
end

--用户使用键盘或者手柄操作scrollgroup,"up"/"down"
begin_move_scrollgroup = function(direction)
  if not (direction and type(direction) == "string") then
    return
  end
  if direction == "up" then
    scroll_focous_flag = true
    scroll_focous_time_account = 0
    local scroll = scrollgroup.scrollv
    scroll:drop("up")
  elseif direction == "down" then
    scroll_focous_flag = true
    scroll_focous_time_account = 0
    local scroll = scrollgroup.scrollv
    scroll:drop("down")
  end
end

--停止滑动scrollgroup
stop_move_scrollgroup = function()
  scroll_focous_time_account = 0
  scroll_focous_flag = false
end

return room
