--此时已经创建/选择了房间，room.lua是进入房间的UI

local room = {}
local first_time_to_update = true
local loading_success = false  --加载是否成功
local loading_timer = 0  --专门用于加载时的计时
local room_loaded = false --是否已经调用过了room.load()
local label
local lg = love.graphics
--一些进入房间的参数
local game_nvn = 4 --几对几
local player_count = game_nvn * 2 --到时候是要在load里面计算的。
local game_mode = "chaos"
local game_lifecount = 5 --每个人有几条命
local game_mapname = "mission1"
local game_condition = "beat all enemies!"

local my_id = "lsm_123" --保存了当前玩家的id
local my_player_info_x = 0
local my_player_info_y = 0
local my_player_info_w = 0
local my_player_info_h = 0
local my_player_info_alpha = 0

local player_infos = {["lsm_123"] = {["headimg"] = 1, ["tank"] = 1, ["rank"] = 10},
                      ["hackhao_james"] = {["headimg"] = 2, ["tank"] = 2, ["rank"] = 20},
                      ["stephon_curry"] = {["headimg"] = 3, ["tank"] = 3, ["rank"] = 40},
                      ["jwall"] = {["headimg"] = 4, ["tank"] = 1, ["rank"] = 20},
                      ["mamba"] = {["headimg"] = 5, ["tank"] = 1, ["rank"] = 12},
                      ["kobe_5rings!"] = {["headimg"] = 6, ["tank"] = 2, ["rank"] = 0},
                      ["linus"] = {["headimg"] = 7, ["tank"] = 3, ["rank"] = 1},
                      ["Mr.Right"] = {["headimg"] = 8, ["tank"] = 2, ["rank"] = 10}
                    }

--坦克背包中放置了所有玩家账号所拥有的tank
local tanks_in_bag = {
  [1] = {["name"] = "BLACKCAT", ["type"] = "tank_blue", ["hp_max"] = 80, ["mass"] = 50, ["acceleration"] = 20,["damping"] = 20, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 4},
  [2] = {["name"] = "CHEETAH", ["type"] = "tank_green", ["hp_max"] = 140, ["mass"] = 50, ["acceleration"] = 40, ["damping"] = 15, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 3},
  [3] = {["name"] = "BULL", ["type"] = "tank_blue", ["hp_max"] = 120, ["mass"] = 50, ["acceleration"] = 10,["damping"] = 20, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 3},
  [4] = {["name"] = "SHARK", ["type"] = "tank_green", ["hp_max"] = 140, ["mass"] = 50, ["acceleration"] = 30, ["damping"] = 55, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 4},
  [5] = {["name"] = "TIGER-I", ["type"] = "tank_blue", ["hp_max"] = 200, ["mass"] = 20, ["acceleration"] = 13,["damping"] = 20, ["speed_max"] = 100, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 5},
  [6] = {["name"] = "TIGER-II", ["type"] = "tank_green", ["hp_max"] = 220, ["mass"] = 50, ["acceleration"] = 14, ["damping"] = 15, ["speed_max"] = 900, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 2},
  [7] = {["name"] = "CROCODILE-I", ["type"] = "tank_blue", ["hp_max"] = 200, ["mass"] = 30, ["acceleration"] = 10,["damping"] = 20, ["speed_max"] = 300, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 3},
  [8] = {["name"] = "CROCODILE-II", ["type"] = "tank_green", ["hp_max"] = 150, ["mass"] = 50, ["acceleration"] = 13, ["damping"] = 15, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 5},
  [9] = {["name"] = "ASSASSIN", ["type"] = "tank_blue", ["hp_max"] = 180, ["mass"] = 50, ["acceleration"] = 30,["damping"] = 20, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 3},
  [10] = {["name"] = "SPYDER", ["type"] = "tank_green", ["hp_max"] = 100, ["mass"] = 50, ["acceleration"] = 40, ["damping"] = 15, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 6},
  [11] = {["name"] = "STEALER", ["type"] = "tank_blue", ["hp_max"] = 100, ["mass"] = 50, ["acceleration"] = 30,["damping"] = 20, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 3},
  [12] = {["name"] = "GHOST", ["type"] = "tank_green", ["hp_max"] = 130, ["mass"] = 50, ["acceleration"] = 10, ["damping"] = 15, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 2},
  [13] = {["name"] = "HUNTER", ["type"] = "tank_blue", ["hp_max"] = 200, ["mass"] = 50, ["acceleration"] = 30,["damping"] = 20, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 5},
  [14] = {["name"] = "PIRATE", ["type"] = "tank_green", ["hp_max"] = 130, ["mass"] = 50, ["acceleration"] = 10, ["damping"] = 15, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32, ["trafficcapacity"] = 3}

}
local tanklabels_in_bag = {}
local row_index_bag = 1   --此时玩家选择的tank背包中的索引
local col_index_bag = 1
local rows_in_bag = 5   --背包中有多少个行
local cols_in_bag = 10   --背包中有多少个列


