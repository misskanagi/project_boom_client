local EM = require "boom.entities"
local Vector = require "libs.hump.vector"
local camera = require "boom.camera"
local LaunchableSync = class("LaunchableSync", System)

local iv = Vector(0, 0)

local elapsed = 0.0

function LaunchableSync:update(dt)
    for k, entity in pairs(self.targets) do
        local L = entity:get("Launchable")
        if L.need_cool_down then
            elapsed = elapsed + dt
            if elapsed > L.cool_down_time then
                elapsed = 0.0
                L.need_cool_down = false
            end
        end
        if L.cmd.launch and not L.need_cool_down then
            L.cmd.launch = false
            L.need_cool_down = true
            if L.shell_count > 0 then
                L.shell_count = L.shell_count - 1
                -- shake camera
                camera:instance():shake(20, true)
                local meter = love.physics.getMeter()
                local body = entity:get("Turret").body
                local cx, cy = body:getWorldCenter()
                local w, h = meter * 0.2, meter * 1.0
                local v = Vector(0, -1.0*meter)
                v:rotateInplace(body:getAngle())
                local e = EM:createEntity(L.shell_name, cx+v.x-w/2, cy+v.y-h/2, w, h, body:getAngle())
                e:setParent(entity)
                engine:addEntity(e)
                -- play sound
                local cax, cay = camera:position()
                local meter = love.physics.getMeter() * audio_distance_scale
                L.launch_sound:setPosition( (cax - cx)/meter, (cay - cy)/meter, 0 )
                L.launch_sound:play()
                -- give negative push
                if entity:has("Physic") and e:has("Booster") then
                    -- push back
                    local p_body = entity:get("Physic").body
                    local cx, cy = body:getWorldCenter()
                    local nx, ny = body:getWorldVector(0, 1)
                    local impulse_constant = e:get("Booster").backlash_impulse_constant
                    local ix, iy = body:getMass() * impulse_constant * nx,
                                  body:getMass() * impulse_constant * ny
                    p_body:applyLinearImpulse(ix, iy, cx, cy)
                end
            end
        end
    end
end

function LaunchableSync:requires()
    return {"Launchable", "Turret"}
end

return LaunchableSync
