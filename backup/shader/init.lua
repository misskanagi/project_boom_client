local Shadows = require("shadows")
local LightWorld = require("shadows.LightWorld")
local Light = require("shadows.Light")
local Star = require("shadows.Star")
local Body = require("shadows.Body")
local PolygonShadow = require("shadows.ShadowShapes.PolygonShadow")
local CircleShadow = require("shadows.ShadowShapes.CircleShadow")
local Shader = class("Shader")
--local player = player

-- init shadow world from physics world
function Shader:initialize(world)
  self.shadow_world = LightWorld:new()
  self.shadow_world:Resize(5000, 5000)
  self.shadow_world:InitFromPhysics(world)
  self.light = Light:new(self.shadow_world, 500)
  --self.light = Star:new(self.shadow_world, 5000)
  self.light:SetColor(255, 255, 255, 255)
  -- set light position
  for _, body in pairs(world:getBodyList()) do
    entity = body:getUserData()
    if entity and entity:get("IsPlayer") then
      local x, y = entity:get("Position").x, entity:get("Position").y
      self.light:SetPosition(x, y, 3)
    end
  end
end

function Shader:update(dt)
  -- update light
  for _, entity in pairs(engine:getEntitiesWithComponent("IsPlayer")) do
    local x, y = entity:get("Position").x, entity:get("Position").y
    self.light:SetPosition(x, y, 3)
  end
	self.shadow_world:Update(dt)
end

function Shader:draw()
  love.graphics.setColor(255, 255, 255, 255)
	--love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
	self.shadow_world:Draw()
end

return Shader
