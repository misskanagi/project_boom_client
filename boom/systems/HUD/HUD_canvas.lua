local HUD_canvas = {}

function HUD_canvas:getCanvas()
  if HUD_canvas.canvas == nil then
    HUD_canvas.canvas = love.graphics.newCanvas()
  end
  return HUD_canvas.canvas
end

function HUD_canvas:draw()
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

return HUD_canvas
