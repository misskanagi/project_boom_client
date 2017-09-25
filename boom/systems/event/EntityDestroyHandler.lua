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
    --step 3: if need wreckage then generate it
    if entity:has("HasWreckage") then
        local wreckage_name = entity:get("HasWreckage").wreckage_name
        local cx, cy = entity:get("Physic").body:getWorldCenter()
        local e = EntityManager:createEntity(wreckage_name, cx, cy)
        if e then
            engine:addEntity(e)
        end
    end
    --step 4: remove physical body and entity id
    if entity:has("Physic") then
        local body = entity:get("Physic").body
        body:setUserData(nil)
        body:destroy()
    end
    if entity:has("EntityId") then
        local gid = entity:get("EntityId").id
        EntityManager:removeEntityFromList(gid)
    end
    --step 5: if it is player
    if entity:has("IsPlayer") then
        -- update group
        local src_dmg_entity = entity:get("Health").src_dmg_entity
        local src_player_name = nil
        if src_dmg_entity:has("IsPlayer") then
            src_player_name = src_dmg_entity:get("PlayerName").name
        end
        -- decrease group lives and add player death
        local dst_group_id = 1
        for _, g in pairs(engine:getEntitiesWithComponent("Group")) do
            local find = false
            for _, p in pairs(g:get("Group").players_info) do
                if p.player_id == entity:get("PlayerName").name then
                    find = true
                    g:get("Group").lives = g:get("Group").lives - 1
                    p.death = p.death + 1
                    dst_group_id = g:get("Group").id
                    break
                end
            end
            if find then break end
        end
        -- let src player kill + 1
        local src_group_id = 1
        for _, g in pairs(engine:getEntitiesWithComponent("Group")) do
            local find = false
            for _, p in pairs(g:get("Group").players_info) do
                if p.player_id == src_player_name then
                    find = true
                    src_group_id = g:get("Group").id
                    if dst_group_id ~= src_group_id then
                        p.kill = p.kill + 1
                    end
                    break
                end
            end
            if find then break end
        end
    end
    --step 6: remove entity
    engine:removeEntity(entity)
end

return EntityDestroyHandler
