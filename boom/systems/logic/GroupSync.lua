local GroupSync = class("GroupSync", System)
local events = require("boom.events")

function GroupSync:update(dt)
    for index, entity in pairs(self.targets) do
        local g = entity:get("Group")
        if g.lives <= 0 then
            eventmanager:fireEvent(events.GameOver())
        end
    end
end

function GroupSync:requires()
    return {"Group"}
end

return GroupSync
