local TimerSync = class("TimerSync", System)
local Timer = require "libs.hump.timer"

function TimerSync:update(dt)
    Timer.update(dt)
end

function TimerSync:requires()
    return {"Nothing"}
end

return TimerSync
