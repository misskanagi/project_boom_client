local camera = require "boom.camera"
local KeyboardHandler = class("KeyboardHandler", System)

-- locally pressed
function KeyboardHandler:firePressedEvent(event)
    --玩家无关操作
    if event.key == "f2" then
        local system_manager = require "boom.systems"
        system_manager.toggleModule("debug")
        --debug.debug()
    end
    for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
        local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
        if event.key == "w" and dcmd then
            dcmd.forward=true
        elseif event.key == "s" and dcmd then
            dcmd.backward=true
        elseif event.key == "a" and dcmd then
            dcmd.turn_left=true
        elseif event.key == "d" and dcmd then
            dcmd.turn_right=true
        elseif event.key == "l" and dcmd then
            dcmd.toggle_light = not dcmd.toggle_light
        elseif event.key == "left" and dcmd then
            dcmd.turret_spin_neg = true
        elseif event.key == "right" and dcmd then
            dcmd.turret_spin_pos = true
        elseif event.key == "space" and fcmd then
            fcmd.fire = true
            camera:instance():shake(10)
        end
        break
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
    for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
        local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
        if event.key == "w" and dcmd then
            dcmd.forward=false
        elseif event.key == "s" and dcmd then
            dcmd.backward=false
        elseif event.key == "a" and dcmd then
            dcmd.turn_left=false
        elseif event.key == "d" and dcmd then
            dcmd.turn_right=false
        elseif event.key == "left" and dcmd then
            dcmd.turret_spin_neg = false
        elseif event.key == "right" and dcmd then
            dcmd.turret_spin_pos = false
        elseif event.key == "space" and fcmd then
            fcmd.fire = false
            camera:instance():dontPanic()
        end
        break
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
