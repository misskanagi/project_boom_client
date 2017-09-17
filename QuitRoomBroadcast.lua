local QuitRoomBroadcast = class("QuitRoomBroadcast")

function QuitRoomBroadcast:initialize(isMaster, roomId, playerId)
  self.isMaster = isMaster
  self.roomId = roomId
  self.playerId = playerId
end

return QuitRoomBroadcast