local pRoomInfo_w, pRoomInfo_h, pRoomInfo_x, pRoomInfo_y
local pPlayerInfoItem_x, pPlayerInfoItem_ybase, pPlayerInfoItem_w, pPlayerInfoItem_h

--呼吸灯
local breath_loop_time = 1 --呼吸灯的时间长度
local breath_acc_time = breath_loop_time
local breath_sniff = false -- 是否是在吸气，吸气的话breath_acc_time递增

--各个本地函数的前置声明
local init_sizes  --一开始的时候计算各种尺寸，用于控件的初始化
local reset_comp_breath --让一个指定的gooi组件的bg透明度恢复为0
local update_player_infos --每当服务器传来最新的房内玩家信息时，调用该函数进行相应的更新操作
local choose_new_tank --每当player选中了一辆新坦克时，调用该函数来将最新的player信息发送给Server
local get_loading_func --用于返回一个closure，closure实现的功能是：动画播放/空间初始化

--当玩家更新自己的tank时候调用的函数
local update_my_tank = nil
--所有room范围内有效的控件
local label_tank_picture
local label_tank_name
local label_tank_hp
local label_tank_mass
local label_tank_width
local label_tank_height
local label_tank_speed
local label_tank_accelarate
local label_tank_damping
local label_tank_trafficcapacity
local label_tank_description



--恢复指定玩意儿的呼吸
reset_comp_breath = function(comp)
  local color = comp.style.bgColor
  comp:bg({color[1],color[2],color[3],0})
  breath_acc_time = breath_loop_time
  breath_sniff = false
end

--在第一次进入这个界面的时候，初始化所有需要根据当前屏幕尺寸计算出来的尺寸值。
init_sizes = function()
  --最后这些尺寸都从配置文件中去读。
  --左一边
  final_pRoomInfo_x = 10 --显示房间信息的面板
  pRoomInfo_y = 10
  pRoomInfo_w = lg.getWidth()/2 - 20
  pRoomInfo_h = lg.getHeight()/6
  pPlayerInfoTitle_x = 10   --显示所有玩家信息的一个面板
  pPlayerInfoTitle_y = pRoomInfo_y + pRoomInfo_h + 20
  pPlayerInfoTitle_w = lg.getWidth()/2 - 20
  pPlayerInfoTitle_h = 50
  pPlayerInfoItem_x = 10
  pPlayerInfoItem_ybase = pPlayerInfoTitle_y + pPlayerInfoTitle_h
  pPlayerInfoItem_w = lg.getWidth()/2 - 20
  pPlayerInfoItem_h = (lg.getHeight() - pPlayerInfoTitle_y - pPlayerInfoTitle_h - 40) / (player_count)
  --所有玩家的信息的背景板
  pPlayerInfos_x = 10
  pPlayerInfos_y = pPlayerInfoTitle_y + pPlayerInfoTitle_h
  pPlayerInfos_w = lg.getWidth()/2 - 20
  pPlayerInfos_h = lg.getHeight() - pPlayerInfoTitle_y - pPlayerInfoTitle_h - 30
  
  --右一边
  final_tank_bag_title_x = lg.getWidth()/2 + 10  --显示标题栏
  tank_bag_title_y = 10
  tank_bag_title_w = lg.getWidth()/2 - 20
  tank_bag_title_h = lg.getHeight()/6
  --details是包含四个部分的：坦克图像/坦克名称/坦克参数表/坦克描述
  final_details_x = lg.getWidth()/2 + 10
  details_y = tank_bag_title_y + tank_bag_title_h + 20
  details_w = lg.getWidth()/2 - 20
  details_h = lg.getHeight()/3
  details_image_x = final_details_x
  details_image_y = details_y
  details_image_w = details_h - 100  --图像要是一个正方形区域
  details_image_h = details_h - 100
  details_name_x = final_details_x
  details_name_y = details_y + details_image_h
  details_name_w = details_h - 100
  details_name_h = 100
  details_attributes_x = final_details_x + details_image_w
  details_attributes_y = details_y
  details_attributes_w = details_w - details_image_w
  details_attributes_h = details_h - 100
  details_description_x = final_details_x + details_image_w
  details_description_y = details_y + details_image_h
  details_description_w = details_w - details_description_x
  details_description_h = 100
  
  final_tankbag_x = lg.getWidth()/2 + 10
  tankbag_y = details_y + details_h + 20
  tankbag_w = lg.getWidth()/2 - 20  --最后要调整成一定可以让每一个小坦克的图标占一个正方形的格子的尺寸
  tankbag_h = tankbag_w * rows_in_bag/ cols_in_bag 
