--显示玩家自己的信息
require "/libs/gooi"
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"
local group_hudassist = 102
local HUDAssist = class("HUDAssist", System)
local img_sight = love.graphics.newImage("/assets/sight.png")
local camera = require "boom.camera"
--战车头上的hp条
local mini_hp_width = 60
local mini_hp_height = 7

function HUDAssist:draw()
  --print("HUDMyInfo draw()")
  if not self.is_init then

    self.is_init = true
  end
  local cvs = love.graphics.getCanvas()
  love.graphics.setCanvas(HUD_canvas:getCanvas())
  --love.graphics.push()
  --love.graphics.origin()
  local group_entities = engine:getEntitiesWithComponent("Group")
  for k, entity in pairs(self.targets) do
    --love.graphics.print("hahahah")
    local turret = entity:get("Turret") or nil
    local max_hp = entity:get("Health").max_value
    local hp = entity:get("Health").value
    local group_id = nil
    if turret then
      local body = turret.body
      local cx, cy = body:getWorldCenter()
      --如果是本人玩家，则绘制准星
      if entity:has("IsMyself") then
        local sight_x = turret.sight_x --cx + turret.gp_x
        local sight_y = turret.sight_y --cy + turret.gp_y
        love.graphics.draw(img_sight, sight_x-16, sight_y-16)
      end
      --绘制此君的血条,ugly
      for _, group_entity in pairs(group_entities) do
        local group = group_entity:get("Group")
        local group_players_info = group.players_info
        for _, player_info_item in pairs(group_players_info) do
          if player_info_item.player_id == entity:get("PlayerName").name then
            --找到了此玩家
            group_id = group.id
            break
          end
        end
      end
      --print("!!!!!!group_id = "..group_id)
      local r,g,b,a = love.graphics.getColor()
      if group_id == 1 then   --红队的
        love.graphics.setColor(255,0,0,255)
      elseif group_id == 2 then  --蓝色的
        love.graphics.setColor(0,0,255,255)
      else  --绿色的，有问题
        love.graphics.setColor(0,255,0,255)
      end
      local blood_x = cx - mini_hp_width/2
      local blood_y = cy - 40
      --[[if entity:has("IsMyself") then
        blood_x, blood_y = camera:instance():position()
        blood_x = blood_x - mini_hp_width/2
        blood_y = blood_y - 40
      end]]
      
      love.graphics.rectangle("fill", blood_x, blood_y, mini_hp_width*hp/max_hp, mini_hp_height)
      love.graphics.setColor(255,255,255,255)
      love.graphics.rectangle("line", blood_x, blood_y, mini_hp_width, mini_hp_height)
      love.graphics.setColor(r,g,b,a)
    end
  end
  gooi.draw(group_hudassist)
 -- love.graphics.pop()
  love.graphics.setCanvas(cvs)
end


function HUDAssist:requires()
  return {"IsPlayer"}
end

return HUDAssist
