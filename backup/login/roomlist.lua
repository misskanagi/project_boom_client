--管理房间列表
local roomlist = {}
local first_time_to_update = true


function roomlist.load()
  love.window.setFullscreen(true)
end

function roomlist.update(dt)
  if first_time_to_update then
    roomlist.load()
    first_time_to_update = false
  else
    
  end
  
end

function roomlist.draw()
end

function roomlist.textinput(text)
    gooi.textinput(text)
end

function roomlist.gamepadpressed(joystick, button)
  -- 此处直接处理所有的手柄操作
  if button == "b" then
    whereami = places["room"]
  end
  
    
end

function roomlist.gamepadreleased(joystick, button)
  
end

return roomlist