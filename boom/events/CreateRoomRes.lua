local CreateRoomRes = class("CreateRoomRes")

function CreateRoomRes:initialize(roomId, groupId)
  self.roomId = roomId
  self.groupId = groupId
end

return CreateRoomRes