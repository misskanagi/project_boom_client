local camera = require "boom.camera"
local Vector = require "libs.hump.vector"
local GamepadHandler = class("GamepadHandler", System)
local events = require("boom.events")

local leftstick_moved = false  --左摇杆上一刻是移动中的状态
local r2_used = false --r2键之前被按下过
local l2_used = false --l2键之前被按下过
local rightstick_timer = 0
local fire_interval = 0.02   --采集鼠标当前位置的时间间隔
local v = Vector(0, 0)
local nv = Vector(1, 0) 

-- locally pressed
function GamepadHandler:firePressedEvent(event)
    --玩家无关操作
    if event.button == "start" then  --PS4的options键
        local system_manager = require "boom.systems"
        system_manager.toggleModule("debug")
        --debug.debug()
    elseif event.button == "back" then  --PS4的share键
      engine:toggleSystem("HUDBattle")
    end
    for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local dcmd = entity:get("Drivable") and entity:get("Drivable").cmd or nil
        local fcmd = entity:get("Firable") and entity:get("Firable").cmd or nil
        local lcmd = entity:get("Launchable") and entity:get("Launchable").cmd or nil
        if event.button == "moveforward" and dcmd then  --同马车一致
            dcmd.forward=true
        elseif event.button == "movebackward" and dcmd then
            dcmd.backward=true
        elseif event.button == "turnleft" and dcmd then
            dcmd.turn_left=true
        elseif event.button == "turnright" and dcmd then
            dcmd.turn_right=true
        elseif event.button == "x" and dcmd then
            dcmd.toggle_light = not dcmd.toggle_light
        --elseif event.button == "left" and dcmd then
           -- dcmd.turret_spin_neg = true
        --elseif event.button == "right" and dcmd then
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
        if event.button == "moveforward" and dcmd then
            dcmd.forward=false
        elseif event.button == "movebackward" and dcmd then
            dcmd.backward=false
        elseif event.button == "turn" and dcmd then
            dcmd.turn_left=false
            dcmd.turn_right=false
        --elseif event.button == "left" and dcmd then
          --  dcmd.turret_spin_neg = false
        --elseif event.button == "right" and dcmd then
            --dcmd.turret_spin_pos = false
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

--专门处理右摇杆的移动
function GamepadHandler:fireRightStickMovedEvent(event)
  
end


--判断Gamepad的axis值
function GamepadHandler:update(dt)
  local joystick = (love.joystick.getJoysticks())[1]
  if joystick then
    local leftx, lefty, rightx, l2, r2, righty = joystick:getAxes()
    --处理左摇杆
    if leftx <= -0.5 then --左摇杆向左移动了
      leftstick_moved = true
      GamepadHandler:firePressedEvent(events.GamepadPressed("turnleft"))
    elseif leftx >= 0.5 then
      leftstick_moved = true
      GamepadHandler:firePressedEvent(events.GamepadPressed("turnright"))
    else
      if leftstick_moved then
        leftstick_moved = false
        GamepadHandler:fireReleasedEvent(events.GamepadReleased("turn"))
      end
    end
    
    --处理右摇杆
    rightstick_timer = rightstick_timer + dt
    if rightstick_timer > fire_interval then
      rightstick_timer = 0
      --获取当前鼠标的参数
      --local mx, my = camera:mousePosition()
      local x = 1
      local y = 1
      eventmanager:fireEvent(events.GamepadRightStickMoved(x, y))
    end
    
    --处理l2
    if l2 <= -0.5 then
      if l2_used then
        l2_used = false
        GamepadHandler:fireReleasedEvent(events.GamepadReleased("movebackward"))
      end
    elseif l2 >= 0.5 then
      l2_used = true
      GamepadHandler:firePressedEvent(events.GamepadPressed("movebackward"))
    end
    
    
    --处理r2, 松手-1，按下1
    --必须松了手以后在按才能开火
    if r2 <= -0.5 then
      if r2_used then
        r2_used = false
        GamepadHandler:fireReleasedEvent(events.GamepadReleased("moveforward"))
      end
    elseif r2 >= 0.5 then
      r2_used = true
      GamepadHandler:firePressedEvent(events.GamepadPressed("moveforward"))
    end
  end
end

return GamepadHandler
