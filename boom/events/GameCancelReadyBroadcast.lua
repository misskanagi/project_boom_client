local GameCancelReadyBroadcast = class("GameCancelReadyBroadcast")

function GameCancelReadyBroadcast:initialize(playerId, roomId)
  self.playerId = playerId
  self.roomId = roomId
end

return GameCancelReadyBroadcast