local PhysicLerpSync = class("PhysicLerpSync", System)

local function lerp(a, b, k) --smooth transitions
  if a == b then
    return a
  else
    if math.abs(a-b) < 0.05 then return b else return a * (1-k) + b * k end
  end
end


function PhysicLerpSync:update(dt)
    for index, entity in pairs(self.targets) do
        local P = entity:get("Physic")
        if P.lerp then
            for i, l in pairs(P.lerp) do
                local physic_body = P.bodies[i]
                local ox, oy = physic_body:getWorldCenter()
                local oor = physic_body:getAngle()
                local ovx, ovy = physic_body:getLinearVelocity()
                local ova = physic_body:getAngularVelocity()
                local C = 5
                physic_body:setPosition(lerp(ox, l.x, C*dt), lerp(oy, l.y, C*dt))
                physic_body:setAngle(lerp(oor, l.r, C*dt))
                physic_body:setLinearVelocity(lerp(ovx, l.vx, C*dt), lerp(ovy, l.vy, C*dt))
                physic_body:setAngularVelocity(lerp(ova, l.va, C*dt))
            end
        end
    end
end

function PhysicLerpSync:requires()
    return {"Physic", "EntityId"}
end

return PhysicLerpSync
