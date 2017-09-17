local EnterRoomBroadcast = class("EnterRoomBroadcast")

function EnterRoomBroadcast:initialize(roomId, playerId, groupId)
  self.roomId = roomId
  self.playerId = playerId
  self.groupId = groupId
end


return EnterRoomBroadcast