--处理鼠标事件
local camera = require "boom.camera"
local Vector = require "libs.hump.vector"
local events = require "boom.events"
local MouseHandler = class("MouseHandler", System)
local timer = 0
local fire_interval = 0.100   --采集鼠标当前位置的时间间隔
local v = Vector(0, 0)
local nv = Vector(1, 0)

--处理鼠标移动的事件
function MouseHandler:fireMovedEvent(event)
  --此处处理监听到的鼠标移动事件
  local mx = event.x
  local my = event.y
  --print(mx, my)
  for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
    local turret = entity:get("Turret") or nil
    if turret then
      --本地施加炮台旋转
      local body = turret.body
      local tx, ty = body:getLocalPoint(mx, my)
      --print(tx, ty)
      v.x, v.y = tx, ty
      v:rotateInplace(math.pi/2)
      --print(v:angleTo(nv))
      body:applyAngularImpulse(0.3 * body:getInertia() * v:angleTo(nv))
      --发给Server
      event.tx = tx
      event.ty = ty
      --turret.sight_x = mx
      --turret.sight_y = my
      MouseHandler:fireMovedEventToNetwork(event)
    end
  end
end

-- let others know pressed
function MouseHandler:fireMovedEventToNetwork(event)
    for _, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
      local name = e:get("PlayerName").name
      if net then
        --net:sendKey(name, true, event.isrepeat, event.key)
        net:sendMouse(name, event.tx, event.ty)
      end
      break
    end
end

function MouseHandler:update(dt)
  --print("MouseHandler:update(dt)")
  --获取当前鼠标的参数
  local mx, my = camera:mousePosition()
  for index, entity in pairs(engine:getEntitiesWithComponent("IsMyself")) do
    local turret = entity:get("Turret") or nil
    if turret then
      turret.sight_x = mx
      turret.sight_y = my
      break
    end
  end
  timer = timer + dt
  if timer > fire_interval then
    timer = 0
    --if (love.joystick.getJoysticks()) == nil then
    eventmanager:fireEvent(events.MouseMoved(mx, my))
    --end
  end
end

return MouseHandler
