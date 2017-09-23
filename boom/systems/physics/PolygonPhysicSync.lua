local PolygonPhysicSync = class("PolygonPhysicSync", System)

function PolygonPhysicSync:draw()
    for index, entity in pairs(self.targets) do
        local body = entity:get("Physic").body
        local rec = entity:get("DrawablePolygon")
        for _, fix in pairs(body:getFixtureList()) do
            local shape = fix:getShape()
            if shape:getType() == "polygon" then
                rec.points = {body:getWorldPoints(shape:getPoints())}
                break
            end
        end
    end
end

function PolygonPhysicSync:requires()
    return {"DrawablePolygon", "Physic"}
end

return PolygonPhysicSync
