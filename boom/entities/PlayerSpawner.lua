local Spawnable = require "boom.components.control.Spawnable"
local PlayerName = require("boom.components.identifier.PlayerName")
local Light = require("boom.components.graphic.Light")
local Physic = require "boom.components.physic.Physic"

local createPlayerSpawner = function(x, y, w, h, r, world, light_world, player_id, is_myself, is_room_master, id, group_id)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "static")
    local shape = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, shape)
    local group_mod = (group_id or 0) % 2
    local tire_color = {r=104, g=55, b=55}
    local turret_color = {r=204, g=55, b=55}
    if group_mod == 1 then
        tire_color = {r=55, g=55, b=104}
        turret_color = {r=55, g=55, b=204}
    end
    fixture:setSensor(true)
    e:add(Spawnable({"Player"},
        function(dt)
            return 1
        end,
        function(dt)
            for _, e in pairs(engine:getEntitiesWithComponent("IsPlayer")) do
                if e:get("PlayerName").name == player_id then
                    return false
                end
            end
            return true
        end, 1,
        x, y, w, h, r, player_id, is_myself, is_room_master, id, tire_color, turret_color
    ))
    e:add(PlayerName(player_id))
    e:add(Physic(body))
    local r, g, b = math.random(255), math.random(255), math.random(255)
    local t = light_world and e:add(Light(light_world, sx, sy, 16, r, g, b, 64))
    return e
end

return createPlayerSpawner
