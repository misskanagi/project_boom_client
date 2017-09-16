local NetKeyboardHandler = class("NetKeyboardHandler", System)

function NetKeyboardHandler:fireNetPressedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
        local cmd = entity:get("Controllable").cmd
        local name = entity:get("PlayerName").name
        if name == event.name then
            if event.key == "w" then
                cmd.forward=true
            elseif event.key == "s" then
                cmd.backward=true
            elseif event.key == "a" then
                cmd.turn_left=true
            elseif event.key == "d" then
                cmd.turn_right=true
            elseif event.key == "left" then
                cmd.turret_spin_neg = true
            elseif event.key == "right" then
                cmd.turret_spin_pos = true
            end
        end
    end
end

function NetKeyboardHandler:fireNetReleasedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
        local cmd = entity:get("Controllable").cmd
        local name = entity:get("PlayerName").name
        if name == event.name then
            if event.key == "w" then
                cmd.forward=false
            elseif event.key == "s" then
                cmd.backward=false
            elseif event.key == "a" then
                cmd.turn_left=false
            elseif event.key == "d" then
                cmd.turn_right=false
            elseif event.key == "left" then
                cmd.turret_spin_neg = false
            elseif event.key == "right" then
                cmd.turret_spin_pos = false
            end
            break
        end
    end
end

return NetKeyboardHandler
