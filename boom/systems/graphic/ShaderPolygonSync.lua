local ShaderPolygonSync = class("ShaderPolygonSync", System)

function ShaderPolygonSync:update(dt)
    -- Syncs the Position with the Physic. Physic is the primary component.
    for k, entity in pairs(self.targets) do
        local sp = entity:get("ShaderPolygon")
        local shape = sp.shape
        local body = sp.body
        local points = {shape:getPoints()}
        local polygon = sp.polygon
        for i=1,#points do
          points[i] = math.floor(points[i])
        end
        -- update angle
        polygon:setRotation(body:getAngle())
        -- update position
        local cx, cy = body:getWorldCenter()
        polygon:setPosition(cx, cy)
    end
end

function ShaderPolygonSync:requires()
    return {"ShaderPolygon"}
end

return ShaderPolygonSync