end


--该函数用于当有任何的房间内玩家的数据变动时的处理，new_player_infos是新的玩家的数据
update_player_infos = function(new_player_infos)
  if not new_player_infos then
    return
  end
  --for k, v in 
end

--当player选中一辆新tank时，该函数被调用，向Server发送最新的玩家信息
choose_new_tank = function()
  local tank_index = (row_index_bag - 1) * cols_in_bag + col_index_bag
  if tanks_in_bag[tank_index] then
    local chosen_tank = tanks_in_bag[tank_index]
    --将my_id和tank_id一起发送到Server
    --吴允指
    
    --如果玩家选中的坦克是不同于原来的坦克，则刷新自己的player_info面板（白光一亮），然后上新数据
    --创建一个update_funcs的函数项
    local update_closure = function()
      local alpha_increasing = true   --表示现在是透明度增加还是减少的过程
      local dvalue_alpha = (255-0) * 2 / 0.3
      return function(dt)  --k是用于从update_funcs中移除这一个inner func时用的。
            --my_player_info_alpha从100增加到255，然后在减到100
            if alpha_increasing then
              if my_player_info_alpha < 255 then
                my_player_info_alpha = my_player_info_alpha + dt * dvalue_alpha  --计算出新的透明度
              else
                my_player_info_alpha = 255
                alpha_increasing = false
              end
            else
              if my_player_info_alpha > 0 then
                my_player_info_alpha = my_player_info_alpha - dt * dvalue_alpha
              else
                my_player_info_alpha = 0
                --此时已经完成了白光一闪的更新效果
                update_my_tank = nil
              end
            end 
          end  --end inner-function
    end
    update_my_tank = update_closure()  --设置update_my_tank函数，该函数会在room.update中被调用
  else
    --背包的这一个格子压根木有坦克，播放一个“嘟嘟”声以示警告
    
  end
end


