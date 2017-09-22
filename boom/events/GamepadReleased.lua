local GamepadReleased = class("GamepadReleased")

function GamepadReleased:initialize(joystick, button)
    self.joystick = joystick
    self.button = button
end

return GamepadReleased
