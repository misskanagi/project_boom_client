local KeyboardHandler = class("KeyboardHandler", System)

-- locally pressed
function KeyboardHandler:firePressedEvent(event)
    --玩家无关操作
    if event.key == "f2" then
        local system_manager = require "boom.systems"
        system_manager.toggleModule("debug")
        --debug.debug()
    end
    for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
        if entity:get("IsMyself") then
            local cmd = entity:get("Controllable").cmd
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
            break
        end
    end
    self:firePressedEventToNetwork(event)
end

-- let others know pressed
function KeyboardHandler:firePressedEventToNetwork(event)
    for _, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
      local name = e:get("PlayerName").name
      net:sendKey(name, true, event.isrepeat, event.key)
      break
    end
end

function KeyboardHandler:fireReleasedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
        if entity:get("IsMyself") then
            local cmd = entity:get("Controllable").cmd
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
    self:fireReleasedEventToNetwork(event)
end

function KeyboardHandler:fireReleasedEventToNetwork(event)
    for _, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
      local name = e:get("PlayerName").name
      -- 松开健位，没有repeat
      net:sendKey(name, false, false, event.key)
      break
    end
end

return KeyboardHandler
