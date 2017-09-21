local EM = require "boom.entities"
local ExplosiveSync = class("ExplosiveSync", System)

function ExplosiveSync:update(dt)
    for index, entity in pairs(self.targets) do
        if not entity:get("Explosive").is_exploded then
            local body = entity:get("Explosive").body
            local x1, y1 = body:getWorldCenter()
            local radius = entity:get("Explosive").range_radius
            local in_range_entity = entity:get("Explosive").in_range_entity
            for i=0, #in_range_entity do in_range_entity[i]=nil end
            for _, e in pairs(engine:getEntitiesWithComponent("Health")) do
                local target_body = e:get("Physic") and e:get("Physic").body or nil
                if target_body then
                    local x2, y2 = target_body:getWorldCenter()
                    if math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2)) < radius then
                        in_range_entity[#in_range_entity+1] = e
                    end
                end
            end
        else
            entity:get("Explosive").explosion_ps:update(dt)
            if entity:get("Explosive").explosion_ps:isStopped() then
                local gid = entity:get("GlobalEntityId").id
                local body = entity:get("Physic").body
                body:setUserData(nil)
                body:destroy()
                EM:removeEntityFromList(gid)
                engine:removeEntity(entity)
            end
        end
    end
end

function ExplosiveSync:requires()
    return {"Explosive"}
end

return ExplosiveSync
