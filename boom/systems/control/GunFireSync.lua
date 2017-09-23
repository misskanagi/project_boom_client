local Vector = require("libs.hump.vector")
local events = require("boom.events")
local GunFireSync = class("GunFireSync", System)

local elapsed = 0.0
local every = 0.05

function GunFireSync:update(dt)
    elapsed = elapsed + dt

    for index, entity in pairs(self.targets) do
        local fire = entity:get("Firable")
        local cmd = entity:get("Firable").cmd
        local fps = entity:get("Firable").fire_ps
        local light = entity:get("Firable").fire_light
        -- update hit ps set
        if fire.hit_active > 0 then
            for i = 1, fire.hit_max, 1 do
                fire.all_hit_ps[i]:update(dt)
                if fire.all_hit_pos[i].x ~= nil and fire.all_hit_ps[i]:isStopped() then
                    fire.all_hit_pos[i].x, fire.all_hit_pos[i].y, fire.all_hit_pos[i].r = nil, nil, nil
                    fire.hit_active = fire.hit_active - 1
                end
            end
        end
        if cmd.fire == true then
            fps:update(dt)
            if fps:isStopped() then
                fps:start()
            end
            -- update light
            local turret_body = entity:get("Turret").body
            local cx, cy = turret_body:getWorldCenter()
            local r = turret_body:getAngle()
            if elapsed > every then
                elapsed = 0.0
                local lv = Vector(0, -32)
                lv:rotateInplace(r)
                light:setDirection(turret_body:getAngle()-math.pi/2)
                light:setPosition(cx+lv.x, cy+lv.y, entity:get("Firable").height)
                light:setVisible(true)
            else
                light:setVisible(false)
            end
            -- update hit entity
            local rv = Vector(0, -1)
            rv:rotateInplace(r)
            local hx, hy, hr = self:findHitEntity(entity, fire, cx, cy, cx+rv.x*fire.fire_range,
                                                  cy+rv.y*fire.fire_range, r+math.pi/2)
            -- add to hit set
            if hx then
                fire.all_hit_ps[fire.hit_curr]:start()
                fire.all_hit_pos[fire.hit_curr].x = hx
                fire.all_hit_pos[fire.hit_curr].y = hy
                fire.all_hit_pos[fire.hit_curr].r = hr
                fire.hit_curr = fire.hit_curr + 1
                if fire.hit_curr > fire.hit_max then
                    fire.hit_curr = 1
                end
                fire.hit_active = fire.hit_active + 1
                if fire.hit_active > fire.hit_max then
                    fire.hit_active = fire.hit_max
                end
            end
        else
            light:setVisible(false)
        end
    end
end

function GunFireSync:findHitEntity(src_entity, fire_comp, x1, y1, x2, y2, r)
    local closestFraction = 1
    local hit_x = nil
    local hit_y = nil
    local hit_r = r
    local closet_entity = nil
    for _, entity in pairs(engine:getEntitiesWithComponent("Physic")) do
        local body = entity:get("Physic").body
        for _, fix in pairs(body:getFixtureList()) do
            -- calculate ray cast
            local xn, yn, fraction = fix:rayCast(x1, y1, x2, y2, 1)
            if xn then
                if fraction < closestFraction then
                    closet_entity = entity
                    closestFraction = fraction
                    hit_x, hit_y = x1 + (x2 - x1) * fraction, y1 + (y2 - y1) * fraction
                end
            end
        end
    end
    if closet_entity and closet_entity:has("Health") then
        if src_entity:has("Physic") and closet_entity:has("Physic") then
            local x1, y1 = src_entity:get("Physic").body:getWorldCenter()
            local x2, y2 = closet_entity:get("Physic").body:getWorldCenter()
            local dist = math.sqrt(math.pow(x1-x2, 2) + math.pow(y1-y2, 2))
            local dmg = src_entity:get("Firable").fire_dmg
            local range = src_entity:get("Firable").fire_range
            eventmanager:fireEvent(events.Damage(src_entity, closet_entity, dmg, dist, range))
        end
    end
    return hit_x, hit_y, hit_r
end

function GunFireSync:requires()
    return {"Firable", "Turret"}
end

return GunFireSync
