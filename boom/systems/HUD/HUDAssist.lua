--显示玩家自己的信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"
local group_hudassist = 102
local HUDAssist = class("HUDAssist", System)
local img_sight = love.graphics.newImage("/assets/sight.png")

function HUDAssist:draw()
  --print("HUDMyInfo draw()")
  if not self.is_init then
    
    self.is_init = true
  end
  local cvs = love.graphics.getCanvas()
  love.graphics.setCanvas(HUD_canvas:getCanvas())
  --love.graphics.push()
  --love.graphics.origin()
  for k, entity in pairs(self.targets) do
    --love.graphics.print("hahahah")
    local turret = entity:get("Turret") or nil
    if turret then
      local body = turret.body
      local cx, cy = body:getWorldCenter()
      local sight_x = turret.gp_x * 200 + cx
      local sight_y = turret.gp_y * 200 + cy
      love.graphics.draw(img_sight, sight_x-16, sight_y-16)
    end
  end
  gooi.draw(group_hudassist)
 -- love.graphics.pop()
  love.graphics.setCanvas(cvs)
end


function HUDAssist:requires()
  return {"IsMyself"}
end

return HUDAssist