--该函数用于返回一个closure，closure实现的功能是：动画播放/空间初始化
get_loading_func = function()
  --[[
  第一阶段：几个大色块飞入，此时每个有文字的色块上都遮罩着一个色板。（）
  第二阶段：1.load
            2.tank bag中的每一个tank依次吸气一遍。
  第三阶段：tank bag中的每一个tank一同吐气。
  第四阶段：所有的色块遮罩全部移开
  ]]--
  local loading_timer = 0
  local phase1_time = 0.5
  local opendoor_phase_time = 0.5
  local opendoor_phase_timer = 0   --开门阶段的计时器
  
  --local phase3_time = 0.5
  --计算一下每一个部分的飞行速度
  --设置好初始位置
  pRoomInfo_x = -(final_pRoomInfo_x  + pRoomInfo_w)
  tank_bag_title_x = lg.getWidth()
  details_x = lg.getWidth()
  tankbag_x = lg.getWidth()
  
  dvalue_roominfo_x = (final_pRoomInfo_x - pRoomInfo_x) / phase1_time
  dvalue_tank_bag_title_x = (final_tank_bag_title_x - tankbag_x) / phase1_time
  dvalue_details_x = (final_details_x - details_x) / phase1_time
  dvalue_tankbag_x = (final_tankbag_x - tankbag_x) / phase1_time

  --第三阶段的2个矩形坐标
  door_tank_bag_title_x = tank_bag_title_x --一开始同tank_bag_title_x
  door_tank_bag_title_y = tank_bag_title_y
  door_tank_bag_title_w = tank_bag_title_w
  door_tank_bag_title_h = tank_bag_title_h
  dvalue_door_tank_bag_title_x = (lg.getWidth() - final_tank_bag_title_x) / opendoor_phase_time
  
  door_details_x = details_x --一开始同details_x
  door_details_y = details_y
  door_details_w = details_w
  door_details_h = details_h
  dvalue_door_details_x = (lg.getWidth() - final_details_x) / opendoor_phase_time
  
  --有关呼吸灯的变量
  local time_per_breath = 0.01  --某一个坦克图标呼吸所需要的时间
  local item_breath_time_count = 0  --当前的坦克图标一共呼吸了多久
  local dvalue_alpha = 255 / time_per_breath 
  local dvalue_alpha2 = 255 / 0.5 --所有的坦克图标一起吐气的dvalue
  local current_breath_index = 1   --当前是哪一个tank图标在呼吸
  return function(dt)
    loading_timer = loading_timer + dt
    if loading_timer <= phase1_time then
      --现在还处在第一阶段
      pRoomInfo_x = pRoomInfo_x + dt * dvalue_roominfo_x
      tank_bag_title_x = tank_bag_title_x + dt * dvalue_tank_bag_title_x
      details_x = details_x + dt * dvalue_details_x
      tankbag_x = tankbag_x + dt * dvalue_tankbag_x
      --把门一点点地关上
      door_tank_bag_title_x = tank_bag_title_x
      door_details_x = details_x
    else
      --现在处在第二阶段，如果还没有load所有的gooi的控件，那么先load
      if room_loaded == false then
        --将第一阶段的gooi控件的坐标值固定到最终位置
        pRoomInfo_x = final_pRoomInfo_x
        tank_bag_title_x = final_tank_bag_title_x
        details_x = final_details_x
        tankbag_x = final_tankbag_x
        --色块有门的都关关好
        door_tank_bag_title_x = final_tank_bag_title_x
        door_details_x = final_details_x
        --gooi各个组件的位置已经到位了！可以load了
        room.load()
        room_loaded = true
      elseif current_breath_index <= #tanks_in_bag + 1  then --gooi控件的load已经完成，可以让坦克图标开始呼吸了
        if current_breath_index == #tanks_in_bag + 1 then
          --此时是刚刚结束所有的坦克图标的吸气
          --一起吐气
          local alpha_value = 255 - item_breath_time_count * dvalue_alpha2
          item_breath_time_count = item_breath_time_count + dt
          if alpha_value <= 0 then
            for i = 1, #tanks_in_bag do
              local r = math.floor((i - 1) / cols_in_bag) + 1
              local c = i - cols_in_bag * (r - 1)
              local item = tanklabels_in_bag[r][c]
              local color = item.style.bgColor
              item:bg({color[1], color[2], color[3], 0})
            end
            --ok了，呼吸的事情已经搞定了
            current_breath_index = #tanks_in_bag + 2   --出循环的条件
          else
            --设置到所有的tanklabels_in_bag的项上
            for i = 1, #tanks_in_bag do
              local r = math.floor((i - 1) / cols_in_bag) + 1
              local c = i - cols_in_bag * (r - 1)
              local item = tanklabels_in_bag[r][c]
              local color = item.style.bgColor
              item:bg({color[1], color[2], color[3], alpha_value})
            end
          end
        else
          -- 当前是current_breath_index的坦克图标在呼吸
          item_breath_time_count = item_breath_time_count + dt -- 总的呼吸时间都是在不停地增加
          if item_breath_time_count > time_per_breath then
            --可以让下一个图标呼吸了，先将当前的图标透明度设置为255
            local tank_item_row = math.floor((current_breath_index - 1) / cols_in_bag) + 1
            local tank_item_col = current_breath_index - cols_in_bag * (tank_item_row - 1)
            log.debug(tank_item_row.."x"..tank_item_col.." breath loop")
            local current_label_tank_item = tanklabels_in_bag[tank_item_row] and tanklabels_in_bag[tank_item_row][tank_item_col]
            if current_label_tank_item then
              local color = current_label_tank_item.style.bgColor
              current_label_tank_item:bg({color[1], color[2], color[3], 255})
            end
            current_breath_index = current_breath_index + 1
            item_breath_time_count = 0
          else 
            --呼吸啊
            local tank_item_row = math.floor((current_breath_index - 1) / cols_in_bag) + 1
            local tank_item_col = current_breath_index - cols_in_bag * (tank_item_row - 1)
            log.debug(tank_item_row.."x"..tank_item_col.." breath loop")
            local current_label_tank_item = tanklabels_in_bag[tank_item_row] and tanklabels_in_bag[tank_item_row][tank_item_col]
            if current_label_tank_item then
              local color = current_label_tank_item.style.bgColor
              local alpha_value = item_breath_time_count * dvalue_alpha
              current_label_tank_item:bg({color[1], color[2], color[3], alpha_value})
            end
          end
        end
      elseif opendoor_phase_timer <= opendoor_phase_time then --现在所有的坦克图标吸气已经结束了，可以把每个色块上的遮罩给拿开了。
        --现在处于第三阶段，把几个门打开
        door_tank_bag_title_x = door_tank_bag_title_x + dvalue_door_tank_bag_title_x * dt
        door_details_x = door_details_x + dvalue_door_details_x * dt
        opendoor_phase_timer = opendoor_phase_timer + dt
      else --门已经都拉开了
        door_tank_bag_title_x = lg.getWidth()
        door_details_x = lg.getWidth()
        loading_success = true
      end
    end
  end
