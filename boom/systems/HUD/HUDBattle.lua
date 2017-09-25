--显示对战信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"
local group_hudbattle = 100
local HUDBattle = class("HUDBattle", System)
--local img = love.graphics.newImage("/assets/sign_bullet.png")

local table_battle = nil --对战信息表
local lbl_title_group_red = nil
local lbl_title_group_blue = nil
local lbl_title_id_red = nil
local lbl_title_id_blue = nil
local lbl_title_kill_red = nil
local lbl_title_kill_blue = nil
local lbl_title_dead_red = nil
local lbl_title_dead_blue = nil
local table_battle_x = 0
local table_battle_y = 0
local table_battle_w = 0
local table_battle_h = 0
local table_battle_item_w = 80
local table_battle_item_h = 60
local table_battle_rows = 0
local table_battle_cols = 0
local players_per_group = nil --每一个队里有几个人

function HUDBattle:draw()
  if not self.is_init then
    local font_small = love.graphics.newFont("assets/font/Arimo-Bold.ttf", 14)
    local style = {
      font = font_small,
      radius = 5,
      innerRadius = 3,
      showBorder = true,
    }
    gooi.setStyle(style)
    gooi.desktopMode()
    gooi.shadow()
    --一波数值先计算出来
    
    --先获取每队玩家个数
    for _, entity in pairs(self.targets) do
      local group_component = entity:get("Group")
      local group_players_per_group = #group_component.players_info
      if not players_per_group then
        players_per_group = group_players_per_group
      elseif players_per_group < group_players_per_group then
        players_per_group = group_players_per_group
      end
    end

    --players_per_group = #self.targets / 2
    table_battle_rows = players_per_group+2
    local window_w = love.graphics.getWidth()
    local window_h = love.graphics.getHeight()
    table_battle_w = table_battle_item_w * 8
    table_battle_h = table_battle_item_h * table_battle_rows
    table_battle_x = (window_w - table_battle_w) / 2
    table_battle_y = (window_h - table_battle_h) / 2
    
    table_battle = gooi.newPanel({x = table_battle_x, y = table_battle_y , w = table_battle_w, h = table_battle_h, layout = "grid "..table_battle_rows.."x8", group = group_hudbattle})
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
    lbl_title_group_red = gooi.newLabel({text = "Group1", group = group_hudbattle}):center()
    lbl_title_group_blue = gooi.newLabel({text = "Group2", group = group_hudbattle}):center()
    lbl_title_id_red = gooi.newLabel({text = "ID", group = group_hudbattle}):center()
    lbl_title_id_blue = gooi.newLabel({text = "ID", group = group_hudbattle}):center()
    lbl_title_kill_red = gooi.newLabel({text = "kill", group = group_hudbattle}):center()
    lbl_title_kill_blue = gooi.newLabel({text = "kill", group = group_hudbattle}):center()
    lbl_title_dead_red = gooi.newLabel({text = "dead", group = group_hudbattle}):center()
    lbl_title_dead_blue = gooi.newLabel({text = "dead", group = group_hudbattle}):center()
    lbl_ids_red = {} --key是行号
    lbl_kills_red = {} --key是行号
    lbl_deads_red = {}
    lbl_ids_blue = {}
    lbl_kills_blue = {}
    lbl_deads_blue = {}
    --创建出红队的每个选手的每一个控件
    for i = 1, players_per_group do 
      lbl_kills_red[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      lbl_ids_red[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      lbl_kills_red[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      lbl_deads_red[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      lbl_ids_blue[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      lbl_kills_blue[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      lbl_deads_blue[i] = gooi.newLabel({text = "", group = group_hudbattle}):center()
      table_battle:add(lbl_ids_red[i], (i+2)..",1")
      table_battle:add(lbl_kills_red[i], (i+2)..",3")
      table_battle:add(lbl_deads_red[i], (i+2)..",4")
      table_battle:add(lbl_ids_blue[i], (i+2)..",5")
      table_battle:add(lbl_kills_blue[i], (i+2)..",7")
      table_battle:add(lbl_deads_blue[i], (i+2)..",8")
    end
    
    table_battle:add(lbl_title_group_red, "1,1")
    table_battle:add(lbl_title_group_blue, "1,5")
    table_battle:add(lbl_title_id_red, "2,1")
    table_battle:add(lbl_title_kill_red, "2,3")
    table_battle:add(lbl_title_dead_red, "2,4")
    table_battle:add(lbl_title_id_blue, "2,5")
    table_battle:add(lbl_title_kill_blue, "2,7")
    table_battle:add(lbl_title_dead_blue, "2,8")
    self.is_init = true
  end
  --绘制部分
  local cvs = love.graphics.getCanvas()
  love.graphics.setCanvas(HUD_canvas:getCanvas())
  love.graphics.push()
  love.graphics.origin()
  
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
  
  
  
  --绘制具体的内容
  for _, entity in pairs(self.targets) do
    local group_component = entity:get("Group")
    local group_id = group_component.id
    local group_players_info = group_component.players_info
    if group_id == 1 then
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
  
  gooi.draw(group_hudbattle)
  --love.graphics.setColor(255,255,255,255)
  --love.graphics.rectangle("fill", 0, 0, 200, 200)
  love.graphics.pop()
  love.graphics.setCanvas(cvs)
end


function HUDBattle:requires()
  return {"Group"}
end

return HUDBattle