local DebugPhysics = require "boom.systems.debug.DebugPhysics"
local DebugGlobalEntityId = require "boom.systems.debug.DebugGlobalEntityId"
local DebugGraphicStatus = require "boom.systems.debug.DebugGraphicStatus"

local debug = {
    DebugPhysics = DebugPhysics(),
    DebugGlobalEntityId = DebugGlobalEntityId(),
    DebugGraphicStatus = DebugGraphicStatus(),
}

return debug
