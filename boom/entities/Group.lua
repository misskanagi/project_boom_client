local Group = require "boom.components.logic.Group"

-- group entity
local createGroup = function(id, lives, players_info)
    local e = Entity()
    e:add(Group(id, lives or 50, players_info))
    return e
end

return createGroup
