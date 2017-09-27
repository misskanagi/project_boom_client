local SnapshotReceived = class("SnapshotReceived")

function SnapshotReceived:initialize(roomId, masterPing, entities)
    self.roomId = roomId
    self.masterPing = masterPing
    self.entities = entities
end

return SnapshotReceived
