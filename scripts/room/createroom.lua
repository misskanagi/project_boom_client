-- 创建房间的界面
local gui = require "./libs/Gspot"
package.loaded["./libs/Gspot"] = nil
local networker = require "./scripts/chaos/networker"

local createroom = {}
local first_time_to_update = true
local level = 1 -- 整个列表分为第一级和第二级两个层次
local focous_index = 1 -- 整个列表的focous
-- 用于显示的选项
local battle_modes = {"classic", "game", "point", "star"}
local battle_scales = {1, 2, 3, 4}
local battle_maps = {"mission1"}
local focous_items = {battle_modes, battle_scales, battle_maps}
local final_chosen_indexes = {1, 1, 1} -- 最终选择的选项，[1][2][3]的值分别是index of battle_modes/battle_scales/battle_maps
-- 一大片尺寸
local title_width = love.graphics.getWidth()*2/3
local title_height = 100
local title_x = (love.graphics.getWidth()-title_width)/2
local title_y = 0
local gb_width = love.graphics.getWidth()*2/3
local gb_height = 200
local gb_x = (love.graphics.getWidth() - gb_width)/2
local gb_y = title_height + 20
local gbm_width = love.graphics.getWidth()/2
local gbm_height = 100
local gbm_x = 0
local gbm_y = 0
local sgbm_width = 300
local sgbm_height = gbm_height
local sgbm_x = gbm_width - sgbm_width
local sgbm_y = 0
local gbs_width = love.graphics.getWidth()/2
local gbs_height = 100
local gbs_x = 0
local gbs_y = gbm_y + gbm_height + 20  
local sgbs_width = 300
local sgbs_height = gbs_height
local sgbs_x = gbs_width - sgbs_width
local sgbs_y = 0
local gbmap_width = love.graphics.getWidth()/2
local gbmap_height = 100
local gbmap_x = 0
local gbmap_y = gbs_y + gbs_height + 20  
local sgbmap_width = 300
local sgbmap_height = gbmap_height
local sgbmap_x = gbmap_width - sgbmap_width
local sgbmap_y = 0
--绘制group_battle_mode/group_battle_scale/group_battle_map的焦点框
local focous_rectangle = {[1] = {["x"] = gb_x + gbm_x, ["y"] = gb_y + gbm_y, ["width"] = gbm_width, ["height"] = gbm_height},
                          [2] = {["x"] = gb_x + gbs_x, ["y"] = gb_y + gbs_y, ["width"] = gbs_width, ["height"]= gbs_height},
                          [3] = {["x"] = gb_x + gbmap_x, ["y"] = gb_y + gbmap_y, ["width"] = gbmap_width, ["height"]= gbmap_height}}
local focous_scrollgroups = {} -- [1] = group_battle_mode,[2] = group_battle_scale, [3] = group_battle_map
-- 一些flag
local createroom_request_submitted = false --已经向Server提出了创建房间的申请
local enterroom_request_submitted = false --已经向Server提出了进入房间的申请
local channel_createroom = nil
local channel_enterroom = nil



local function reset()
  
end


-- 播放一段声音
local function playsound(filename)
  if filename then
  end
  gui:feedback("xiuxiuxiu~")
end



