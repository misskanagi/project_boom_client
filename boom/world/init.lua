local events = require "boom.events"

-- create initial static objects
local createWorld = function()
    love.physics.setMeter(32)
    local world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(
        function(a, b, coll)
            eventmanager:fireEvent(events.BeginContact(a, b, coll))
        end,
        function(a, b, coll)
            eventmanager:fireEvent(events.EndContact(a, b, coll))
        end,
        function(a, b, coll)
            eventmanager:fireEvent(events.PreSolve(a, b, coll))
        end,
        function(a, b, coll, normalimpulse, tangentimpulse)
            eventmanager:fireEvent(events.PostSolve(a, b, coll, normalimpulse, tangentimpulse))
        end
    )
    return world
end

return createWorld
