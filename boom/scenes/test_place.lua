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

--Shader
local shader = require("boom.shader")

function test_place:enter()
    -- init physics module
    self.world = world_module()
    -- init sti (map loader) module
    self.map = sti("maps/as_snow/as_snow.lua")
    -- init Shader
    self.shader = shader()
    -- init ECS engine
    local walls = require "boom.entities.Walls" -- add walls
    for _, w in pairs(walls(self.world, self.map, self.shader)) do
        engine:addEntity(w)
    end
    local player = require "boom.entities.Player" -- add player
    local p = player(self.world, self.map, self.shader)
    self.player = p
    engine:addEntity(p)
    local lights = require "boom.entities.Lights" -- add lights
    for _, l in pairs(lights(self.world, self.map, self.shader)) do
        engine:addEntity(l)
    end
    --[[local sun = require "boom.entities.Sun" -- add sun
    engine:addEntity(sun(self.map, self.shader))]]
    self.system_manager = system_manager()
    self.system_manager:addAllSystemsToEngine() -- add all systems to engine
    -- init camera
    self.camera = camera
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
    -- update shader
    self.shader:update(dt)
    self.shader:setTranslation(
      -self.camera.x + love.graphics.getWidth()/2,
      -self.camera.y + love.graphics.getHeight()/2,
      self.camera.scale)
end

function test_place:draw()
    -- camera attach
    self.camera:attach()
    self.shader:draw(function()
        -- test
        local w, h = love.graphics.getWidth(), love.graphics.getHeight()
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", (self.camera.x-w/2)/self.camera.scale, (self.camera.y-h/2)/self.camera.scale,
                                 w/self.camera.scale, h/self.camera.scale)
        love.graphics.setColor(255, 255, 255)
        -- draw map
        self.map:draw()
        -- draw ECS engine
        engine:draw()
    end)
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
