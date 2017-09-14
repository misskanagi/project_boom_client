--进入房间以后的ui,
local room = class("room")

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local lg = love.graphics
local roomId = nil
local roomMasterId = nil
local groupId = nil
local playersInfo = nil

local room_people = 4 --每队几个人

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
local lbl_enemies = nil  --所有的我方玩家的label信息
local lbl_friends = nil  --所有的敌方玩家的label信息
local grid_friends = nil
local gooi_widgets = {}
local scrollgroup = nil --坦克背包
--坦克背包scrollgroup的各项参数
local room_selected_index = 1 --当前被选中的房间的index
local scroll_window_index = 1 --变化范围是1~room_item_num_per_page
local scroll_focous_time_bound = 0.2  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_focous_time_account = 0
local scroll_focous_flag = false
local scroll_frame_time_gap_bound = 0.05  -- 按住方向键以后，每过150ms越过一个room_item
local scroll_frame_time_gap_account = 0
local room_item_num_per_page = 3 -- 一页显示几个room_item
local room_scroll_x = 10
local room_scroll_y = 120
local room_scroll_w = 120   --scroll条占16pixel宽
local room_scroll_h = 150
local room_item_height = 50   --room_item_height * room_item_num_per_page == room_scroll_h，这一点在这里就要保证，不然会出问题
local room_item_width = 120
local scroll_items = {} --存放滑动列表中的所有的items

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
  [1] = {["playerId"] = "lsm", ["playerStatus"] = true},
  [2] = {["playerId"] = "hackhao", ["playerStatus"] = true},
  [3] = {["playerId"] = "yuge", ["playerStatus"] = false},
  [4] = {["playerId"] = "james", ["playerStatus"] = true}
  }
local friend_infos = {
  [1] = {["playerId"] = "lsm2", ["playerStatus"] = true},
  [2] = {["playerId"] = "hackhao2", ["playerStatus"] = true},
  [3] = {["playerId"] = "yuge2", ["playerStatus"] = false},
  --[4] = {["playerId"] = "james2", ["playerStatus"] = false}
  }  --存放所有的我方玩家信息

--前置声明
local update_players, choose_tank, remove_widgets, scroll_update, begin_move_scrollgroup, stop_move_scrollgroup

update_players = function(dt)
  
end

choose_tank = function()
end

remove_widgets = function()
  for k,v in pairs(gooi_widgets) do
    gooi.remove(v)
  end
  gooi_widgets = nil
  gui:rem(scrollgroup)
