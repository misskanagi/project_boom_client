local GetRoomListRes = class("GetRoomListRes")

--roomsInfo是一个包含一组RoomInfo的数组
function GetRoomListRes:initialize(roomNumbers, roomsInfo)
  self.roomNumbers = roomNumbers
  self.roomsInfo = roomsInfo
end

return GetRoomListRes