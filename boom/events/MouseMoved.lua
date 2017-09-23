--鼠标移动
local MouseMoved = class("MouseMoved")

function MouseMoved:initialize(x, y)
    self.x = x
    self.y = y
end

return MouseMoved

