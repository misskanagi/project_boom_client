-- start global variables(only)
-- Importing lovetoys (ECS engine)
lovetoys = require("libs.lovetoys.lovetoys")
lovetoys.initialize({
    globals = true,
    debug = false
})

--load some tool modules
log = require("libs.log")
--require("alien")
log.logswitch(false)  --关闭log开关

--ECS engine
engine = Engine()

--network
test_on_windows = true
local system = love.system.getOS()
if system == "OS X" then
  test_on_windows = false
end

local network = nil
if not test_on_windows then
  --暂时在这里建立网络连接
  network = require("boom.network")
  net = network:instance()
<<<<<<< HEAD
end
--暂时在这里建立网络连接
if not test_on_windows then
    --net:connect("192.168.1.108", 8080)
    --net:connect("172.28.37.19", 8080)
    --net:connect("114.212.83.208", 8080)
    --net:startReceiving()
=======
  net:connect("192.168.1.105", 8080)
  --net:connect("172.28.37.19", 8080)
  --net:connect("114.212.83.208", 8080)
  net:startReceiving()
>>>>>>> origin/alpha
end
--event manager
eventmanager = EventManager()

-- end global variables(only)

-- 加载资源
local AM = require("assets")
local AssetsManager = AM:instance()

-- game state
local game_state = require("libs.hump.gamestate")

-- test scene
local test_place = require("boom.scenes.test_place")
login = require("boom.scenes.login")
roomlist = require("boom.scenes.roomlist")
room = require("boom.scenes.room")
create_room = require("boom.scenes.create_room")

-- test choice
local test_choice = require("boom.scenes.test_choice")

--将guid对应的手柄映射到xbox键位
local function map_gamepad_with_guid(joystick_guid)
  love.joystick.setGamepadMapping(joystick_guid, "a", "button", 2)
  love.joystick.setGamepadMapping(joystick_guid, "b", "button", 3)
  love.joystick.setGamepadMapping(joystick_guid, "x", "button", 1)
  love.joystick.setGamepadMapping(joystick_guid, "y", "button", 4)
  love.joystick.setGamepadMapping(joystick_guid, "leftshoulder", "button", 5)--ps4 l1
  love.joystick.setGamepadMapping(joystick_guid, "rightshoulder", "button", 6) --ps4 r1
  love.joystick.setGamepadMapping(joystick_guid, "leftstick", "button", 11) --ps4 左摇杆按下
  love.joystick.setGamepadMapping(joystick_guid, "rightstick", "button", 12) --ps4 右摇杆按下
  love.joystick.setGamepadMapping(joystick_guid, "guide", "button", 13)  --ps4 PS键
  love.joystick.setGamepadMapping(joystick_guid, "back", "button", 9) --ps4 SHARE键
  love.joystick.setGamepadMapping(joystick_guid, "start", "button", 10)-- ps4 OPTIONS键
  love.joystick.setGamepadMapping(joystick_guid, "dpup", "hat", 1, "u")
  love.joystick.setGamepadMapping(joystick_guid, "dpdown", "hat", 1, "d")
  love.joystick.setGamepadMapping(joystick_guid, "dpleft", "hat", 1, "l")
  love.joystick.setGamepadMapping(joystick_guid, "dpright", "hat", 1, "r")
end

-- test network
-- local test_network = require("boom.scenes.test_network")

local osx_joystick_guid = "4c05000000000000cc09000000000000"
local win_joystick_guid = "4c05cc09000000000000504944564944"
map_gamepad_with_guid(osx_joystick_guid)
map_gamepad_with_guid(win_joystick_guid)

function love.load()
    love.mouse.setVisible(false)
    print(love.filesystem.getSaveDirectory())
    game_state.registerEvents()
    local titles = require "boom.scenes.titles"
    --game_state.switch(login)
    game_state.switch(titles)
    --game_state.switch(test_choice)
    --game_state.switch(test_network)
    game_state.switch(test_place)
end