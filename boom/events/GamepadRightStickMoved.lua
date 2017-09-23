--手柄的右摇杆移动
local GamepadRightStickMoved = class("GamepadRightStickMoved")

function GamepadRightStickMoved:initialize(x, y)
    self.x = x
    self.y = y
end

return GamepadRightStickMoved

