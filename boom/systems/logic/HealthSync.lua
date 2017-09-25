local HealthSync = class("HealthSync", System)
local events = require("boom.events")

function HealthSync:update(dt)
    for index, entity in pairs(self.targets) do
        if entity:get("Health").value <= 0 then
            entity:get("Health").death = entity:get("Health").death + 1
            if entity:has("Explosive") then
                if not entity:get("Explosive").is_exploded then
                    entity:get("Explosive").is_exploded = true
                    entity:get("Explosive").explosion_ps:start()
                end
            else
                eventmanager:fireEvent(events.EntityDestroy(entity))
            end
        end
    end
end

function HealthSync:requires()
    return {"Health"}
end

return HealthSync
