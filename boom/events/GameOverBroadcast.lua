local GameOverBroadcast = class("GameOverBroadcast")

function GameOverBroadcast:initialize(roomId, winGroupId)
  self.roomId = roomId
  self.winGroupId = winGroupId
end

return GameOverBroadcast