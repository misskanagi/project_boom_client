local PSM = require "boom.particle"
local Spawnable = Component.create("Spawnable")

function Spawnable:initialize(entity_list, spawn_callback, spawn_condition_callback, delay, ...)
    self.entity_list = entity_list  --entity to spawn
    self.spawn_callback = spawn_callback
    --call in update, The spawnable will spawn entity when this callback return true
    self.spawn_condition_callback = spawn_condition_callback or function(dt) return false end
    self.spawn_params = {...} --params feed to entity factory
    self.delay = delay or 0
    self.triggered = false
end

return Spawnable
