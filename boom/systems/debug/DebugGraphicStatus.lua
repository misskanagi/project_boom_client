local debug_canvas = require "boom.systems.debug.debug_canvas"
local DebugGraphicStatus = class("DebugGraphicStatus", System)

function DebugGraphicStatus:draw()
    local cvs = love.graphics.getCanvas()
    love.graphics.setCanvas(debug_canvas:getCanvas())
    local w, h = love.graphics.getDimensions()
    love.graphics.push()
    love.graphics.origin()
    love.graphics.setColor(255,255,255)
    love.graphics.print(("fps:%d"):format(love.timer.getFPS()), 20, h-20)
    love.graphics.pop()
    --return to old canvas
    love.graphics.setCanvas(cvs)
end

function DebugGraphicStatus:requires()
    return {}
end

return DebugGraphicStatus
