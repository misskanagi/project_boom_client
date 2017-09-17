local GameBeginBroadcast = class("GameBeginBroadcast")

function GameBeginBroadcast:initialize(roomId)
  self.roomId = roomId
end

return GameBeginBroadcast