function createroom.load()
  channel_createroom = love.thread.getChannel("channel_createroom") --main thread接收room thread转发Server的创建房间反馈
  channel_enterroom = love.thread.getChannel("channel_enterroom") --main thread接收room thread转发Server的进入房间反馈
  
  gui.util.setfont(gui, "assets/font/fertigo_pro_regular.ttf", 32)
  --先来个大标题
  local title = gui:text("create room", {x = title_x, y = title_y, w = title_width, h = title_height}, nil, nil, {0,0,0})
  -- 整个battle选项列表的group, 容纳gbm和gbs
  local group_battle = gui:group(nil, {x = gb_x, y = gb_y, w = gb_width, h = gb_height}, nil, {0,0,0})
  
  --focous index 1
  group_battle_mode = gui:group(nil, {x = gbm_x, y = gbm_y, w = gbm_width, h = gbm_height}, group_battle, {0,0,0})
  local text_battle_mode = gui:text("battle mode : ", {x = 0, y = 0, w = 200, h = gbm_height}, group_battle_mode, true, {0,0,0})
  local scrollgroup_battle_mode = gui:scrollgroup(nil, {sgbm_x, sgbm_y, sgbm_width, sgbm_height}, group_battle_mode, 'vertical', {0,0,0})
  for k, v in ipairs(battle_modes) do
    scrollgroup_battle_mode:addchild(gui:text(v, {w = sgbm_width, h = sgbm_height}, nil, false, {0,0,0}), 'vertical')
  end
  scrollgroup_battle_mode.scrollv.values.step = sgbm_height
  scrollgroup_battle_mode.scrollv.drop = playsound
  focous_scrollgroups[#focous_scrollgroups + 1] = scrollgroup_battle_mode
  
  
  --focous index 2
  group_battle_scale = gui:group(nil, {x = gbs_x, y = gbs_y, w = gbs_width, h = gbs_height}, group_battle, {0,0,0})
  local text_battle_scale = gui:text("battle scale : ", {x = 0, y = 0, w = 200, h = gbs_height}, group_battle_scale, false, {0,0,0})
  local scrollgroup_battle_scale = gui:scrollgroup(nil, {sgbs_x, sgbs_y, sgbs_width, sgbs_height}, group_battle_scale, 'vertical', {0,0,0})
  for k, v in ipairs(battle_scales) do
    scrollgroup_battle_scale:addchild(gui:text(v, {w = sgbs_width, h = sgbs_height}, nil, false, {0,0,0}), 'vertical')
  end
  scrollgroup_battle_scale.scrollv.values.step = sgbs_height
  scrollgroup_battle_scale.scrollv.drop = playsound
  focous_scrollgroups[#focous_scrollgroups + 1] = scrollgroup_battle_scale
  
  --focous index 3
  group_battle_map = gui:group(nil, {x = gbmap_x, y = gbmap_y, w = gbmap_width, h = gbmap_height}, group_battle, {0,0,0})
  local text_battle_map = gui:text("battle map : ", {x = 0, y = 0, w = 200, h = gbmap_height}, group_battle_map, false, {0,0,0})
  local scrollgroup_battle_map = gui:scrollgroup(nil, {sgbmap_x, sgbmap_y, sgbmap_width, sgbmap_height}, group_battle_map, 'vertical', {0,0,0})
  for k, v in ipairs(battle_maps) do
    scrollgroup_battle_map:addchild(gui:text(v, {w = sgbmap_width, h = sgbmap_height}, nil, false, {0,0,0}), 'vertical')
  end
  scrollgroup_battle_map.scrollv.values.step = sgbmap_height
  scrollgroup_battle_map.scrollv.drop = playsound
  focous_scrollgroups[#focous_scrollgroups + 1] = scrollgroup_battle_map
end


function createroom.update(dt)
  if first_time_to_update then
    createroom.load()
    first_time_to_update = false
  end
  gui:update(dt)
  
  if enterroom_request_submitted then
    --[[已经向Server提出了进入房间的请求，查看和room_thread对应channel中是否有数据，如果有，查看：
        Server返回确认信息，player进入room.lua；
        Server返回失败信息，player留在原地不动。。。
    ]]--
    if channel_enterroom then
      local data = channel_enterroom:pop()
      if data then
        -- 解析data，是进入成功还是失败
        local succeed = true
        -- 此处先假设成功
        if succeed then
          whereami = places["room"]
        end
      end
    end
    
  elseif createroom_request_submitted then
    --[[
      已经向Server提出要创建房间了，那么此时看一下room_thread有没有把room id搞到手，如果channel中有数据，查看:
        返回一个room id，表明房间创建成功；
        返回一个失败信息，说明此时不能创建房间；
      如果房间创建成功，那么房主是一定可以进入房间的，但是这里也走和选房间一样的流程，以简化room.lua中的处理逻辑 >.<
      房主发送自己的id和room id给Server，由Server进行裁决是否可以进入房间。
    ]]--
    if channel_createroom then
      local data = channel_createroom:pop()
      if data then
        -- 解析data，判断是否创建房间成功
        local succeed = true
        if succeed then
          local enter_request = "enter room"
          networker.send(enter_request)
          enterroom_request_submitted = true
        end
      end
    end
  end
  
end

function createroom.draw()
  gui:draw()
  -- 绘制level 1的focous方框
  local current_focous_rectangle = focous_rectangle[focous_index]
  love.graphics.rectangle("line", current_focous_rectangle.x, current_focous_rectangle.y, current_focous_rectangle.width, current_focous_rectangle.height)
  if level == 2 then
    -- level2的时候要绘制一个强调选中当前大项的方框
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.rectangle("fill", current_focous_rectangle.x, current_focous_rectangle.y, current_focous_rectangle.width, current_focous_rectangle.height)
    love.graphics.setColor(r,g,b,a)
  end
  
  if enterroom_request_submitted then
    --已经提出了进入房间的请求，说明房间已经创建完毕了
    love.graphics.print("now entering the room.........")
  elseif createroom_request_submitted then
    love.graphics.print("now we are creating room, please wait.......")
  end
end


function createroom.keypressed(key, scancode, isrepeat)
  --[[ 整个列表分为两级:
       第一级的时候，
        "up/down" : 移动焦点到战斗模式/参战人数/地图选择上，
        "a": 选中某一个条目进入第二级
        "l": 退出创建房间
        "r": 确认创建房间
       第二级的时候，
        "up/down" : 用于选择具体的条目中的项，比如在战斗模式中选夺旗/夺点...
        "b" : 退出二级，进入第一级
        "l" : 退出创建房间
        "r" : 确认创建房间
  ]]--
  if level == 1 then
    if key == 'up' then
      focous_index = focous_index - 1
      if focous_index == 0 then
        focous_index = 3
      end
    elseif key == 'down' then
      focous_index = focous_index + 1
      if focous_index == 4 then
        focous_index = 1
      end
    elseif key == 'a' then
      level = 2
    elseif key == 'l' then
      whereami = places["selectroom"]
      reset()
    end
  else
    if key == 'up' then
      -- 首先要先获取当前的scrollgroup
      local current_scrollgroup = focous_scrollgroups[focous_index]
      local num_of_items = #focous_items[focous_index]  --当前focous的选项类别下，一共有num_of_items个选项
      local current_value = final_chosen_indexes[focous_index]  --指的是当前大类里的小类的选择的索引值
      current_value = current_value - 1
      if current_value == 0 then
        current_value = num_of_items
      end
      -- 然后滑动这个current_scrollgroup，滑动的每一下都会记录选中了的新选项
      local scroll = current_scrollgroup.scrollv
      local scroll_old_position = scroll.values.current
      scroll.values.current = math.max(scroll.values.min, scroll.values.current - scroll.values.step)
      if scroll.values.current == scroll_old_position then
        -- 这一步使选项上下循环
        scroll.values.current = scroll.values.max 
      end
      scroll.drop()  --触发scroll滑动的回调
    elseif key == 'down' then
      -- 首先要先获取当前的scrollgroup
      local current_scrollgroup = focous_scrollgroups[focous_index]
      local num_of_items = #focous_items[focous_index]  --当前focous的选项类别下，一共有num_of_items个选项
      local current_value = final_chosen_indexes[focous_index]  --指的是当前大类里的小类的选择的索引值
      current_value = current_value + 1
      if current_value == num_of_items + 1 then
        current_value = 1
      end
      -- 然后滑动这个current_scrollgroup，滑动的每一下都会记录选中了的新选项
      local scroll = current_scrollgroup.scrollv
      local scroll_old_position = scroll.values.current
      scroll.values.current = math.min(scroll.values.max, scroll.values.current + scroll.values.step) 
      if scroll.values.current == scroll_old_position then
        -- 这一步使选项上下循环
        scroll.values.current = scroll.values.min 
      end
      scroll.drop()  --触发scroll滑动的回调
    elseif key == 'b' then
      level = 1
    elseif key == 'l'  then
      whereami = places["selectroom"]
      reset()
    end
  end
  
  -- 'r'键功能永远是确定创建房间
  if key == 'r' then
    --[[
      final_chosen_indexes中的3个值即是3个大类最终的选择，此处组织如下内容:
        1. 本玩家的id（作为房主登记）
        2. 房间创建配置
      然后，将创建房间的数据发送给Server。这样创建房间的请求就已经提交了。
    ]]--
    local request = "create room"
    networker.send(request)
    createroom_request_submitted = true
  end
end


function createroom.keyreleased(key)
end


return createroom