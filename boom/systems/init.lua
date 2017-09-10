local physics = require "boom.systems.physics"
local graphic = require "boom.systems.graphic"
local event = require "boom.systems.event" -- event system's initialization is different

local system_manager = class("system_manager")

function system_manager:initialize()
    self.modules = {
        physics = physics,
        graphic = graphic,
        event = event,
    }
end

function system_manager:startModule(module_name)
    for _, s in pairs(self.systems[module_name]) do
        engine:startSystem(s)
    end
end

function system_manager:stopModule(module_name)
    for _, s in pairs(self.systems[module_name]) do
        engine:stopSystem(s)
    end
end

function system_manager:addAllSystemsToEngine()
  for _, module in pairs(self.modules) do
    for _, system in pairs(module) do
      engine:addSystem(system)
    end
  end
end

return system_manager
