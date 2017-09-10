local test_place = class("test_place")

-- sti
local sti = require("libs.sti")

-- game state
local game_state = require("libs.hump.gamestate")

-- world
local world_module = require("boom.world")

-- camera
local camera = require("boom.camera")
--local camera = require("libs.hump.camera")

-- entity systems
local system_manager = require("boom.systems")

--events
local events = require("boom.events")

function test_place:enter()
    -- init physics module
    self.world = world_module()
    -- init sti (map loader) module
    self.map = sti("maps/as_snow/as_snow.lua")
    -- init ECS engine
    local walls = require "boom.entities.walls" -- add walls
    for _, w in pairs(walls(self.world, self.map)) do
        engine:addEntity(w)
    end
    local player = require "boom.entities.player" -- add player
    local p = player(self.world, self.map)
    engine:addEntity(p)
    self.system_manager = system_manager()
    self.system_manager:addAllSystemsToEngine() -- add all systems to engine
    -- init camera
    self.camera = camera

    debug_canvas = love.graphics.newCanvas( )
end

function test_place:update(dt)
    -- update ECS engine
    engine:update(dt)
    -- update physics world
    self.world:update(dt)
    -- update map
    self.map:update(dt)
    -- update camera
    self.camera:update(dt)
end

function test_place:draw()
    -- camera attach
    self.camera:attach()
    -- draw map
    self.map:draw()
    -- draw ECS engine
    engine:draw()
    -- camera detach
    self.camera:detach()
    -- draw HUD

end

function test_place:keypressed(key, scancode, isrepeat)
    eventmanager:fireEvent(events.KeyPressed(key, isrepeat))
end

function test_place.mousepressed(x, y, button, istouch)
    eventmanager:fireEvent(events.MousePressed(x, y, button))
end

function test_place:keyreleased(key, scancode)
    eventmanager:fireEvent(events.KeyReleased(key))
end

function test_place.mousereleased(x, y, button, istouch)
    eventmanager:fireEvent(events.MouseReleased(x, y, button))
end

return test_place
