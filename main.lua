-- load all the scene modules.
game = require "./scripts/chaos/game"
titlemenu = require "titlemenu"
selectroom = require "./scripts/room/selectroom"
createroom = require "./scripts/room/createroom"
roomlist = require "./scripts/login/roomlist"
room = require "./scripts/login/room"
login = require "./scripts/login/login"
--load some tool modules
log = require "./libs/log"
--require("alien")
log.logswitch(false)  --关闭log开关
serialize = require "./libs/serialize"
sti = require "./libs/sti"
input_handler = require "./scripts/chaos/input_handler"
--when the player clicked the key "s", then the game begin.
places = {["titlemenu"] = "titlemenu",["game"] = "game", ["selectroom"] = "selectroom", ["createroom"] = "createroom", ["roomlist"] = "roomlist", ["room"] = "room", ["login"] = "login"}
map_places_modules = {["titlemenu"] = titlemenu, ["game"] = game, ["selectroom"] = selectroom, ["createroom"] = createroom,["roomlist"] = roomlist, ["room"] = room, ["login"] = login}
whereami = places["game"] -- at very beginning, we are at title-menu.
local initial_string = nil  --initial_stirng是Server返回给title-menu的gamebegin的消息中附带的初始化game的序列化串，其中包含地图信息，以及所有的Client的信息。

function love.load()
  --使用log模块创建一个log文件,log的输出函数是trace()，debug()，info()，warn()，error()，fatal()
  log.newfreshlog("./log/logfile.txt")
  love.mouse.setVisible(false)
end


function love.update(dt)
  local current_module = map_places_modules[whereami]
  if current_module.update then
    current_module.update(dt)
  end
end


function love.draw()
  local current_module = map_places_modules[whereami]
  if current_module.draw then
    current_module.draw()
  end
end

--手柄功能
function love.gamepadpressed(joystick, button)
  local current_module = map_places_modules[whereami]
  if current_module.gamepadpressed then
    current_module.gamepadpressed(joystick, button)
  end
end

function love.gamepadreleased(joystick, button)
  local current_module = map_places_modules[whereami]
  if current_module.gamepadreleased then
    current_module.gamepadreleased(joystick, button)
  end
end

function love.keyreleased(key)
  local current_module = map_places_modules[whereami]
  if current_module.keyreleased then
    current_module.keyreleased(key)
  end
end

function love.keypressed(key, scancode, isrepeat)
  local current_module = map_places_modules[whereami]
  if current_module.keypressed then
    current_module.keypressed(key, scancode, isrepeat)
  end
end

function love.threaderror(thread, errorstr)
  log.error("Thread error!\n"..errorstr)
  -- thread:getError() will return the same error string now.
end

-- deal with 0.10 mouse API changes
function love.mousepressed(x, y, button)
	local current_module = map_places_modules[whereami]
  if current_module.mousepressed then
    current_module.mousepressed(x, y, button)
  end
end

function love.mousereleased(x, y, button)
	local current_module = map_places_modules[whereami]
  if current_module.mousereleased then
    current_module.mousereleased(x, y, button)
  end
end

function love.textinput(text)
  local current_module = map_places_modules[whereami]
  if current_module.textinput then
    current_module.textinput(text)
  end
end


function love.joystickadded(joystick)
  input_handler.map_joystick(joystick)
  if joystick1 == nil then
    -- 此时还没有1号手柄
    joystick1 = joystick
  elseif joystick2 == nil then
    -- 1号手柄有了但是还没有2号手柄
    joystick2 = joystick
  end
end

function love.joystickremoved(joystick)
  if joystick == joystick1 then
    joystick1 = joystick2
    joystick2 = nil
  end
end


