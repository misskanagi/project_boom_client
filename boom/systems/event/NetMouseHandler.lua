--处理网络传输过来的NetMouseMoved事件
local Vector = require "libs.hump.vector"
local NetMouseHandler = class("NetMouseHandler", System)
local v = Vector(0, 0)
local nv = Vector(1, 0)

function NetMouseHandler:fireNetMouseMovedEvent(event)
    for index, entity in pairs(engine:getEntitiesWithComponent("PlayerName")) do
      if entity:get("PlayerName").name == event.name then
        local turret = entity:get("Turret") or nil
        local tx = event.tx
        local ty = event.ty
        --将tx，ty参数作用在turret上
        if turret then
          --给属主施加炮台旋转
          local body = turret.body
          --local tx, ty = body:getLocalPoint(mx, my)
          --print(tx, ty)
          v.x, v.y = tx, ty
          v:rotateInplace(math.pi/2)
          --print(v:angleTo(nv))
          body:applyAngularImpulse(0.1 * body:getInertia() * v:angleTo(nv))
        end
      end
    end
end

return NetMouseHandler
