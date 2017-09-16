local NetKeyReleased = class("NetKeyReleased")

function NetKeyReleased:initialize(key, isrepeat, player_name)
    self.key = key
    self.isrepeat = isrepeat
    self.name = player_name
end

return NetKeyReleased
