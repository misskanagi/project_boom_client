--显示对战信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"

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
local players_per_group = 0 --每一个队里有几个人

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
    for _,__ in pairs(self.targets) do players_per_group = players_per_group+1 end
    --players_per_group = #self.targets / 2
    table_battle_rows = players_per_group+2
    local window_w = love.graphics.getWidth()
    local window_h = love.graphics.getHeight()
    table_battle_w = table_battle_item_w * 8
    table_battle_h = table_battle_item_h * table_battle_rows
    table_battle_x = (window_w - table_battle_w) / 2
    table_battle_y = (window_h - table_battle_h) / 2
    
    table_battle = gooi.newPanel({x = table_battle_x, y = table_battle_y , w = table_battle_w, h = table_battle_h, layout = "grid "..table_battle_rows.."x8"})
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
    lbl_title_group_red = gooi.newLabel({text = "Group1"}):center()
    lbl_title_group_blue = gooi.newLabel({text = "Group2"}):center()
    lbl_title_id_red = gooi.newLabel({text = "ID"}):center()
    lbl_title_id_blue = gooi.newLabel({text = "ID"}):center()
    lbl_title_kill_red = gooi.newLabel({text = "kill"}):center()
    lbl_title_kill_blue = gooi.newLabel({text = "kill"}):center()
    lbl_title_dead_red = gooi.newLabel({text = "dead"}):center()
    lbl_title_dead_blue = gooi.newLabel({text = "dead"}):center()
    lbl_ids_red = {} --key是行号
    lbl_kills_red = {} --key是行号
    lbl_deads_red = {}
    lbl_ids_blue = {}
    lbl_kills_blue = {}
    lbl_deads_blue = {}
    --创建出红队的每个选手的每一个控件
    for i = 1, players_per_group do 
      lbl_kills_red[i] = gooi.newLabel({text = ""}):center()
      lbl_ids_red[i] = gooi.newLabel({text = ""}):center()
      lbl_kills_red[i] = gooi.newLabel({text = ""}):center()
      lbl_deads_red[i] = gooi.newLabel({text = ""}):center()
      lbl_ids_blue[i] = gooi.newLabel({text = ""}):center()
      lbl_kills_blue[i] = gooi.newLabel({text = ""}):center()
      lbl_deads_blue[i] = gooi.newLabel({text = ""}):center()
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
  love.graphics.setColor(255,40,0,230)
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
  local red_i = 1
  local blue_i = 1
  for k, entity in pairs(self.targets) do
      --判断玩家是属于哪一个team的
      
      --获取到每一个玩家的Id/kill/dead数
      local id = "test_id"
      local kill = 1
      local dead = 2
      
  end
  
  gooi.draw()
  --love.graphics.setColor(255,255,255,255)
  --love.graphics.rectangle("fill", 0, 0, 200, 200)
  love.graphics.pop()
  love.graphics.setCanvas(cvs)
end


function HUDBattle:requires()
  return {"IsPlayer"}--, "Health", "Launchable"}
end

return HUDBattle