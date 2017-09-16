local Class = require("libs.hump.class")
local sti = require("libs.sti")
local bump = require('libraries/bump/bump')
local bump_debug = require('libraries/bump/bump_debug')
local player = require('specific/player')

local scene = Class{}

local map-- = sti.new("maps/map01")
local world-- = bump.newWorld(global.cellsize)
local timer = require('utils.timer')

function scene:init()
end

function scene:init()
   self.map = sti.new("maps/map01")
   self.world = bump.newWorld(global.cellsize)
   self:reset()
   --set camera
   local p = map.layers['sprites'].sprites.player
   local x,y = p:pos()
   cam = camera(x, y)
end

function scene:reset()
   self:loadSpriteLayer()
   self:loadItemLayer()
   self:loadTrapLayer()
   -- init hud
   self.hud = hud(map.layers['sprites'].sprites.player)
   -- load all tiles
   l = map.layers['ground']
   self:loadTiles(l)
end

function scene:update(dt)
   self.map:update(dt)
end

function scene:draw()
   cam:attach()
   local sprite = map.layers["sprites"].sprites.player
   local imageLayer = map.layers["background image"]
   local iw,ih = imageLayer.image:getDimensions()
   local x,y = sprite:pos()
   local cx,cy = cam:pos()
   local fx = cx/(map.width*map.tilewidth)
   local fy = cy/(map.height*map.tileheight)
   local nx = iw*fx
   local ny = ih*fy

   local sw,sh = love.graphics.getDimensions()

   local tx = cx-nx
   local ty = cy-ny

   -- parallax background
   if ty+ih<cy+sh/2 then ty=cy+sh/2-ih end
   if tx+iw<cx+sw/2 then tx=cx+sw/2-iw end
   if ty>cy-sh/2 then ty=cy-sh/2 end
   if tx>cx-sw/2 then tx=cx-sw/2 end
   imageLayer.x = tx--imageLayer.x/2
   imageLayer.y = ty--imageLayer.y/2

   map:draw()

   if global.debug then
      drawWorldCollision(world)
      --bump_debug.draw(world)
   end

   cam:detach()

   -- HUD
   self.hud:draw()

   if global.debug then
      local statistics =
         ("fps: %d, mem: %dKB, collisions: %d, items: %d, sfx: %d"):format(
            love.timer.getFPS(),
            collectgarbage("count"),
            sprite:getColLen(),
            world:countItems(),                                              media.countInstances())
      love.graphics.setColor(255, 255, 255)
      love.graphics.printf(statistics, sw-450, sh-30, 400, 'right')

      --player debug info
      sprite:drawDebugInfo()
      --camera info
      local caminfo =
         ("camX: %04d, camY: %04d, playerX: %04d, playerY: %04d"):format(
            cx,cy,x,y)
      love.graphics.printf(caminfo, 20, sh-30, 400, 'left')
   end
end

function test1:keypressed(key)
end

function test1:keyreleased(key)
end

return scene
