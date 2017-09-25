--gameover以后播放的画面

local gameover = class("gameover")
local window_w = 960
local window_h = 720
local myId = nil
local winOrLose = nil
local group_info = nil
local game_state = require("libs.hump.gamestate")
local cam = require("boom.camera")
local camera = cam:instance()
require "./libs/gooi"

local lbl_winorlose = nil 
local table_battle = nil --对战信息表
local lbl_title_group_red = nil
local lbl_title_group_blue = nil
local lbl_title_id_red = nil
local lbl_title_id_blue = nil
local lbl_title_kill_red = nil
local lbl_title_kill_blue = nil
local lbl_title_dead_red = nil
local lbl_title_dead_blue = nil
local lbl_winorlose_x = 0
local lbl_winorlose_y = 0
local lbl_winorlose_w = 960
local lbl_winorlose_h = 60
local table_battle_x = 0
local table_battle_y = 70
local table_battle_w = 0
local table_battle_h = 0
local table_battle_item_w = 120
local table_battle_item_h = 60
local table_battle_rows = 0
local table_battle_cols = 0
local players_per_group = nil --每一个队里有几个人
local group_gameover = 4
local gooi_widgets = {}
local bgimg = love.graphics.newImage("assets/bgimg.jpg")


function gameover:enter(pre, init_table)
  myId = init_table and init_table["myId"]
  winOrLose = init_table and init_table["winOrLose"]
  group_info = init_table and init_table["group_info"]
  
  font_big = love.graphics.newFont("assets/font/Arimo-Bold.ttf", 26)
  font_small = love.graphics.newFont("assets/font/Arimo-Bold.ttf", 18)
  font_current = love.graphics.getFont()
  style = {
      font = font_big,
      radius = 5,
      innerRadius = 3,
      showBorder = true,
  }

  gooi.setStyle(style)
  gooi.desktopMode()
  gooi.shadow()
  
  lbl_winorlose = gooi.newLabel({text = "", x = lbl_winorlose_x, y = lbl_winorlose_y, w = lbl_winorlose_w, h = lbl_winorlose_h, group = group_gameover}):center()
  
  if winOrLose then
    lbl_winorlose:setText("You Win!")
  else
    lbl_winorlose:setText("You Lose!")
  end
  table.insert(gooi_widgets, lbl_winorlose)
  style.font = font_small
  --计算出players_per_group
  for k, v in pairs(group_info) do
    if v then
      if not players_per_group then
        players_per_group = #v
      elseif #v > players_per_group then
        players_per_group = #v
      end
    end
  end

  table_battle_rows = players_per_group+2
  table_battle_w = table_battle_item_w * 8
  table_battle_h = table_battle_item_h * table_battle_rows
  --table_battle_x = (window_w - table_battle_w) / 2
  --table_battle_y = (window_h - table_battle_h) / 2
    
  table_battle = gooi.newPanel({x = table_battle_x, y = table_battle_y , w = table_battle_w, h = table_battle_h, layout = "grid "..table_battle_rows.."x8", group = group_gameover})
  --调整一下表格
  table_battle
    :setColspan(1,1,4)
    :setColspan(1,5,4)
    
  for i = 2, table_battle_rows do
    table_battle
      :setColspan(i,1,2)
      :setColspan(i,5,2)
  end
  --table_battle.layout.debug = true
  lbl_title_group_red = gooi.newLabel({text = "Group1", group = group_gameover}):center()
  lbl_title_group_blue = gooi.newLabel({text = "Group2", group = group_gameover}):center()
  lbl_title_id_red = gooi.newLabel({text = "ID", group = group_gameover}):center()
  lbl_title_id_blue = gooi.newLabel({text = "ID", group = group_gameover}):center()
  lbl_title_kill_red = gooi.newLabel({text = "kill", group = group_gameover}):center()
  lbl_title_kill_blue = gooi.newLabel({text = "kill", group = group_gameover}):center()
  lbl_title_dead_red = gooi.newLabel({text = "dead", group = group_gameover}):center()
  lbl_title_dead_blue = gooi.newLabel({text = "dead", group = group_gameover}):center()
  table.insert(gooi_widgets, lbl_title_group_red)
  table.insert(gooi_widgets, lbl_title_group_blue)
  table.insert(gooi_widgets, lbl_title_id_red)
  table.insert(gooi_widgets, lbl_title_id_blue)
  table.insert(gooi_widgets, lbl_title_kill_red)
  table.insert(gooi_widgets, lbl_title_kill_blue)
  table.insert(gooi_widgets, lbl_title_dead_red)
  table.insert(gooi_widgets, lbl_title_dead_blue)
  lbl_ids_red = {} --key是行号
  lbl_kills_red = {} --key是行号
  lbl_deads_red = {}
  lbl_ids_blue = {}
  lbl_kills_blue = {}
  lbl_deads_blue = {}
  --创建出红队的每个选手的每一个控件
  for i = 1, players_per_group do 
    lbl_kills_red[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    lbl_ids_red[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    lbl_kills_red[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    lbl_deads_red[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    lbl_ids_blue[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    lbl_kills_blue[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    lbl_deads_blue[i] = gooi.newLabel({text = "", group = group_gameover}):center()
    table_battle:add(lbl_ids_red[i], (i+2)..",1")
    table_battle:add(lbl_kills_red[i], (i+2)..",3")
    table_battle:add(lbl_deads_red[i], (i+2)..",4")
    table_battle:add(lbl_ids_blue[i], (i+2)..",5")
    table_battle:add(lbl_kills_blue[i], (i+2)..",7")
    table_battle:add(lbl_deads_blue[i], (i+2)..",8")
    table.insert(gooi_widgets, lbl_ids_red[i])
    table.insert(gooi_widgets, lbl_kills_red[i])
    table.insert(gooi_widgets, lbl_deads_red[i])
    table.insert(gooi_widgets, lbl_ids_blue[i])
    table.insert(gooi_widgets, lbl_kills_blue[i])
    table.insert(gooi_widgets, lbl_deads_blue[i])
  end
  
  table_battle:add(lbl_title_group_red, "1,1")
  table_battle:add(lbl_title_group_blue, "1,5")
  table_battle:add(lbl_title_id_red, "2,1")
  table_battle:add(lbl_title_kill_red, "2,3")
  table_battle:add(lbl_title_dead_red, "2,4")
  table_battle:add(lbl_title_id_blue, "2,5")
  table_battle:add(lbl_title_kill_blue, "2,7")
  table_battle:add(lbl_title_dead_blue, "2,8")
  table.insert(gooi_widgets, table_battle)
  --镜头
  --camera:zoomTo(1.0)
  camera:lookAt(window_w/2, window_h/2)
end

function gameover:leave()
  for k, v in pairs(gooi_widgets) do
    gooi.removeComponent(v)
  end
end

function gameover:update(dt)
  --绘制具体的内容
  for k, v in pairs(group_info) do
    local group_id = k
    local group_players_info = v
    if group_id == 1 then  --红队
      for i = 1, #group_players_info do
        local player_info = group_players_info[i]
        if player_info then
          lbl_ids_red[i]:setText(player_info.player_id)
          lbl_kills_red[i]:setText(player_info.kill)
          lbl_deads_red[i]:setText(player_info.death)
        end
      end
    else
      for i = 1, #group_players_info do
        local player_info = group_players_info[i]
        if player_info then
          lbl_ids_blue[i]:setText(player_info.player_id)
          lbl_kills_blue[i]:setText(player_info.kill)
          lbl_deads_blue[i]:setText(player_info.death)
        end
      end
    end 
  end
  gooi.update(dt)
end

function gameover:draw()
  love.graphics.draw(bgimg,0,0)
  camera:attach()
  --绘制图表
  local r,g,b,a = love.graphics.getColor()
  --画一个竖线
  love.graphics.line(table_battle_x+table_battle_w/2, table_battle_y, table_battle_x+table_battle_w/2, table_battle_y+table_battle_h)
  --画几个横线
  for i = 1, players_per_group-1 do
    love.graphics.line(table_battle_x, (table_battle_y+table_battle_item_h*2)+i*table_battle_item_h, table_battle_x+table_battle_w, (table_battle_y+table_battle_item_h*2)+i*table_battle_item_h)
  end
  --画几个竖线
  love.graphics.line(table_battle_x+table_battle_item_w*2, table_battle_y+table_battle_item_h, table_battle_x+table_battle_item_w*2, table_battle_y+table_battle_item_h*table_battle_rows)
  love.graphics.line(table_battle_x+table_battle_item_w*3, table_battle_y+table_battle_item_h, table_battle_x+table_battle_item_w*3, table_battle_y+table_battle_item_h*table_battle_rows)
  love.graphics.line(table_battle_x+table_battle_item_w*6, table_battle_y+table_battle_item_h, table_battle_x+table_battle_item_w*6, table_battle_y+table_battle_item_h*table_battle_rows)
  love.graphics.line(table_battle_x+table_battle_item_w*7, table_battle_y+table_battle_item_h, table_battle_x+table_battle_item_w*7, table_battle_y+table_battle_item_h*table_battle_rows)
  
  --红队
  love.graphics.setColor(255,20,0,230)
  love.graphics.rectangle("fill", table_battle_x, table_battle_y, table_battle_w/2, table_battle_item_h)
  love.graphics.setColor(255,60,0,230)
  love.graphics.rectangle("fill", table_battle_x, table_battle_y+table_battle_item_h, table_battle_w/2, table_battle_item_h)
  love.graphics.setColor(150,150,150,230)
  love.graphics.rectangle("fill", table_battle_x, table_battle_y+2*table_battle_item_h, table_battle_w/2, table_battle_item_h*players_per_group)
  
  --蓝队
  love.graphics.setColor(0,100,255,230)
  love.graphics.rectangle("fill", table_battle_x+table_battle_w/2, table_battle_y, table_battle_w/2, table_battle_item_h)
  love.graphics.setColor(0,150,255,230)
  love.graphics.rectangle("fill", table_battle_x+table_battle_w/2, table_battle_y+table_battle_item_h, table_battle_w/2, table_battle_item_h)
  love.graphics.setColor(150,150,150,230)
  love.graphics.rectangle("fill", table_battle_x+table_battle_w/2, table_battle_y+2*table_battle_item_h, table_battle_w/2, table_battle_item_h*players_per_group)

  love.graphics.setColor(r,g,b,a)
  
  gooi.draw(group_gameover)
  camera:detach()
end

function gameover:keypressed(key, scancode)
  if key == "space" then
    local roomlist = require "boom.scenes.roomlist"
    local init_table = {}
    --init_table
    init_table["myId"] = myId
    game_state.switch(roomlist, init_table)
  end
end

return gameover