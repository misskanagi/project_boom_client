local EM = require "boom.entities"
local Vector = require "libs.hump.vector"
local camera = require "boom.camera"
local LaunchableSync = class("LaunchableSync", System)

function LaunchableSync:update(dt)
    for k, entity in pairs(self.targets) do
        local L = entity:get("Launchable")
        if L.cmd.launch then
            L.cmd.launch = false
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
                -- give negative push
                if entity:has("Physic") and e:has("Booster") then
                    local p_body = entity:get("Physic").body
                    local cx, cy = body:getWorldCenter()
                    local nx, ny = body:getWorldVector(0, 1)
                    local force = e:get("Booster").thrust_force
                    p_body:applyForce(force * nx, force * ny, cx, cy)
                end
            end
        end
    end
end

function LaunchableSync:requires()
    return {"Launchable", "Turret"}
end

return LaunchableSync
