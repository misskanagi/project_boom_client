local Vector = require "libs.hump.vector"
local DamageHandler = class("DamageHandler", System)

local v = Vector(0, 0)

-- 计算线性递减伤害
function DamageHandler:fireDamage(event)
    local src = event.src_entity
    local dst = event.dst_entity
    local dist = event.dist
    local dmg = event.dmg
    local range = event.range
    local true_dmg = (range*dmg - dmg*dist) / range
    if true_dmg < 0 then true_dmg = 0 end
    if dst:has("Health") then
        dst:get("Health").value = dst:get("Health").value - true_dmg
    end
    -- give push force
    if src:has("Physic") and dst:has("Physic") then
        local x1, y1 = src:get("Physic").body:getWorldCenter()
        local x2, y2 = dst:get("Physic").body:getWorldCenter()
        v.x, v.y = x2-x1, y2-y1
        v:normalizeInplace()
        local force = true_dmg*50
        dst:get("Physic").body:applyForce(force * v.x, force * v.y, x2, y2)
    end
end

return DamageHandler
