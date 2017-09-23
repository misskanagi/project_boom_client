--显示玩家自己的信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"
local group_hudmyinfo = 101
local HUDMyInfo = class("HUDMyInfo", System)
local img = love.graphics.newImage("/assets/backup/sign_bullet.png")
local img_heart = love.graphics.newImage("/assets/heart.png")
local pb_hp = nil  --血条
local lbl_shell = nil --导弹仓
local lbl_life = nil --生命数
local grid_life = nil

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
    --创建全队生命示意图
    grid_life = gooi.newPanel({x = 10, y = 30, w = 320, h = 32, layout = "grid 1x10", group = group_hudmyinfo})
    for i = 1, 10 do
      local lbl_item = gooi.newLabel({text = "", group = group_hudmyinfo}):setIcon(img_heart)
      grid_life:add(lbl_item, "1,"..i)
    end
    
    
    lbl_shell = gooi.newLabel({x = 10, y = 70, text = "", group = group_hudmyinfo}):left()
    
    self.is_init = true
  end
  local cvs = love.graphics.getCanvas()
  love.graphics.setCanvas(HUD_canvas:getCanvas())
  love.graphics.push()
  love.graphics.origin()
  for k, entity in pairs(self.targets) do
    local max_hp = entity:get("Health").max_value
    local hp = entity:get("Health").value
    --计算hp/max_hp
    pb_hp.value = hp/max_hp
    
    local launchable = entity:get("Launchable")
    --local launchable_img = launchable.
    --local launchable_count = launchable.count
    
    lbl_shell:setIcon(img):setText("X 10")
    
  end
  gooi.draw(group_hudmyinfo)
  --love.graphics.setColor(255,255,255,255)
  --love.graphics.rectangle("fill", 0, 0, 200, 200)
  love.graphics.pop()
  love.graphics.setCanvas(cvs)
end


function HUDMyInfo:requires()
  return {"IsMyself", "Health", "Launchable"}
end

return HUDMyInfo