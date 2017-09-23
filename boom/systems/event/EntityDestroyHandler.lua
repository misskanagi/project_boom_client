local EntityManager = require "boom.entities"
local EntityDestroyHandler = class("EntityDestroyHandler", System)

function EntityDestroyHandler:fireEntityDestroy(event)
    local entity = event.entity
    local light_world = EntityManager.shader
    -- step 1: disable sti object drawing
    if entity:has("DrawableSTIObject") then
        for _, o in pairs(entity:get("DrawableSTIObject").objects) do
            o.tab.batch:set(o.tab.id, 0, 0, 0, 0, 0)
        end
    end
    --step 2: disable light and shadow
    if entity:has("Light") then
        light_world:remove(entity:get("Light").light)
    end
    if entity:has("ShaderPolygon") then
        for _, p in pairs(entity:get("ShaderPolygon").polygon_list) do
            light_world:remove(p)
        end
    end
    --step 4: if need wreckage then generate it
    if entity:has("HasWreckage") then
        local wreckage_name = entity:get("HasWreckage").wreckage_name
        local cx, cy = entity:get("Physic").body:getWorldCenter()
        local e = EntityManager:createEntity(wreckage_name, cx, cy)
        if e then
            engine:addEntity(e)
        end
    end
    --step 3: remove physical body and entity
    if entity:has("EntityId") and entity:has("Physic") then
        local gid = entity:get("EntityId").id
        local body = entity:get("Physic").body
        body:setUserData(nil)
        body:destroy()
        EntityManager:removeEntityFromList(gid)
        engine:removeEntity(entity)
    end
end

return EntityDestroyHandler
