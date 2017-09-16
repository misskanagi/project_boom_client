local test_choice = class("test_choice")
local game_state = require("libs.hump.gamestate")
local utf8 = require("utf8")
local selection = 0

function test_choice:update(dt)

end

function test_choice:draw()
   love.graphics.setColor(0, 255, 0, 255)

   if selection == 0 then
      love.graphics.setColor(255, 0, 0, 255)
      love.graphics.print("wo shi yuge", 300, 200)
   else
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.print("wo shi yuge", 300, 200)
   end

   if selection == 1 then
      love.graphics.setColor(255, 0, 0, 255)
      love.graphics.print("wo shi hako", 300, 250)
   else
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.print("wo shi hako", 300, 250)
   end

   if selection == 2 then
      love.graphics.setColor(255, 0, 0, 255)
      love.graphics.print("wo shi lsm", 300, 300)
   else
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.print("wo shi lsm", 300, 300)
   end
end

function test_choice:keyreleased(key)
   if key == 'up' then
      selection = (selection - 1)%3
   elseif key == 'down' then
      selection = (selection + 1)%3
   elseif key == 'return' or key == ' ' then
      if(selection == 0) then
        my_name = "yuge"
      end
      if(selection == 1) then
        my_name = "hako"
      end
      if(selection == 2) then
        my_name = "lsm"
      end
      local test_network = require "boom.scenes.test_network"
      game_state.switch(test_network)
   end
end

return test_choice