end

function room.load()
  font_small = lg.newFont("assets/font/Arimo-Bold.ttf", 18)
  font_big = lg.newFont("assets/font/Arimo-Bold.ttf", 24)
  style = {
      font = font_small,
      radius = 5,
      innerRadius = 3,
      showBorder = true,
  }
  gooi.setStyle(style)
  
  --一大波控件来袭
  --RoomInfo：显示房间中的相关信息
  local pRoomInfo = gooi.newPanel({x = pRoomInfo_x, y = pRoomInfo_y , w = pRoomInfo_w, h = pRoomInfo_h, layout = "grid 3x8"})
  pRoomInfo:setRowspan(1,1,3)
  pRoomInfo:setColspan(1,2,2)  --mode:...
  pRoomInfo:setColspan(2,2,2)  --people:...
  pRoomInfo:setColspan(3,2,2)  --life:...
  pRoomInfo:setColspan(1,4,2)  --win condition
  pRoomInfo:setRowspan(2,4,2)  --condition....
  pRoomInfo:setColspan(2,4,2)
  pRoomInfo:setColspan(1,6,3)  --map图
  pRoomInfo:setRowspan(1,6,3)
  local label_roominfo = gooi.newLabel({text = "ROOMINFO"}):center()
  local label_mode = gooi.newLabel({text = "Mode : "..game_mode}):left()
  local label_people = gooi.newLabel({text = "People : "..(2 * game_nvn)}):left()
  local label_life = gooi.newLabel({text = "Life : "..game_lifecount}):left()
  local label_condition = gooi.newLabel({text = "Condition"}):center()
  local label_condition_value = gooi.newLabel({text = game_condition}):center()
  --label_map = gooi.newLabel({text = "Map"}):center()
  
  pRoomInfo:add(label_roominfo, "1,1")
  pRoomInfo:add(label_mode, "1,2")
  pRoomInfo:add(label_people, "2,2")
  pRoomInfo:add(label_life, "3,2")
  pRoomInfo:add(label_condition, "1,4")
  pRoomInfo:add(label_condition_value, "2,4")
  pRoomInfo.layout.debug = true
  
  --显示已经在房间中的玩家的基本情报
  local player_info_title = gooi.newPanel({x = pPlayerInfoTitle_x, y = pPlayerInfoTitle_y, w = pPlayerInfoTitle_w, h = pPlayerInfoTitle_h, layout = "game"})
  local label_player_info_title_order = gooi.newLabel({text = "ORDER", w = 70, h = pPlayerInfoTitle_h}):center()
  local label_player_info_title_head = gooi.newLabel({text = "HEAD", w = pPlayerInfoItem_h, h = pPlayerInfoTitle_h}):center()
  local label_player_info_title_id = gooi.newLabel({text = "ID", w = 200, h = pPlayerInfoTitle_h}):left()
  local label_player_info_title_tank = gooi.newLabel({text = "TANK", w = 200, h = pPlayerInfoTitle_h}):center()
  local label_player_info_title_rank = gooi.newLabel({text = "RANK", w = 200, h = pPlayerInfoTitle_h}):left()
  player_info_title:add(label_player_info_title_order, "t-l")
  player_info_title:add(label_player_info_title_head, "t-l")
  player_info_title:add(label_player_info_title_id, "t-l")
  player_info_title:add(label_player_info_title_tank, "t-l")
  player_info_title:add(label_player_info_title_rank, "t-l")
  
  
  --循环创建pPlayerlist中的列表项
  local i = 1
  for player_id, player_info in pairs(player_infos) do
    local img_head = lg.newImage("assets/head80/"..player_info["headimg"]..".png")
    local img_tank = lg.newImage("assets/raw/tank_blue_fire0.png")
    local player_info_item = gooi.newPanel({x = pPlayerInfoItem_x, y = pPlayerInfoItem_ybase + (i-1) * pPlayerInfoItem_h, w = pPlayerInfoItem_w, h = pPlayerInfoItem_h, layout = "game"})
    if player_id == my_id then
      --记录下来my_player_info的坐标
      my_player_info_x = pPlayerInfoItem_x
      my_player_info_y = pPlayerInfoItem_ybase + (i-1) * pPlayerInfoItem_h + 5
      my_player_info_w = pPlayerInfoItem_w
      my_player_info_h = pPlayerInfoItem_h
    end
    local label_room_order = gooi.newLabel({w = 70, h = pPlayerInfoItem_h, text = ""..i}):center()
    local label_head_image = gooi.newLabel({w = pPlayerInfoItem_h, h = pPlayerInfoItem_h, text = ""}):center():setIcon(img_head)  --存放头像的缩略图
    local label_player_id = gooi.newLabel({w = 200, h = pPlayerInfoItem_h, text = player_id}):left()
    local label_player_tank = gooi.newLabel({w = 200, h = pPlayerInfoItem_h, text = ""}):center():setIcon(img_tank)
    local label_player_rank = gooi.newLabel({w = 200, h = pPlayerInfoItem_h, text = player_info["rank"]}):left()
    player_info_item:add(label_room_order, "t-l")
    player_info_item:add(label_head_image, "t-l")
    player_info_item:add(label_player_id, "t-l")
    player_info_item:add(label_player_tank, "t-l")
    player_info_item:add(label_player_rank, "t-l")
    i = i + 1
  end


  --创建选择坦克的UI
  style.font = font_big
  local label_tank_bag_title = gooi.newLabel({x = tank_bag_title_x, y = tank_bag_title_y, w = tank_bag_title_w, h = tank_bag_title_h, text = "CHOOSE YOUR TANK"}):center()
  style.font = font_small
  --创建game布局用于包含坦克的详情介绍
  local img_tank = lg.newImage("assets/tank_green_fire0.png")
  label_tank_picture = gooi.newLabel({x = details_image_x, y = details_image_y, w = details_image_w, h = details_image_h, text = ""}):setIcon(img_tank)
  label_tank_name = gooi.newLabel({x = details_name_x, y = details_name_y, w = details_name_w, h = details_name_h}):center()
  local grid_attributes = gooi.newPanel({x = details_attributes_x, y = details_attributes_y, w = details_attributes_w, h = details_attributes_h, layout = "grid 4x2"})
  local current_tank_info = tanks_in_bag[(row_index_bag - 1) * cols_in_bag + col_index_bag]
  label_tank_hp = gooi.newLabel({text = "hp : "..current_tank_info["hp_max"]}):left()
  label_tank_mass = gooi.newLabel({text = "mass : "..current_tank_info["mass"]}):left()
  label_tank_width = gooi.newLabel({text = "width : "..current_tank_info["width"]}):left()
  label_tank_height = gooi.newLabel({text = "height : "..current_tank_info["height"]}):left()
  label_tank_speed = gooi.newLabel({text = "speed : "..current_tank_info["speed_max"]}):left()
  label_tank_accelarate = gooi.newLabel({text = "accelarate : "..current_tank_info["acceleration"]}):left()
  label_tank_damping = gooi.newLabel({text = "damping : "..current_tank_info["damping"]}):left()
  label_tank_trafficcapacity = gooi.newLabel({text = "traffic capacity : "..current_tank_info["trafficcapacity"]}):left()
  grid_attributes:add(label_tank_hp, "1,1")
  grid_attributes:add(label_tank_mass, "2,1")
  grid_attributes:add(label_tank_width, "3,1")
  grid_attributes:add(label_tank_height, "4,1")
  grid_attributes:add(label_tank_speed, "1,2")
  grid_attributes:add(label_tank_accelarate, "2,2")
  grid_attributes:add(label_tank_damping, "3,2")
  grid_attributes:add(label_tank_trafficcapacity, "4,2")
  --显示tank的描述信息
  label_tank_description = gooi.newLabel({x = details_description_x, y = details_description_y, w = details_description_w, h = details_description_h, text = "This is an incredible tank!"}):left()
  --创建坦克包的界面
  local tankbag = gooi.newPanel({x = tankbag_x, y = tankbag_y, w = tankbag_w, h = tankbag_h, layout = "grid "..rows_in_bag.."x"..cols_in_bag})
  --将每一个tanks_in_bag中的项的tank图绘制到方格里
  for r = 1, rows_in_bag do
    tanklabels_in_bag[r] = {}
    for c = 1, cols_in_bag do 
      local img = lg.newImage("assets/tank_blue_fire0.png")  --真实应该是从当前的tank选项中，获取img数据，进行绘制
      local tank_item_info = tanks_in_bag[(r - 1) * cols_in_bag + c]
      local label_tank_bag_img = gooi.newButton({text = ""}):bg({255,255,255,0}):center()
      if tank_item_info then
        label_tank_bag_img:setIcon(img)
      end
      tankbag:add(label_tank_bag_img, r..","..c)
      tanklabels_in_bag[r][c] = label_tank_bag_img   --将这个label保存起来，用于呼吸灯效果
    end
  end
  
  tankbag.layout.debug = true
