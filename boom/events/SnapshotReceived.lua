local SnapshotReceived = class("SnapshotReceived")

function SnapshotReceived:initialize(roomId, entities)
    self.roomId = roomId
    self.entities = entities
end

return SnapshotReceived
