--进入房间以后的ui
local room = class("room")

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local lg = love.graphics

function room:enter()
  
end

function room:update(dt)
  gui:update(dt)
  gooi.update()
end

function room:draw()
  gui:draw()
  gooi.draw()
end

return room
