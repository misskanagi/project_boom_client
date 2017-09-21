local DebugPhysics = require "boom.systems.debug.DebugPhysics"
local DebugGlobalEntityId = require "boom.systems.debug.DebugGlobalEntityId"
local DebugGraphicStatus = require "boom.systems.debug.DebugGraphicStatus"
local DebugExplosiveRange = require "boom.systems.debug.DebugExplosiveRange"

local debug = {
    DebugPhysics = DebugPhysics(),
    DebugGlobalEntityId = DebugGlobalEntityId(),
    DebugGraphicStatus = DebugGraphicStatus(),
    DebugExplosiveRange = DebugExplosiveRange(),
}

return debug
