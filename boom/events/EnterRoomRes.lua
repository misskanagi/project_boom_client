local EnterRoomRes = class("EnterRoomRes")

function EnterRoomRes:initialize(responseCode, groupId, roomMasterId, playersInfo)
  self.responseCode = responseCode
  self.groupId = groupId
  self.roomMasterId = roomMasterId
  self.playersInfo = playersInfo
end

return EnterRoomRes