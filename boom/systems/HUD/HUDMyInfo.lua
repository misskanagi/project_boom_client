--显示玩家自己的信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"
local group_hudmyinfo = 101
local HUDMyInfo = class("HUDMyInfo", System)
local img = love.graphics.newImage("/assets/backup/sign_bullet.png")
local img_heart = love.graphics.newImage("/assets/heart.png")
local img_blank = love.graphics.newImage("/assets/backup/blank_32.png")
local pb_hp = nil  --血条
local lbl_shell = nil --导弹仓

function HUDMyInfo:draw()
  --print("HUDMyInfo draw()")
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
    --创建血条
    pb_hp = gooi.newBar({x = 10, y = 10, w = 320, h = 10, value = 1, group = group_hudmyinfo})
    :bg({255, 255, 255, 60})
    :fg({0, 255, 0, 150})
    
    lbl_shell = gooi.newLabel({x = 10, y = 100, text = "", group = group_hudmyinfo}):left()
    self.is_init = true
  end
  
  --常规draw
  local cvs = love.graphics.getCanvas()
  love.graphics.setCanvas(HUD_canvas:getCanvas())
  love.graphics.push()
  love.graphics.origin()
  for k, entity in pairs(self.targets) do
    local max_hp = entity:get("Health").max_value
    local hp = entity:get("Health").value
    --计算hp/max_hp
    pb_hp.value = hp/max_hp
    --绘制炮弹种类以及余量信息
    local launchable = entity:get("Launchable")
    local launchable_num = launchable.shell_count
    local launchable_name = launchable.shell_name
    lbl_shell:setIcon(img):setText(launchable_name.." : "..launchable_num)
  end
  gooi.draw(group_hudmyinfo)
  love.graphics.pop()
  love.graphics.setCanvas(cvs)
end

function HUDMyInfo:update_widgets()
  
end


function HUDMyInfo:requires()
  return {"IsMyself", "Health", "Launchable"}
end

return HUDMyInfo