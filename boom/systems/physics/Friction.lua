-- Synchronizes the Position Component with the Position of the Body Component, if an Entity has both.
local Friction = class("Friction", System)

function Friction:update(dt)
    -- Syncs the Position with the Physic. Physic is the primary component.
    for k, entity in pairs(self.targets) do
        local p = entity:get("Physic")
        local m = p.maxLateralImpulse
        local a = p.angularFrictionConstant
        local r = p.rollFrictionConstant
        self:updateFriction(entity:get("Physic").body, m, a, r)
        for _, b in pairs(entity:get("Physic").other_bodies) do
            self:updateFrictionForAngular(b, r)
            --self:updateFriction(b)
        end
    end
end

function Friction:getLateralVelocity(body)
    local nx, ny = body:getWorldVector(1, 0)
    local sx, sy = body:getLinearVelocity()
    return (nx*sx+ny*sy)*nx, (nx*sx+ny*sy)*ny
end

function Friction:getForwardVelocity(body)
    local nx, ny = body:getWorldVector(0, 1)
    local sx, sy = body:getLinearVelocity()
    return (nx*sx+ny*sy)*nx, (nx*sx+ny*sy)*ny
end

function Friction:updateFriction(body, maxLateralImpulse, angularFrictionConstant, rollFrictionConstant)
    -- vanish lateral speed
    local lx, ly = self:getLateralVelocity(body)
    local ix, iy = body:getMass() * -lx, body:getMass() * -ly
    local cx, cy = body:getWorldCenter()
    local impulseLength = math.sqrt(ix*ix+iy*iy)
    if impulseLength > maxLateralImpulse then
      local h = maxLateralImpulse / impulseLength
      ix, iy = ix * h, iy * h
    end
    body:applyLinearImpulse(ix, iy, cx, cy)
    -- vanish angular speed
    body:applyAngularImpulse(angularFrictionConstant * body:getInertia() * -body:getAngularVelocity())
    -- vanish roll speed
    local nx, ny = self:getForwardVelocity(body)
    local forwardSpeed = math.sqrt(nx*nx+ny*ny)
    local dragForceMagnitude = -rollFrictionConstant * forwardSpeed
    body:applyForce(dragForceMagnitude * nx, dragForceMagnitude * ny, cx, cy)
end

function Friction:updateFrictionForAngular(body, angularFrictionConstant)
    -- vanish angular speed
    body:applyAngularImpulse(angularFrictionConstant * body:getInertia() * -body:getAngularVelocity())
end

function Friction:requires()
    return {"Physic"}
end

return Friction
