--创建房间的UI
local create_room = class("create_room")

local game_state = require("libs.hump.gamestate")
local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local lg = love.graphics


function create_room:enter()
  
end

function create_room:update(dt)
  
end

function create_room:draw()
  
end


return create_room