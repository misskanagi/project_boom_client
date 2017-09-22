local camera = require "boom.camera"
local GamepadHandler = class("GamepadHandler", System)

-- locally pressed
function GamepadHandler:firePressedEvent(event)
    --玩家无关操作
    if event.button == "start" then  --PS4的share键
        local system_manager = require "boom.systems"
        system_manager.toggleModule("debug")
        --debug.debug()
    end
    for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
        local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
        local lcmd = entity:get("Launchable") and entity:get("Launchable").cmd or nil
        if event.button == "b" and dcmd then  --同马车一致
            dcmd.forward=true
        elseif event.button == "a" and dcmd then
            dcmd.backward=true
        elseif event.button == "dpleft" and dcmd then
            dcmd.turn_left=true
        elseif event.button == "dpright" and dcmd then
            dcmd.turn_right=true
        elseif event.button == "x" and dcmd then
            dcmd.toggle_light = not dcmd.toggle_light
        --elseif event.button == "left" and dcmd then
           -- dcmd.turret_spin_neg = true
       -- elseif event.button == "right" and dcmd then
            --dcmd.turret_spin_pos = true
        elseif event.button == "rightshoulder" and fcmd then
            fcmd.fire = true
            camera:instance():shake(5)
        elseif event.button == "leftshoulder" and lcmd then
            lcmd.launch = true
            camera:instance():shake(20, true)
        end
        break
    end
    self:firePressedEventToNetwork(event)
end

-- let others know pressed
function GamepadHandler:firePressedEventToNetwork(event)
    for _, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
      local name = e:get("PlayerName").name
      if net then
        --net:sendKey(name, true, event.isrepeat, event.key)
        --network:sendButton(playerId, pressedOrReleased, button)
        net:sendButton(name, true, event.button)
      end
      break
    end
end

function GamepadHandler:fireReleasedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
        local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
        if event.button == "b" and dcmd then
            dcmd.forward=false
        elseif event.button == "a" and dcmd then
            dcmd.backward=false
        elseif event.button == "dpleft" and dcmd then
            dcmd.turn_left=false
        elseif event.button == "dpright" and dcmd then
            dcmd.turn_right=false
        elseif event.button == "left" and dcmd then
            dcmd.turret_spin_neg = false
        elseif event.button == "right" and dcmd then
            dcmd.turret_spin_pos = false
        elseif event.button == "rightshoulder" and fcmd then
            fcmd.fire = false
            camera:instance():dontPanic()
        end
        break
    end
    self:fireReleasedEventToNetwork(event)
end

function GamepadHandler:fireReleasedEventToNetwork(event)
    for _, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
      local name = e:get("PlayerName").name
      -- 松开健位，没有repeat
      if net then  --调试方便
        --net:sendKey(name, false, false, event.key)
        --network:sendButton(playerId, pressedOrReleased, button)
        net:sendButton(name, false, event.button)
      end
      break
    end
end

return GamepadHandler
