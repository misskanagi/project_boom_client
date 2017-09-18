--liushenming，Gspot库的拓展

local scrollview = {}

local gui = nil   --需要在构造器中传入！
function scrollview.createObject(init_table, gui_obj)
  gui = gui_obj
  local sv_obj = {}  --存放了scrollview的各种参数的一个table
  
  sv_obj.x = init_table and init_table["x"]
  sv_obj.y = init_table and init_table["y"]
  sv_obj.item_width = init_table and init_table["item_width"] or 100
  sv_obj.item_height = init_table and init_table["item_height"] or 100
  sv_obj.item_num_per_page = init_table and init_table["item_num_per_page"] or 3
  sv_obj.time_before_fastscroll = init_table and init_table["time_before_fastscroll"]  --按住方向键多久以后开始快速滑动
  sv_obj.time_between_fastscroll = init_table and init_table["time_between_fastscroll"]  --快速滑动时，间隔多久滑过一个item
  sv_obj.bgcolor = init_table and init_table["bgcolor"] or {255,255,255,0}
  sv_obj.bgcolor_focous = init_table and init_table["bgcolor_focous"] or {255,255,255,50}
  sv_obj.parent = init_table and init_table["parent"]
  sv_obj.scroll_items = {} --存放scrollgroup中所有的滑动的item的group
  
  sv_obj.scrollgroup = gui:scrollgroup(nil, {sv_obj.x, sv_obj.y, sv_obj.item_width, sv_obj.item_height*sv_obj.item_num_per_page}, sv_obj.parent, 'vertical', sv_obj.bgcolor)
  sv_obj.scrollgroup.scrollv.values.step = sv_obj.item_height -- 设置滑动步长
  --sv_obj.scrollgroup.is_fixed_scissor = true
  --sv_obj.scrollgroup.spec_scissor = {x=0,y=0,w=200,h=400}
  --sv_obj.scrollgroup.scissor = {sv_obj.x, sv_obj.y, sv_obj.item_width, sv_obj.item_height*sv_obj.item_num_per_page}
  --sv_obj.scrollgroup.scrollv:update_focous(0, 1)
  
  --各种用于sv_obj的控制信息
  local reset
  local scroll_window_index = 1   --目前是滑动窗口中的哪一个item，范围是1~sv_obj.item_num_per_page
  local selected_index = 1
  local scroll_focous_flag = false  --此时是否正聚焦于滑动（长按方向键）
  local scroll_focous_time_account = 0
  local scroll_frame_time_gap_account = 0
  
  --滑动的过程中更新focous的背景颜色
  sv_obj.scrollgroup.scrollv.update_focous = function(self, prev_index, current_index)
    if not(prev_index < 1 or prev_index > #sv_obj.scroll_items) then
      local old_item = sv_obj.scroll_items[prev_index]   --old_item是一个gui:group
      old_item.bgcolor = sv_obj.bgcolor
    end
    if not(current_index < 1 or current_index > #sv_obj.scroll_items) then
      local new_item = sv_obj.scroll_items[current_index]
      new_item.bgcolor = sv_obj.bgcolor_focous
    end
  end
  
  --为sv_obj.scrollgroup的滑动条建立监听函数
  sv_obj.scrollgroup.scrollv.drop = function(self, direction) 
    --参数的类型检查
    if (direction ~= nil and type(direction) == "string") then
      if direction == "up" then
        if scroll_window_index > 1 then
          --滑动窗口还没有到最底下
          scroll_window_index = scroll_window_index - 1
          selected_index = selected_index - 1
          self:update_focous(selected_index+1, selected_index)
        else
          local scroll_old_position = self.values.current
          local new_position = math.max(self.values.min, self.values.current - self.values.step) 
          if new_position == scroll_old_position then
            --无法在继续向上滑动了
            if selected_index ~= 1 then
              selected_index = selected_index - 1
              self:update_focous(selected_index+1, selected_index)
            else
              if sv_obj.reachtop_listener then sv_obj.reachtop_listener() end
            end
          else
            --可以继续向上滑动
            selected_index = selected_index - 1
            self:update_focous(selected_index+1, selected_index)
            if selected_index > #sv_obj.scroll_items - sv_obj.item_num_per_page then
              --此时不更新滑动
            else
              self.values.current = new_position
            end
          end
        end
        --gui:feedback(""..selected_index)
      elseif direction == "down" then
        if scroll_window_index < sv_obj.item_num_per_page then
          --滑动窗口还没有到最底下
          scroll_window_index = scroll_window_index + 1
          selected_index = selected_index + 1
          self:update_focous(selected_index-1, selected_index)
        else
          local scroll_old_position = self.values.current
          local new_position = math.min(self.values.max, self.values.current + self.values.step) 
          if new_position == scroll_old_position then
            --无法在继续向下滑动了
            if selected_index ~= #sv_obj.scroll_items then
              selected_index = selected_index + 1
              self:update_focous(selected_index-1, selected_index)
            else
              if sv_obj.reachbottom_listener then sv_obj.reachbottom_listener() end
            end
          else
            --可以继续向下滑动
            selected_index = selected_index + 1
            self:update_focous(selected_index-1, selected_index)
            if selected_index <= sv_obj.item_num_per_page then
              --此时不更新滑动
              
            else
              self.values.current = new_position
            end
          end
        end
      end
      -- 播放一个"咻"的音效
      
    end
  end
  
  --该函数可以实现长按快速滑动的功能
  sv_obj.update = function(self, dt)
    --gui:feedback("!!!")
    -- 判断用户是否正在上下查看房间
    local scroll = self.scrollgroup.scrollv
    if scroll_focous_flag == true then
      scroll_focous_time_account = scroll_focous_time_account + dt
      if scroll_focous_time_account >= sv_obj.time_before_fastscroll then
        --已经达到了可以开始飞速滑动的时间线
        scroll_frame_time_gap_account = scroll_frame_time_gap_account + dt
        if scroll_frame_time_gap_account >= sv_obj.time_between_fastscroll then
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
  sv_obj.begin_move = function(self, direction)
    gui:feedback("begin_move")
    if not (direction and type(direction) == "string") then
      return
    end
    local scroll = self.scrollgroup.scrollv
    if direction == "up" then
      scroll_focous_flag = true
      scroll_focous_time_account = 0
      scroll:drop("up")
    elseif direction == "down" then
      scroll_focous_flag = true
      scroll_focous_time_account = 0
      scroll:drop("down")
    end
  end
  
  
  sv_obj.stop_move = function(self)
    gui:feedback("stop_move")
    scroll_focous_time_account = 0
    scroll_focous_flag = false
  end

  sv_obj.getSelectedIndex = function()
    return selected_index
  end
  
  sv_obj.addChild = function(self, item)
    self.scrollgroup:addchild(item, 'vertical')
    self.scroll_items[#self.scroll_items+1] = item
  end
  
  sv_obj.allChildAdded = function(self)
    self.scrollgroup.scrollv:update_focous(0, 1)
  end
  
  
  sv_obj.scrollUp = function(self)
    self:begin_move("up")
  end
  
  sv_obj.scrollDown = function(self)
    self:begin_move("down")
  end

  sv_obj.setReachBottomListener = function(listener_func)
    sv_obj.reachbottom_listener = listener_func
  end
  
  sv_obj.setReachTopListener = function(listener_func)
    sv_obj.reachtop_listener = listener_func
  end
  
  sv_obj.clean = function(self)
    gui:rem(self.scrollgroup)
    
    reset()
  end

  sv_obj.removeAllChildren = function(self)
    for i = #self.scroll_items, 1, -1 do
      gui:rem(self.scroll_items[i])
    end
    self.scroll_items = {}  --scroll_items中啥都没有了
    reset()
  end
  
  sv_obj.scrollToTop = function(self)
    self.scrollgroup.scrollv.values.current = self.scrollgroup.scrollv.values.min
    reset()
  end
  
  reset = function()
    selected_index = 1
    scroll_window_index = 1
    scroll_focous_flag = false
    scroll_focous_time_account = 0
    scroll_frame_time_gap_account = 0
  end
  
  return sv_obj 
end

return scrollview