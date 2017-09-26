local EM = require "boom.entities"
local ExplosiveSync = class("ExplosiveSync", System)
local events = require("boom.events")
local camera = require("boom.camera")

function ExplosiveSync:update(dt)

end

function ExplosiveSync:update(dt)
    for index, entity in pairs(self.targets) do
        local exp = entity:get("Explosive")
        local body = entity:get("Physic").body
        exp.x, exp.y = body:getWorldCenter()
        local x1, y1 = body:getWorldCenter()
        local radius = exp.range_radius
        if radius > 0 then
            local in_range_entity = exp.in_range_entity
            for i=0, #in_range_entity do in_range_entity[i]=nil end
            for _, e in pairs(engine:getEntitiesWithComponent("Health")) do
                if e ~= entity then
                    local target_body = e:get("Physic") and e:get("Physic").body or nil
                    if target_body then
                        local x2, y2 = target_body:getWorldCenter()
                        if math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2)) < radius then
                            in_range_entity[#in_range_entity+1] = e
                        end
                    end
                end
            end
        end
        if exp.is_exploded then
            local exp = entity:get("Explosive")
            exp.explosion_ps:update(dt)
            if not exp.exploded_callback_executed then
                --explode
                local cx, cy = camera:position()
                local meter = love.physics.getMeter()*audio_distance_scale
                local dist = math.sqrt(math.pow(x1-cx, 2) + math.pow(y1-cy, 2))
                --print(dist, 50 * love.physics.getMeter())
                exp.exploded_sound:setPosition( (cx - x1)/meter, (cy - y1)/meter, 0 )
                --exp.exploded_sound:setAttenuationDistances( dist, 50 * love.physics.getMeter() )
                exp.exploded_sound:play()
                exp.exploded_callback(entity)
                exp.exploded_callback_executed = true
            end
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
