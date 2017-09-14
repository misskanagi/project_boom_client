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
  
end

function create_room:update(dt)
  
end

function create_room:draw()
  
end

--提交当前的选择表给Server
submit_request = function()
  
end


return create_room