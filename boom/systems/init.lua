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
      for _, s in pairs(modules[module_name].names) do
          engine:startSystem(s)
      end
  end,

  stopModule = function(module_name)
      for _, s in pairs(modules[module_name].names) do
          engine:stopSystem(s)
      end
  end,

  toggleModule = function(module_name)
      for _, s in pairs(modules[module_name].names) do
          engine:toggleSystem(s)
      end
  end,

  addAllSystemsToEngine = function()
    for _, module in pairs(modules) do
      for _, system in ipairs(module) do
        --print(system)
        engine:addSystem(system)
      end
    end
    -- disable debug system first
    for _, s in pairs(modules["debug"].names) do
        engine:stopSystem(s)
    end
    -- disable HUDBattle system first
    engine:stopSystem("HUDBattle")
  end,
  
  removeAllEntities = function(self, root)
    print("system.reset")
    --local root = engine:getRootEntity()
    --engine:removeEntity(root, true)
    --engine:getEntitiesWithComponent("Group")
    for k, v in pairs(root.children) do
      self:removeAllEntities(v)
    end
    engine:removeEntity(root, false)
  end, 
  
  --[[removeSpawners = function()
    for k, v in pairs(engine:getEntitiesWithComponent("Spawnable")) do
      engine:removeEntity(v, true)
    end
  end]]--
}

return system_manager
