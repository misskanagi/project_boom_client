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

--event manager
eventmanager = EventManager()

-- end global variables(only)

-- game state
local game_state = require("libs.hump.gamestate")

-- test scene
local test_place = require("boom.scenes.test_place")

function love.load()
    game_state.registerEvents()
    game_state.switch(test_place)
end
