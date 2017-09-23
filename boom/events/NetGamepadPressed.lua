local NetGamepadPressed = class("NetGamepadPressed")

function NetGamepadPressed:initialize(button, player_name)
    self.button = button
    self.name = player_name
end

return NetGamepadPressed
