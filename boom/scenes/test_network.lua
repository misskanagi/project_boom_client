local test_network = class("test_network")

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

--network
--net:connect("172.28.37.19", 8080)
--net:connect("192.168.1.101", 8080)
--net:connect("114.212.83.208", 8080)
--net:startReceiving()

function test_network:enter(pre, init_table)
    --解出玩家自己的id
    --my_name = init_table and init_table["myId"]    --玩家的id即my_name
    --isMaster = init_table and init_table["isMaster"] or false  --玩家是否是master
    --isMaster = true
    --my_name = "yuge"
    -- init physics module
    self.world = world_module()
    -- init sti (map loader) module
    --self.map = map("maps/as_snow_network/as_snow.lua")
    self.map = map("maps/as_snow_network/base.lua")
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
            if o.properties["type"] == "player" or o.properties["type"] == "Player" then
              local e = nil
              if o.name == "spawn_point_1" then
                if my_name == "yuge" then
                  e = EM:createEntity(type, x, y, w, h, 0.0, "yuge", true, true)
                  net:loginTest("yuge")
                else
                  e = EM:createEntity(type, x, y, w, h, 0.0, "yuge", false, true)
                end
              elseif o.name == "spawn_point_2" then
                if my_name == "hako" then
                  e = entity:createEntity(type, x, y, w, h, 0.0, "hako", true)
                  net:loginTest("hako")
                else
                  e = EM:createEntity(type, x, y, w, h, 0.0, "hako", false)
                end
              elseif o.name == "spawn_point_3" then
                if my_name == "lsm" then
                  e = EM:createEntity(type, x, y, w, h, 0.0, "lsm", true)
                  net:loginTest("lsm")
                else
                  e = EM:createEntity(type, x, y, w, h, 0.0, "lsm", false)
                end
              end
              local t = e and engine:addEntity(e)
            else
              local e = EM:createEntity(type, x, y, w, h, 0.0)
              local t = e and engine:addEntity(e)
            end
        end
    end

	local sun = require "boom.entities.Sun" -- add sun
    engine:addEntity(sun(self.map, self.shader))
    self.system_manager = system_manager
    self.system_manager.addAllSystemsToEngine() -- add all systems to engine
    -- init camera
    self.camera = camera:instance()
    --self.camera:lookAt(1280, 1664)
    self.camera:lookAt(1968,1524)
end

function test_network:update(dt)
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
    net:update(dt)
end

function test_network:draw()
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
    -- draw particle system
    particle_canvas:draw()
    -- draw debug canvas
    debug_canvas:draw()
    -- camera detach
    self.camera:detach()
    -- draw HUD

end

function test_network:keypressed(key, scancode, isrepeat)
    eventmanager:fireEvent(events.KeyPressed(key, isrepeat))
end

function test_network:mousepressed(x, y, button, istouch)
    eventmanager:fireEvent(events.MousePressed(x, y, button))
end

function test_network:keyreleased(key, scancode)
    eventmanager:fireEvent(events.KeyReleased(key))
end

function test_network:mousereleased(x, y, button, istouch)
    eventmanager:fireEvent(events.MouseReleased(x, y, button))
end

function test_network:threaderror(thread, errorstr)
    print("Thread error!\n"..errorstr)
    -- thread:getError() will return the same error string now.
end

function love.threaderror(thread, errorstr)
    print("Thread error!\n"..errorstr)
    -- thread:getError() will return the same error string now.
end

return test_network
