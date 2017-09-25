--绘制组相关的东西
--显示玩家自己的信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"
local group_hudgroup = 103
local HUDGroup = class("HUDGroup", System)
local img_heart = love.graphics.newImage("/assets/heart.png")
local img_heart_blue = love.graphics.newImage("/assets/heart_blue.png")
local img_blank = love.graphics.newImage("/assets/backup/blank_32.png")
local lbl_lives_red = nil
local lbl_lives_blue = nil
local group_life_count = 10

function HUDGroup:draw()
  if not self.is_init then
    --获取全队生命总数
    for k, entity in pairs(self.targets) do
      local group_component = entity:get("Group")
      group_life_count = group_component.lives
      print("group_life_count:"..group_life_count)
      break
    end
    
    --创建红队生命示意图
    lbl_lives_red = gooi.newLabel({x = 10, y = 30, group = group_hudgroup, text = ""}):left()
    --创建蓝队生命示意图
    lbl_lives_blue = gooi.newLabel({x = 10, y = 70, group = group_hudgroup, text = ""}):left()
    self.is_init = true
  end
  
  --常规draw
  local cvs = love.graphics.getCanvas()
  love.graphics.setCanvas(HUD_canvas:getCanvas())
  love.graphics.push()
  love.graphics.origin()
  for k, entity in pairs(self.targets) do
    local group_component = entity:get("Group")
    --绘制全队的生命爱心
    local group_lives = group_component.lives
    local group_id = group_component.id
    
    if group_id == 1 then  --红队
      lbl_lives_red:setIcon(img_heart):setText(" x "..group_lives)
    else  --蓝队
      lbl_lives_blue:setIcon(img_heart_blue):setText(" x "..group_lives)
    end
    
    
  end
  gooi.draw(group_hudgroup)
  love.graphics.pop()
  love.graphics.setCanvas(cvs)
end

function HUDGroup:requires()
  return {"Group"}
end

return HUDGroup