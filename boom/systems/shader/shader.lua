local Shadows = require("shadows")
local LightWorld = require("shadows.LightWorld")
local Light = require("shadows.Light")
local Star = require("shadows.Star")
local Body = require("shadows.Body")
local PolygonShadow = require("shadows.ShadowShapes.PolygonShadow")
local CircleShadow = require("shadows.ShadowShapes.CircleShadow")
local Class = require("libs.hump.class")
local Shader = Class{}
--local player = player

-- init shadow world from physics world
function Shader:init(world)
  self.shadow_world = LightWorld:new()
  self.shadow_world:InitFromPhysics(world)
  --self.light = Light:new(self.shadow_world, 300)
  self.light = Star:new(self.shadow_world, 5000)
  self.light:SetColor(255, 255, 255, 255)
end

function Shader:update(dt)
  local a = love.timer.getTime()
	self.light:SetPosition(0, 0, 100)
	self.shadow_world:Update()
end

function Shader:draw()
  love.graphics.setColor(255, 255, 255, 26)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
	self.shadow_world:Draw()
end

return Shader
