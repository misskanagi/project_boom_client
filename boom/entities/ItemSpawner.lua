local Spawnable = require "boom.components.control.Spawnable"
local Light = require("boom.components.graphic.Light")
local Physic = require "boom.components.physic.Physic"

--[[local default_list = {
    "AdvancedShellItem", "AdvancedShellItem", "AdvancedShellItem", "AdvancedShellItem", "AdvancedShellItem",
    "BoosterItem",  "BoosterItem",  "BoosterItem",  "BoosterItem",  "BoosterItem",
    "HealShellItem",  "HealShellItem",  "HealShellItem",  "HealShellItem",  "HealShellItem",
    "HealthBoxItem",  "HealthBoxItem",  "HealthBoxItem",  "HealthBoxItem",  "HealthBoxItem",  "HealthBoxItem",  "HealthBoxItem",
    "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",  "LandmineItem",
    "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",  "NormalShellItem",
    "NuclearShellItem",
}]]
local default_list = {
    "AdvancedShellItem",
    "BoosterItem",
    "HealShellItem",
    "HealthBoxItem",
    "LandmineItem",
    "NormalShellItem",
    "NuclearShellItem",
}

local createItemSpawner = function(x, y, w, h, r, item_list, world, light_world)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local body = love.physics.newBody(world, sx, sy, "static")
    local shape = love.physics.newRectangleShape(w, h)
    local fixture = love.physics.newFixture(body, shape)
    local item_list = item_list or default_list
    local start_spawn = (x + y) % 7 + 1
    local spawn_index_func = function()
        start_spawn = (start_spawn + 1) % 7 + 1
        return start_spawn
    end
    fixture:setSensor(true)
    e:add(Spawnable(item_list,
        function(dt)
            return spawn_index_func()
        end,
        function(dt)
            for _, e in pairs(e.children) do
                if e then
                    return false
                end
            end
            return true
        end, 10,
        x, y, w, h, r, player_id, is_myself, is_room_master
    ))
    e:add(Physic(body))
    local r, g, b = math.random(255), math.random(255), math.random(255)
    local t = light_world and e:add(Light(light_world, sx, sy, 16, r, g, b, 64))
    return e
end

return createItemSpawner
