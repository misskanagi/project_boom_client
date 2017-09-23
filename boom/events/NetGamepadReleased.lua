local NetGamepadReleased = class("NetGamepadReleased")

function NetGamepadReleased:initialize(button, player_name)
    self.button = button
    self.name = player_name
end

return NetGamepadReleased
