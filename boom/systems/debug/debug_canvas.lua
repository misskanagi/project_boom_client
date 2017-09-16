local debug_canvas = {}

function debug_canvas:getCanvas()
  if debug_canvas.canvas == nil then
    debug_canvas.canvas = love.graphics.newCanvas()
  end
  return debug_canvas.canvas
end

function debug_canvas:draw()
  if self.canvas then
    love.graphics.push()
    love.graphics.origin()
    love.graphics.draw(self.canvas)
    love.graphics.pop()
    --clear canvas
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.setCanvas()
  end
end

return debug_canvas
