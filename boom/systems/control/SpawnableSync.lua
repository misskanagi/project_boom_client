local EntityManager = require "boom.entities"
local SpawnableSync = class("SpawnableSync", System)

local Timer = require "libs.hump.timer"

function SpawnableSync:update(dt)
    for k, entity in pairs(self.targets) do
        local sp = entity:get("Spawnable")
        local need_respawn = sp.spawn_condition_callback(dt)
        if need_respawn then
            if not sp.triggered then
                sp.triggered = true
                Timer.after(sp.delay, function()
                    local e = EntityManager:createEntity(
                        sp.entity_list[sp.spawn_callback()],
                        unpack(sp.spawn_params)
                    )
                    if e then
                        engine:addEntity(e)
                        e:setParent(entity)
                    end
                    sp.triggered = false
                end)
            end
        end
    end
end

function SpawnableSync:requires()
    return {"Spawnable"}
end

return SpawnableSync
