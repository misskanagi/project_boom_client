local ShaderPolygonSync = class("ShaderPolygonSync", System)

function ShaderPolygonSync:update(dt)
    -- Syncs the Position with the Physic. Physic is the primary component.
    for k, entity in pairs(self.targets) do
        local sp = entity:get("ShaderPolygon")
        local shape_list = sp.shape_list
        local polygon_list = sp.polygon_list
        local offsets = sp.offsets
        local body = sp.body
        if body:getType() == "dynamic" then
            for i=1, #shape_list do
              offsets[i]:rotateInplace(body:getAngle()-polygon_list[i].rotation)
              -- update angle
              polygon_list[i]:setRotation(body:getAngle())
              -- update position
              local cx, cy = body:getWorldCenter()
              polygon_list[i]:setPosition(cx+offsets[i].x, cy+offsets[i].y)
            end
        end
    end
end

function ShaderPolygonSync:requires()
    return {"ShaderPolygon"}
end

return ShaderPolygonSync
