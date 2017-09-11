-- Synchronizes the Position Component with the Position of the Body Component, if an Entity has both.
local LightPhysicSync = class("LightPhysicSync", System)

function LightPhysicSync:update(dt)
    -- Syncs the Position with the Physic. Physic is the primary component.
    for k, entity in pairs(self.targets) do
        entity:get("Light").x = entity:get("Physic").body:getX()
        entity:get("Light").y = entity:get("Physic").body:getY()
        entity:get("Light").light:setPosition(
            entity:get("Light").x,
            entity:get("Light").y,
            entity:get("Light").z)
        entity:get("Light").light:setDirection(entity:get("Physic").body:getAngle()-math.pi/2)
    end
end

function LightPhysicSync:requires()
    return {"Physic", "Light"}
end

return LightPhysicSync