end

function room.update(dt)
  if first_time_to_update then
    --此时需要先获取吴允指那里的房间最新信息（房间信息，玩家信息）
    init_sizes()
    loading_func = get_loading_func()
    first_time_to_update = false
  end
  if loading_success == false then
    --room.load()
    loading_func(dt)
  else
    --此时需要即时地获取最新的房间信息来更新房间展示
    --从S端获取有关房间的最新数据
    
    --update_player_infos(new_player_infos)
    
    --获取用户选择的最新坦克信息来更新坦克选择的情况
    local chosen_tank_info_item = tanks_in_bag[(row_index_bag - 1) * cols_in_bag + col_index_bag]  --当前所在焦点的tank
    if breath_sniff then
      breath_acc_time = breath_acc_time + dt
      if breath_acc_time >= breath_loop_time then
        breath_acc_time = breath_loop_time
        breath_sniff = false
      end
    else
      breath_acc_time = breath_acc_time - dt
      if breath_acc_time <= 0 then
        breath_acc_time = 0
        breath_sniff = true
      end
    end
    --呼吸灯透明度设置
    local label_tank_bag_item = tanklabels_in_bag[row_index_bag][col_index_bag]
    local color = label_tank_bag_item.style.bgColor
    label_tank_bag_item:bg({color[1],color[2],color[3],(breath_acc_time / breath_loop_time) * 180 + 75})
    
    if chosen_tank_info_item then
      label_tank_name:setText(chosen_tank_info_item["name"])
      label_tank_hp:setText("hp : "..chosen_tank_info_item["hp_max"])
      label_tank_mass:setText("mass : "..chosen_tank_info_item["mass"])
      label_tank_width:setText("width : "..chosen_tank_info_item["width"])
      label_tank_height:setText("height : "..chosen_tank_info_item["height"])
      label_tank_speed:setText("speed : "..chosen_tank_info_item["speed_max"])
      label_tank_accelarate:setText("accelerate : "..chosen_tank_info_item["acceleration"])
      label_tank_damping:setText("damping : "..chosen_tank_info_item["damping"])
      label_tank_trafficcapacity:setText("traffic capacity : "..chosen_tank_info_item["trafficcapacity"])
    end
    gooi.update(dt)
    --update一下update_funcs中的函数项
    if update_my_tank then
      update_my_tank(dt)
    end
  end
