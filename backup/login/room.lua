--此时已经创建/选择了房间，room.lua是进入房间的UI

local room = {}
local first_time_to_update = true
local label
local lg = love.graphics
--一些进入房间的参数
local game_nvn = 4 --几对几
local player_count = game_nvn * 2 --到时候是要在load里面计算的。
local game_mode = "chaos"
local game_lifecount = 5 --每个人有几条命
local game_mapname = "mission1"
local game_condition = "beat all enemies!"
local player_infos = {[1] = {["id"] = "lsm_123", ["headimg"] = 1, ["tank"] = 1, ["rank"] = 10},
                      [2] = {["id"] = "hackhao_james", ["headimg"] = 2, ["tank"] = 2, ["rank"] = 20},
                      [3] = {["id"] = "stephon_curry", ["headimg"] = 3, ["tank"] = 3, ["rank"] = 40},
                      [4] = {["id"] = "jwall", ["headimg"] = 4, ["tank"] = 1, ["rank"] = 20},
                      [5] = {["id"] = "mamba", ["headimg"] = 5, ["tank"] = 1, ["rank"] = 12},
                      [6] = {["id"] = "kobe_5rings!", ["headimg"] = 6, ["tank"] = 2, ["rank"] = 0},
                      [7] = {["id"] = "linus", ["headimg"] = 7, ["tank"] = 3, ["rank"] = 1},
                      [8] = {["id"] = "Mr.Right", ["headimg"] = 8, ["tank"] = 2, ["rank"] = 10}
                    }

local pRoomInfo_w, pRoomInfo_h, pRoomInfo_x, pRoomInfo_y
local pPlayerInfoItem_x, pPlayerInfoItem_ybase, pPlayerInfoItem_w, pPlayerInfoItem_h

--前置声明
local init_sizes 

--在第一次进入这个界面的时候，初始化所有需要根据当前屏幕尺寸计算出来的尺寸值。
init_sizes = function()
  pRoomInfo_x = 10
  pRoomInfo_y = 10
  pRoomInfo_w = lg.getWidth()/2 - 20
  pRoomInfo_h = lg.getHeight()/6
  pPlayerInfoTitle_x = 10
  pPlayerInfoTitle_y = pRoomInfo_y + pRoomInfo_h + 20
  pPlayerInfoTitle_w = lg.getWidth()/2 - 20
  pPlayerInfoTitle_h = 50
  pPlayerInfoItem_x = 10
  pPlayerInfoItem_ybase = pPlayerInfoTitle_y + pPlayerInfoTitle_h + 20
  pPlayerInfoItem_w = lg.getWidth()/2 - 20
  pPlayerInfoItem_h = (lg.getHeight() - pPlayerInfoTitle_y - pPlayerInfoTitle_h - 40) / (player_count)
  
end


function room.load()
  font_big = lg.newFont("assets/font/Arimo-Bold.ttf", 18)
  font_small = lg.newFont("assets/font/Arimo-Bold.ttf", 13)
  style = {
      font = font_big,
      radius = 5,
      innerRadius = 3,
      showBorder = true,
  }
  gooi.setStyle(style)
  init_sizes()
  
  --一大波控件来袭
  --RoomInfo：显示房间中的相关信息
  pRoomInfo = gooi.newPanel({x = pRoomInfo_x, y = pRoomInfo_y , w = pRoomInfo_w, h = pRoomInfo_h, layout = "grid 2x8"})
  pRoomInfo:setRowspan(1,1,2)
  pRoomInfo:setColspan(1,6,3)
  pRoomInfo:setColspan(2,6,3)
  label_roominfo = gooi.newLabel({text = "ROOMINFO"}):center()
  label_mode = gooi.newLabel({text = "Mode"}):center()
  label_mode_value = gooi.newLabel({text = game_mode}):center()
  label_people = gooi.newLabel({text = "People"}):center()
  label_people_value = gooi.newLabel({text = ""..(2*game_nvn)}):center()
  label_map = gooi.newLabel({text = "Map"}):center()
  label_map_value = gooi.newLabel({text = game_mapname}):center()
  label_life = gooi.newLabel({text = "Life"}):center()
  label_life_value = gooi.newLabel({text = ""..game_lifecount}):center()
  label_condition = gooi.newLabel({text = "Condition"}):center()
  label_condition_value = gooi.newLabel({text = game_condition}):center()
  pRoomInfo:add(label_roominfo, "1,1")
  pRoomInfo:add(label_mode, "1,2")
  pRoomInfo:add(label_people, "1,3")
  pRoomInfo:add(label_map, "1,4")
  pRoomInfo:add(label_life, "1,5")
  pRoomInfo:add(label_condition, "1,6")
  pRoomInfo:add(label_mode_value, "2,2")
  pRoomInfo:add(label_people_value, "2,3")
  pRoomInfo:add(label_map_value, "2,4")
  pRoomInfo:add(label_life_value, "2,5")
  pRoomInfo:add(label_condition_value, "2,6")
  
  --显示已经在房间中的玩家的基本情报
  local player_info_title = gooi.newPanel({x = pPlayerInfoTitle_x, y = pPlayerInfoTitle_y, w = pPlayerInfoTitle_w, h = pPlayerInfoTitle_h, layout = "game"})
  local label_player_info_title_order = gooi.newLabel({text = "ORDER", w = 50, h = pPlayerInfoTitle_h}):center()
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
  for i = 1, player_count do
    local player_info = player_infos[i]
    local img_head = lg.newImage("assets/head80/"..player_info["headimg"]..".png")
    local img_tank = lg.newImage("assets/raw/tank_blue_fire0.png")
    local player_info_item = gooi.newPanel({x = pPlayerInfoItem_x, y = pPlayerInfoItem_ybase + (i-1) * pPlayerInfoItem_h, w = pPlayerInfoItem_w, h = pPlayerInfoItem_h, layout = "game"})
    local label_room_order = gooi.newLabel({w = 50, h = pPlayerInfoItem_h, text = ""..i}):center()
    local label_head_image = gooi.newLabel({w = pPlayerInfoItem_h, h = pPlayerInfoItem_h, text = ""}):center():setIcon(img_head)  --存放头像的缩略图
    local label_player_id = gooi.newLabel({w = 200, h = pPlayerInfoItem_h, text = player_info["id"]}):left()
    local label_player_tank = gooi.newLabel({w = 200, h = pPlayerInfoItem_h, text = ""}):center():setIcon(img_tank)
    player_info_item:add(label_room_order, "t-l")
    player_info_item:add(label_head_image, "t-l")
    player_info_item:add(label_player_id, "t-l")
    player_info_item:add(label_player_tank, "t-l")
  end

end


function room.update(dt)
  if first_time_to_update then
    room.load()
    first_time_to_update = false
  else
    gooi.update(dt)
  end
end


function room.draw()
  --画一个一半的线
  lg.line(lg.getWidth()/2, 0,lg.getWidth()/2,lg.getHeight())
  -- 给pRoomInfo绘制背景色
  local r,g,b,a = lg.getColor()
  lg.setColor(0, 0, 0, 127)
  lg.rectangle("fill", pRoomInfo_x, pRoomInfo_y, pRoomInfo_w/8, pRoomInfo_h)
  lg.setColor(0, 0, 0, 60)
  lg.rectangle("fill", pRoomInfo_x + pRoomInfo_w/8, pRoomInfo_y, 7*pRoomInfo_w/8, pRoomInfo_h)
  lg.setColor(r,g,b,a)
  gooi.draw()
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
  end
  
  
    
end

function room.gamepadreleased(joystick, button)
  
end

return room