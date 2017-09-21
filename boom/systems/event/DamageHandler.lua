local DamageHandler = class("DamageHandler", System)

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
end

return DamageHandler
