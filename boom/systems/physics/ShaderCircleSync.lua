local ShaderCircleSync = class("ShaderCircleSync", System)

function ShaderCircleSync:update(dt)
    -- Syncs the Position with the Physic. Physic is the primary component.
    for k, entity in pairs(self.targets) do
        local shape = entity:get("ShaderCircle").shape
        local body = entity:get("ShaderCircle").body
        local meter = entity:get("ShaderCircle").meter
        local cx, cy = body:getWorldCenter()
        entity:get("ShaderCircle").circle:setPosition(math.floor(cx), math.floor(cy))
        entity:get("ShaderCircle").circle:setRadius(math.floor(shape:getRadius()*meter))
    end
end

function ShaderCircleSync:requires()
    return {"ShaderCircle"}
end

return ShaderCircleSync
