-- load all the scene modules.
titlemenu = require("titlemenu")
selectroom = require("boom.room.selectroom")
createroom = require("boom.room.createroom")
roomlist = require("boom.login.roomlist")
room = require("boom.login.room")
login = require("boom.login.login")
--load some tool modules
log = require("libs.log")
--require("alien")
log.logswitch(false)  --关闭log开关
serialize = require("libs.serialize")
sti = require("libs.sti")
input_handler = require("boom.control.input_handler")
--when the player clicked the key "s", then the game begin.
places = {["titlemenu"] = "titlemenu",["game"] = "game", ["selectroom"] = "selectroom", ["createroom"] = "createroom", ["roomlist"] = "roomlist", ["room"] = "room", ["login"] = "login"}
map_places_modules = {["titlemenu"] = titlemenu, ["game"] = game, ["selectroom"] = selectroom, ["createroom"] = createroom,["roomlist"] = roomlist, ["room"] = room, ["login"] = login}
whereami = places["game"] -- at very beginning, we are at title-menu.
local initial_string = nil  --initial_stirng是Server返回给title-menu的gamebegin的消息中附带的初始化game的序列化串，其中包含地图信息，以及所有的Client的信息。
local gamestate = require("libs.hump.gamestate")
local game = require("boom.scene.game")

function love.load()
  --使用log模块创建一个log文件,log的输出函数是trace()，debug()，info()，warn()，error()，fatal()
  log.newfreshlog("./log/logfile.txt")
  love.mouse.setVisible(false)
  gamestate.registerEvents()
  gamestate.switch(game)
end

function love.threaderror(thread, errorstr)
  log.error("Thread error!\n"..errorstr)
  -- thread:getError() will return the same error string now.
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