end


function room.draw()
  
  local r,g,b,a = lg.getColor()
  
  --画一条把屏幕分为两半的线
  lg.line(lg.getWidth()/2, 0,lg.getWidth()/2,lg.getHeight())

  -- 给pRoomInfo绘制背景色
  lg.setColor(0, 0, 0, 100)
  lg.rectangle("fill", pRoomInfo_x, pRoomInfo_y, pRoomInfo_w/8, pRoomInfo_h)
  lg.setColor(0, 0, 0, 60)
  lg.rectangle("fill", pRoomInfo_x + pRoomInfo_w/8, pRoomInfo_y, 7*pRoomInfo_w/8, pRoomInfo_h)
  -- 绘制pPlayerInfoTitle
  lg.setColor(0, 0, 0, 80)
  lg.rectangle("fill", pPlayerInfoTitle_x, pPlayerInfoTitle_y, pPlayerInfoTitle_w, pPlayerInfoTitle_h)
  -- 绘制pPlayerInfos的背景
  lg.setColor(0, 0, 0, 30)
  lg.rectangle("fill", pPlayerInfos_x, pPlayerInfos_y, pPlayerInfos_w, pPlayerInfos_h)
  --给my_id对应的player_info项设置一个底层色块，这个色块是不会更新透明度和颜色的
  lg.setColor(255, 255, 255, 100)
  lg.rectangle("fill", my_player_info_x, my_player_info_y, my_player_info_w, my_player_info_h)
  --绘制tank_bag_title的背景色
  lg.setColor(0, 0, 0, 127)
  lg.rectangle("fill", tank_bag_title_x, tank_bag_title_y, tank_bag_title_w, tank_bag_title_h)
  --绘制坦克details的整个背景
  lg.setColor(0, 0, 0, 40)
  lg.rectangle("fill", details_x, details_y, details_w, details_h)
  --绘制划分tank details的两条线，将tank图/名称/参数表格/描述分隔开；再绘制一个框把这四个框起来
  lg.setColor(0, 0, 0, 110)
  lg.line(details_x, details_y + (details_h - 100), details_x + details_w, details_y + (details_h - 100))
  lg.line(details_x + (details_h - 100), details_y, details_x + (details_h - 100), details_y + details_h)
  lg.rectangle("line", details_x, details_y, details_w, details_h)
  --绘制坦克bag的整个背景
  lg.setColor(0, 0, 0, 50)
  lg.rectangle("fill", tankbag_x, tankbag_y, tankbag_w, tankbag_h)
  
  gooi.draw()
  lg.setColor(255, 255, 255, my_player_info_alpha)
  lg.rectangle("fill", my_player_info_x, my_player_info_y, my_player_info_w, my_player_info_h)
  --绘制“门”
  lg.setColor(0, 0, 0, 255)
  lg.rectangle("fill", door_tank_bag_title_x, door_tank_bag_title_y, door_tank_bag_title_w, door_tank_bag_title_h)
  lg.rectangle("fill", door_details_x, door_details_y, door_details_w, door_details_h)
  lg.setColor(r,g,b,a)
