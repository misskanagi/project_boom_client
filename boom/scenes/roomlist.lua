--管理房间列表
local roomlist = class("roomlist")

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local lg = love.graphics

local game_state = require("libs.hump.gamestate")
local create_room = require("boom.scenes.create_room")
local room = require("boom.scenes.room")
--前置声明
local scroll_update, begin_move_scrollgroup, stop_move_scrollgroup, refresh

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
local room_selected_index = 1 --当前被选中的房间的index
local scroll_window_index = 1 --变化范围是1~room_item_num_per_page
local scroll_focous_time_bound = 0.2  -- 按住方向键0.8s以后，开始快速滑动room_item
local scroll_focous_time_account = 0
local scroll_focous_flag = false
local scroll_frame_time_gap_bound = 0.05  -- 按住方向键以后，每过150ms越过一个room_item
local scroll_frame_time_gap_account = 0
local room_item_num_per_page = 3 -- 一页显示几个room_item
local room_scroll_x = 10
local room_scroll_y = 70
local room_scroll_w = 444   --scroll条占16pixel宽
local room_scroll_h = 210
local room_item_height = 70
local room_item_width = 460
local room_items = {}  --存放所有的room item的text

function roomlist:enter()
  --love.window.setFullscreen(true)
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
  scrollgroup = gui:scrollgroup(nil, {room_scroll_x, room_scroll_y, room_scroll_w, room_scroll_h}, nil, 'vertical', {255,255,255,20}) -- scrollgroup will create its own scrollbar
  scrollgroup.scrollv.drop = function(self, direction) -- 滑动监听
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
            if room_selected_index > #room_items - room_item_num_per_page then
              --此时不更新滑动
            else
              self.values.current = new_position
            end
          end
        end
        gui:feedback(""..room_selected_index)
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
            if room_selected_index ~= #room_items then
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
        gui:feedback(""..room_selected_index)
      end
      -- 播放一个"咻"的音效
    end
    -- 播放一个"吥"的滑到底了的音效
    --gui:feedback('current focous room '..room_selected_index)
  end
  
  scrollgroup.scrollv.update_focous = function(self, prev_index, current_index)
    if not(prev_index < 1 or prev_index > #room_items) then
      local old_item = room_items[prev_index]
      old_item.bgcolor = {255,255,255,20}
    end
    if not(current_index < 1 or current_index > #room_items) then
      local new_item = room_items[current_index]
      new_item.bgcolor = {255,255,255,50}
    end
  end

  scrollgroup.scrollv.values.step = room_item_height -- 滑动一次的距离是一个room_item的高度
  
  for i = 1, 20 do
    local room_item = gui:text(""..i, {w = room_item_width, h = room_item_height}, nil, nil, {255,255,255,20})
    room_items[#room_items+1] = room_item
    scrollgroup:addchild(room_item, 'vertical')
  end
  scrollgroup.scrollv:update_focous(0, room_selected_index)
end

function roomlist:update(dt)
  scroll_update(dt)
  gui:update(dt)
  gooi.update(dt)
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
        if love.keyboard.isDown("up") or joystick:isGamepadDown("dpup") then
          scroll:drop("up")
        end
        if love.keyboard.isDown("down") or joystick:isGamepadDown("dpdown") then
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

--手动刷新房间列表
refresh = function()
  
end

--进入房间
enter_room = function()
  --将自己的id和要进入的房间id一同发送给Server，Server准入以后，切换场景
  game_state.switch(room)
end


function roomlist:draw()
  
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
end


local function handle_input()
end


function roomlist:textinput(text)
    gooi.textinput(text)
end

function roomlist:gamepadpressed(joystick, button)
  -- 此处直接处理所有的手柄操作
  if button == "b" then
    enter_room()
  elseif button == 'dpup' then
    begin_move_scrollgroup("up")
  elseif button == 'dpdown' then
    begin_move_scrollgroup("down")
  elseif button == 'rightshoulder' then
    game_state.switch(create_room)
  end
end

function roomlist:gamepadreleased(joystick, button)
  if button == "dpup" or button == "dpdown" then
    if not(joystick:isGamepadDown("dpup") or joystick:isGamepadDown("dpdown")) then
      stop_move_scrollgroup()
    end
  end
end

function roomlist:keypressed(key, scancode, isrepeat)
  if key == "b" then
    --game_state.switch(test_place)
  elseif key == 'up' then
    begin_move_scrollgroup("up")
  elseif key == 'down' then
    begin_move_scrollgroup("down")
  elseif key == 'r' then
    game_state.switch(create_room)
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