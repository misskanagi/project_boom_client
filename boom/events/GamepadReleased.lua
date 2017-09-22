local GamepadReleased = class("GamepadReleased")

function GamepadReleased:initialize(button)
    --self.joystick = joystick
    self.button = button
end

return GamepadReleased