end

function room.textinput(text)
    gooi.textinput(text)
end

function room.gamepadpressed(joystick, button)
  -- 此处直接处理所有的手柄操作
  if button == "guide" then
    if love.window.getFullscreen() then
      love.window.setFullscreen(false)
    else
      love.window.setFullscreen(true)
    end
  elseif button == "dpright" then
    reset_comp_breath(tanklabels_in_bag[row_index_bag][col_index_bag])
    col_index_bag = col_index_bag + 1
    if col_index_bag > cols_in_bag then
      col_index_bag = 1
    end
  elseif button == "dpleft" then
    reset_comp_breath(tanklabels_in_bag[row_index_bag][col_index_bag])
    col_index_bag = col_index_bag - 1
    if col_index_bag < 1 then
      col_index_bag = cols_in_bag
    end
  elseif button == "dpup" then
    reset_comp_breath(tanklabels_in_bag[row_index_bag][col_index_bag])
    row_index_bag = row_index_bag - 1
    if row_index_bag < 1 then
      row_index_bag = rows_in_bag
    end
  elseif button == "dpdown" then
    reset_comp_breath(tanklabels_in_bag[row_index_bag][col_index_bag])
    row_index_bag = row_index_bag + 1
    if row_index_bag > rows_in_bag then
      row_index_bag = 1
    end
  elseif button == "b" then
    --玩家选择一个tank
    choose_new_tank()
  elseif button == "leftshoulder" then
    --玩家按了L1键
    
  elseif button == "rightshoulder" then
    --玩家按了R1键
    
  end
  
  
  
  
end

function room.gamepadreleased(joystick, button)
  
end

return room