end  
  
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
  roomId = init_table and init_table["roomId"]
  roomMasterId = init_table and init_table["roomMasterId"]
  groupId = init_table and init_table["groupId"]
  playersInfo = init_table and init_table["playersInfo"] or {}
  
  --init_table中有roomId,roomMasterId,groupId,playersInfo
  gridRoominfo = gooi.newPanel({x = gridRoominfo_x, y = gridRoominfo_y , w = gridRoominfo_w, h = gridRoominfo_h, layout = "grid 4x1"})
  
  --lbl_title = gooi.newLabel({text = "RoomInfo"}):left()
  lbl_mode = gooi.newLabel({text = "mode:".."chaos"}):left()
  lbl_people = gooi.newLabel({text = "people:".."4 vs 4"}):left()
  lbl_life = gooi.newLabel({text = "life:".."5"}):left()
  lbl_map = gooi.newLabel({text = "map:".."as_snow"}):left()
  --gridRoominfo:add(lbl_title, "1,1")
  gridRoominfo:add(lbl_mode, "1,1")
  gridRoominfo:add(lbl_people, "2,1")
  gridRoominfo:add(lbl_life, "3,1")
  gridRoominfo:add(lbl_map, "4,1")
  table.insert(gooi_widgets, gridRoominfo)
  --table.insert(gooi_widgets, lbl_title)
  table.insert(gooi_widgets, lbl_mode)
  table.insert(gooi_widgets, lbl_people)
  table.insert(gooi_widgets, lbl_life)
  table.insert(gooi_widgets, lbl_map)
  
  --创建敌方的显示列表
  grid_enemies = gooi.newPanel({x = grid_enemies_x, y = grid_enemies_y, w = grid_enemies_w, h = grid_enemies_h, layout = "grid 4x2"})
  local img_ready = lg.newImage("assets/sign_bullet.png")
  for i = 1, 8 do
    if i <= #enemy_infos then
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      local lbl_enemy = gooi.newLabel({text = enemy_infos[i]["playerId"]}):left()
      if enemy_infos[i]["playerStatus"] then
        lbl_enemy:setIcon(img_ready)
      else
        --lbl_enemy设置一个空的图片作为icon
      end
      grid_enemies:add(lbl_enemy, r..","..c)
      table.insert(gooi_widgets, lbl_enemy)
    elseif i <= room_people then
      --还未到来的选手
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      local lbl_enemy = gooi.newLabel({text = ""}):left()
      grid_enemies:add(lbl_enemy, r..","..c)
      table.insert(gooi_widgets, lbl_enemy)
    else
      --永远的空位
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      local lbl_enemy = gooi.newLabel({text = "————"}):center()
      grid_enemies:add(lbl_enemy, r..","..c)
      table.insert(gooi_widgets, lbl_enemy)
    end
  end
  
  --创建我方的显示列表
  grid_friends = gooi.newPanel({x = grid_friends_x, y = grid_friends_y, w = grid_friends_w, h = grid_friends_h, layout = "grid 4x2"})
  for i = 1, 8 do
    if i <= #friend_infos then
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      local lbl_friend = gooi.newLabel({text = friend_infos[i]["playerId"]}):left()
      if friend_infos[i]["playerStatus"] then
        --设置该玩家的tankType对应的tank缩略图作为icon
        lbl_friend:setIcon(img_ready)
      else
        --如果没有ready，就设置一个空icon
      end
      grid_friends:add(lbl_friend, r..","..c)
      table.insert(gooi_widgets, lbl_friend)
    elseif i <= room_people then
      --还未到来的选手
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      local lbl_friend = gooi.newLabel({text = ""}):left()
      grid_friends:add(lbl_friend, r..","..c)
      table.insert(gooi_widgets, lbl_friend)
    else
      --永远的空位
      local r = (i-1) % 4 + 1
      local c = math.floor((i-1)/4) + 1
      local lbl_friend = gooi.newLabel({text = "————"}):center()
      grid_friends:add(lbl_friend, r..","..c)
      table.insert(gooi_widgets, lbl_friend)
    end
  end
  
  
  --创建一个选择tank的列表
  --创建scollgroup
  scrollgroup = gui:scrollgroup(nil, {room_scroll_x, room_scroll_y, room_scroll_w, room_scroll_h}, nil, 'vertical', {255,255,255,20}) -- scrollgroup will create its own scrollbar
  -- 设置scrollgroup的滑动监听函数
  scrollgroup.scrollv.drop = function(self, direction) 
    --参数的类型检查
    if (direction ~= nil and type(direction) == "string") then
      if direction == "up" then
        if scroll_window_index > 1 then
          --滑动窗口还没有到最底下
          scroll_window_index = scroll_window_index - 1
          room_selected_index = room_selected_index - 1
          self:update_focous(room_selected_index+1, room_selected_index)
        else
          local scroll_old_position = self.values.current
          local new_position = math.max(self.values.min, self.values.current - self.values.step) 
          if new_position == scroll_old_position then
            --无法在继续向上滑动了
            if room_selected_index ~= 1 then
              room_selected_index = room_selected_index - 1
              self:update_focous(room_selected_index+1, room_selected_index)
            end
          else
            --可以继续向上滑动
            room_selected_index = room_selected_index - 1
            self:update_focous(room_selected_index+1, room_selected_index)
            if room_selected_index > #scroll_items - room_item_num_per_page then
              --此时不更新滑动
            else
              self.values.current = new_position
            end
          end
        end
        --gui:feedback(""..room_selected_index)
      elseif direction == "down" then
        if scroll_window_index < room_item_num_per_page then
          --滑动窗口还没有到最底下
          scroll_window_index = scroll_window_index + 1
          room_selected_index = room_selected_index + 1
          self:update_focous(room_selected_index-1, room_selected_index)
        else
          local scroll_old_position = self.values.current
          local new_position = math.min(self.values.max, self.values.current + self.values.step) 
          if new_position == scroll_old_position then
            --无法在继续向下滑动了
            if room_selected_index ~= #scroll_items then
              room_selected_index = room_selected_index + 1
              self:update_focous(room_selected_index-1, room_selected_index)
            end
          else
            --可以继续向下滑动
            room_selected_index = room_selected_index + 1
            self:update_focous(room_selected_index-1, room_selected_index)
            if room_selected_index <= room_item_num_per_page then
              --此时不更新滑动
            else
              self.values.current = new_position
            end
          end
        end
        --gui:feedback(""..room_selected_index)
      end
      -- 播放一个"咻"的音效
    end
    -- 播放一个"吥"的滑到底了的音效
    --gui:feedback('current focous room '..room_selected_index)
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
  scrollgroup.scrollv.values.step = room_item_height -- 滑动一次的距离是一个room_item的高度
  for i = 1, #tankbag do
    local tank_text = gui:text(tankbag[i], {0, 0, 140, 50}, nil, false, {255,255,255,20})
    scrollgroup:addchild(tank_text, 'vertical')
    scroll_items[#scroll_items+1] = tank_text
  end
  scrollgroup.scrollv:update_focous(0, 1)
  
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


function room:update(dt)
  --判断此时是否有服务器的EnterRoomBroadcast
  --如果有的话，那么更新一下
  
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
  local ready_string = "X-ready/cancel ready"
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


--上下键翻阅坦克背包，A键选中tank，B键ready或者取消ready，L键退房间，房主R键开始游戏！
function room:gamepadpressed(joystick, button)
  if button == "dpup" then
    begin_move_scrollgroup("up")
  elseif button == "dpdown" then
    begin_move_scrollgroup("down")
  elseif button == "b" then  --A键
    
  elseif button == "a" then  --B键
    
  elseif button == "leftshoulder" then
    
  elseif button == "rightshoulder" then
    
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


return room
