local EM = require "boom.entities"
local ExplosiveSync = class("ExplosiveSync", System)
local events = require("boom.events")

function ExplosiveSync:update(dt)
    for index, entity in pairs(self.targets) do
        local exp = entity:get("Explosive")
        local body = entity:get("Physic").body
        exp.x, exp.y = body:getWorldCenter()
        if not exp.is_exploded then
            local x1, y1 = body:getWorldCenter()
            local radius = exp.range_radius
            if radius > 0 then
                local in_range_entity = exp.in_range_entity
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
            end
        else
            local exp = entity:get("Explosive")
            exp.explosion_ps:update(dt)
            if exp.explosion_ps:isStopped() then
                eventmanager:fireEvent(events.EntityDestroy(entity))
            end
        end
    end
end

function ExplosiveSync:requires()
    return {"Explosive", "Physic"}
end

return ExplosiveSync
