local SnapshotReceived = class("SnapshotReceived")

function SnapshotReceived:initialize(roomId, timeSnapshot, entities)
    self.roomId = roomId
    self.timeSnapshot = timeSnapshot
    self.entities = entities
end

return SnapshotReceived
