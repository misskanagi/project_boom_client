local events = require "boom.events"
local WreckageSync = class("WreckageSync", System)

function WreckageSync:update(dt)
    for index, entity in pairs(self.targets) do
        local wreckage = entity:get("Wreckage")
        wreckage.wreckage_ps:update(dt)
        if wreckage.wreckage_ps:isStopped() then
            eventmanager:fireEvent(events.EntityDestroy(entity))
        end
    end
end

function WreckageSync:requires()
    return {"Wreckage"}
end

return WreckageSync
