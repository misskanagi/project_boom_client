local GameReadyBroadcast = class("GameReadyBroadcast")

function GameReadyBroadcast:initialize(playerId, roomId, tankType)
  self.playerId = playerId
  self.roomId = roomId
  self.tankType = tankType
end

return GameReadyBroadcast