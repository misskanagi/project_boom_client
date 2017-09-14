--创建房间的UI
local create_room = class("create_room")

local game_state = require("libs.hump.gamestate")
local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local lg = love.graphics

--lbl_title
local lbl_title = nil
--lbl_mode
local lbl_mode = nil
--lbl_people
local lbl_people = nil
--lbl_life
local lbl_life = nil
--lbl_map
local lbl_map = nil
local gooi_widgets = {} --记录所有的gooi控件

--前置声明
local submit_request

function create_room:enter()
  --创建控件
end

function create_room:update(dt)
  
end

function create_room:draw()
  
end


function create_room:gamepadpressed(joystick, button)
end

function create_room:gamepadreleased(joystick, button)
end


function create_room:keypressed(key, scancode, isrepeat)
end

function create_room:keyreleased(key)
end


--提交当前的选择表给Server
submit_request = function()
  
end


return create_room