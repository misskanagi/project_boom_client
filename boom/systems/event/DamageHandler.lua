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
    --print("true damage: ", true_dmg)
    if dst:has("Health") then
        local max_value = dst:get("Health").max_value
        dst:get("Health").value = dst:get("Health").value - true_dmg
        dst:get("Health").src_dmg_entity = src
        if dst:get("Health").value < 0 then
            dst:get("Health").value = 0
        end
        if dst:get("Health").value > max_value then
            dst:get("Health").value = max_value
        end
    end
    -- give push force
    if true_dmg > 0 then -- 如果伤害为负数，说明是治疗，不用去推这个entity
        if src:has("Physic") and dst:has("Physic") then
            local x1, y1 = src:get("Physic").body:getWorldCenter()
            local x2, y2 = dst:get("Physic").body:getWorldCenter()
            v.x, v.y = x2-x1, y2-y1
            v:normalizeInplace()
            local force = true_dmg*50
            dst:get("Physic").body:applyForce(force * v.x, force * v.y, x2, y2)
        end
    end
end

return DamageHandler
