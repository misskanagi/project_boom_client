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

--HUD canvas
local HUD_canvas = require "boom.systems.HUD.HUD_canvas"

--network
--net:connect("172.28.37.19", 8080)
--net:connect("192.168.1.101", 8080)
--net:connect("114.212.83.208", 8080)
--net:startReceiving()

function test_network:enter(pre, info)
    local my_name = info.my_id
    -- init physics module
    self.world = world_module()
    -- init sti (map loader) module
    -- self.map = map("maps/as_snow_network/as_snow.lua")
    self.map = map("maps/as_snow_network/base_new.lua")
    -- init Shader
    self.shader = shader()
    -- init ECS engine
    local layer = self.map.layers["entity_layer_1"]
    EM:init(layer, self.map, self.world, self.shader)
    local player_info_index = 1
    local max_player_num = #info.players_info
    for _, o in pairs(layer.objects) do
        local type = o.properties["type"]
        local x, y, w, h = o.x, o.y, o.width, o.height
        if type == "Barrier" or type == "barrier" or type == "BarrierExplosive" or type == "barrierexplosive"  then
            local e = EM:createEntity(type, o)
            local t = e and engine:addEntity(e)
        else
            if o.properties["type"] == "playerspawner" or o.properties["type"] == "PlayerSpawner" then
              if player_info_index <= max_player_num then
                  local player_info = info.players_info[player_info_index]
                  local id = 1000000+player_info_index
                  player_info_index = player_info_index + 1
                  local player_id = player_info.player_id
                  local group_id = player_info.group_id
                  local tank_type = player_info.tank_type
                  local myself_flag = false
                  local room_master_flag = false
                  if player_id == my_name then
                      myself_flag = true
                  end
                  if player_id == info.room_master_id then
                      room_master_flag = true
                  end
                  local e = EM:createEntity(type, x, y, w, h, 0.0, player_id, myself_flag, room_master_flag, id)
                  --player_info.is_room_master = room_master_flag
                  --player_info.is_myself = myself_flag
                  --local e = EM:createEntity(type, x, y, w, h, 0.0, id, player_info)
                  local t = e and engine:addEntity(e)
              end
            else
              local e = EM:createEntity(type, x, y, w, h, 0.0)
              local t = e and engine:addEntity(e)
            end
        end
    end
    local g1 = EM:createEntity("group", 1, info.lives_per_team, info.players_info) -- create group 1
    local g2 = EM:createEntity("group", 2, info.lives_per_team, info.players_info) -- create group 2
    engine:addEntity(g1)
    engine:addEntity(g2)
    local sun = require "boom.entities.Sun" -- add sun
    --engine:addEntity(sun(self.map, self.shader))
    self.system_manager = system_manager
    self.system_manager.addAllSystemsToEngine() -- add all systems to engine
    -- init camera
    self.camera = camera:instance()
    self.camera:zoomTo(1.0)
    --self.camera:lookAt(1280, 1664)
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
    HUD_canvas:draw()
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
