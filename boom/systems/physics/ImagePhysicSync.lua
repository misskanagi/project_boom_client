local ImagePhysicSync = class("ImagePhysicSync", System)

function ImagePhysicSync:update(dt)
    for index, entity in pairs(self.targets) do
        local DI = entity:get("DrawableImage")
        local body = entity:get("Physic").body
        local w, h = DI.image:getWidth(), DI.image:getHeight()
        local cx, cy = body:getWorldPoint(-w/2, h/2)
        DI.x, DI.y, DI.r = cx, cy, body:getAngle()-math.pi/2
    end
end

function ImagePhysicSync:requires()
    return {"DrawableImage", "Physic"}
end

return ImagePhysicSync
