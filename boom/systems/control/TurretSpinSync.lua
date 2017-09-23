local camera = require "boom.camera"
local Vector = require "libs.hump.vector"
local TurretSpinSync = class("TurretSpinSync", System)

local v = Vector(0, 0)
local nv = Vector(1, 0)

function TurretSpinSync:update(dt)
    --[[for k, entity in pairs(self.targets) do
      local turret = entity:get("Turret")
      local body = turret.body
      local mx, my = camera:mousePosition()
      local tx, ty = body:getLocalPoint(mx, my)
      v.x, v.y = tx, ty
      v:rotateInplace(math.pi/2)
      --print(v:angleTo(nv))
      body:applyAngularImpulse(0.1 * body:getInertia() * v:angleTo(nv))
    end]]--
end

function TurretSpinSync:requires()
    return {"Turret", "IsMyself"}
end

return TurretSpinSync
