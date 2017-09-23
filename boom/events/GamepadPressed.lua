local GamepadPressed = class("GamepadPressed")

function GamepadPressed:initialize(button)
    --self.joystick = joystick
    self.button = button
end

return GamepadPressed