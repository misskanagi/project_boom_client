local GamepadPressed = class("GamepadPressed")

function GamepadPressed:initialize(joystick, button)
    self.joystick = joystick
    self.button = button
end

return GamepadPressed