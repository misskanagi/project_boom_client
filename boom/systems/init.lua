local physics = require "boom.systems.physics"
local graphic = require "boom.systems.graphic"
local event = require "boom.systems.event" -- event system's initialization is different
local control = require "boom.systems.control"
local network = require "boom.systems.network"
local logic = require "boom.systems.logic"
local debug = require "boom.systems.debug"
local HUD = require "boom.systems.HUD"

local modules = {
    physics = physics,
    graphic = graphic,
    event = event,
    debug = debug,
    network = network,
    control = control,
    logic = logic,
    HUD = HUD,
}

local system_manager = {
  startModule = function(module_name)
      for n, s in pairs(modules[module_name]) do
          engine:startSystem(n)
      end
  end,

  stopModule = function(module_name)
      for n, s in pairs(modules[module_name]) do
          engine:stopSystem(n)
      end
  end,

  toggleModule = function(module_name)
      for n, s in pairs(modules[module_name]) do
          engine:toggleSystem(n)
      end
  end,

  addAllSystemsToEngine = function()
    for _, module in pairs(modules) do
      for _, system in pairs(module) do
        engine:addSystem(system)
      end
    end
    -- disable debug system first
    for n, s in pairs(modules["debug"]) do
        engine:stopSystem(n)
    end
    -- disable HUDBattle system first
    engine:toggleSystem("HUDBattle")
  end,
}

return system_manager
