local test_place = class("test_place")

-- sti
local map = require("boom.map")

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

--entity factory
local EM = require("boom.entities")

--debug canvas
local debug_canvas = require "boom.systems.debug.debug_canvas"

--particle canvas
local particle_canvas = require "boom.systems.graphic.particle_canvas"

function test_place:enter()
    -- init physics module
    self.world = world_module()
    -- init sti (map loader) module
    self.map = map("maps/as_snow/as_snow.lua")
    -- init Shader
    self.shader = shader()
    -- init ECS engine

    local layer = self.map.layers["entity_layer_1"]
    EM:init(layer, self.map, self.world, self.shader)
    for _, o in pairs(layer.objects) do
      local type = o.properties["type"]
      local x, y, w, h = o.x, o.y, o.width, o.height
      if type == "Barrier" or type == "barrier" then
          local e = EM:createEntity(type, o)
          local t = e and engine:addEntity(e)
      else
          if o.name == "spawn_point_1" then
            local e = EM:createEntity(type, x, y, w, h, 0.0, "me", true, false, 1000000)
            local t = e and engine:addEntity(e)
          elseif o.name == "spawn_point_2" then
            local e = EM:createEntity(type, x, y, w, h, 0.0, "enemy1", false, false, 1000001)
            local t = e and engine:addEntity(e)
          else
            local e = EM:createEntity(type, x, y, w, h, 0.0)
            local t = e and engine:addEntity(e)
          end
      end
    end
    --local sun = require "boom.entities.Sun" -- add sun
    --engine:addEntity(sun(self.map, self.shader))
    self.system_manager = system_manager
    self.system_manager.addAllSystemsToEngine() -- add all systems to engine
    -- init camera
    self.camera = camera:instance()
    self.camera:lookAt(1280, 1664)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    self.camera:zoomTo(w/800)
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
    --self.camera.scale = 1.0*love.graphics.getWidth()/800
    -- update shader
    self.shader:update(dt)
    self.shader:setTranslation(
      -self.camera.x + love.graphics.getWidth()/2,
      -self.camera.y + love.graphics.getHeight()/2,
      self.camera.scale)
    --print(c:pop())
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
    -- draw debug
    debug_canvas:draw()
    -- draw particle
    particle_canvas:draw()
    -- camera detach
    self.camera:detach()
    -- draw HUD

end

function test_place:keypressed(key, scancode, isrepeat)
    eventmanager:fireEvent(events.KeyPressed(key, isrepeat))
end

function test_place:mousepressed(x, y, button, istouch)
    eventmanager:fireEvent(events.MousePressed(x, y, button))
end

function test_place:keyreleased(key, scancode)
    eventmanager:fireEvent(events.KeyReleased(key))
end

function test_place:mousereleased(x, y, button, istouch)
    eventmanager:fireEvent(events.MouseReleased(x, y, button))
end

return test_place
