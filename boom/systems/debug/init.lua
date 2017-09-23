local DebugPhysics = require "boom.systems.debug.DebugPhysics"
local DebugEntityId = require "boom.systems.debug.DebugEntityId"
local DebugGraphicStatus = require "boom.systems.debug.DebugGraphicStatus"
local DebugExplosiveRange = require "boom.systems.debug.DebugExplosiveRange"
local DebugBooster = require "boom.systems.debug.DebugBooster"
local DebugHealth = require "boom.systems.debug.DebugHealth"

local debug = {
    DebugPhysics(),
    DebugEntityId(),
    DebugGraphicStatus(),
    DebugExplosiveRange(),
    DebugBooster(),
    DebugHealth(),
}

debug.names = {
    "DebugPhysics",
    "DebugEntityId",
    "DebugGraphicStatus",
    "DebugExplosiveRange",
    "DebugBooster",
    "DebugHealth",
}


return debug
