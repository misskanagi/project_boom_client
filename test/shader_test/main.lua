local Shadows = require("shadows")
local LightWorld = require("shadows.LightWorld")
local Light = require("shadows.Light")
local Body = require("shadows.Body")
local PolygonShadow = require("shadows.ShadowShapes.PolygonShadow")
local CircleShadow = require("shadows.ShadowShapes.CircleShadow")

newLightWorld = LightWorld:new()
newLight = Light:new(newLightWorld, 300)
newLight:SetColor(255, 255, 255, 255)

newLight:SetPosition(400, 400)

newBody = Body:new(newLightWorld)
newBody:SetPosition(300, 300)
newBody:SetAngle(-15)
PolygonShadow:new(newBody, -10, -10, 10, -10, 10, 10, -10, 10)
CircleShadow:new(newBody, -30, -30, 16)

newBody2 = Body:new(newLightWorld)
newBody2:SetPosition(350, 350)
PolygonShadow:new(newBody2, -20, -20, 20, -20, 20, 20, -20, 20)

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
	newLightWorld:Draw()
end

function love.update()
	local a = love.timer.getTime()
	newLight:SetPosition(love.mouse.getX(), love.mouse.getY(), 1.1)
	newLightWorld:Update()
end

function love.mousepressed()
	newLight = Light:new(newLightWorld, 300)
	newLight:SetColor(math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
end
