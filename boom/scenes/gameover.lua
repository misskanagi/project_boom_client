--gameover以后播放的画面

local gameover = class("gameover")
local myId = nil
local winOrLose = nil
local game_state = require("libs.hump.gamestate")
local cam = require("boom.camera")
local camera = cam:instance()

function gameover:enter(pre, init_table)
  myId = init_table and init_table["myId"]
  winOrLose = init_table and init_table["winOrLose"]
end


function gameover:update(dt)
  
end


function gameover:draw()
  if winOrLose then
    love.graphics.print("you win!")
  else
    love.graphics.print("you win!")
  end
end

function gameover:keypressed(key, scancode)
  if key == "space" then
    local roomlist = require "boom.scenes.roomlist"
    local init_table = {}
    --init_table
    init_table["myId"] = myId
    game_state.switch(roomlist, init_table)
  end
end

return gameover