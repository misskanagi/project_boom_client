local entity_manager = require "boom.entities"
local SnapshotReceivedHandler = class("SnapshotReceivedHandler", System)

function SnapshotReceivedHandler:fireSnapshotReceived(event)
    local roomId = event.roomId
    local snapshot_entities = event.entities
    for _, se in pairs(snapshot_entities) do
      local id = se.entityId
      local e = entity_manager.entity_list[id]
      -- update every body of this entity
      for _, b in pairs(se.bodies) do
        local bodyId = b.bodyId
        local x, y, r, vx, vy, va = b.x, b.y, b.rotation, b.vx, b.vy, b.va
        local physic_body = e:get("Physic").bodies[bodyId]
        physic_body:setPosition(x, y)
        physic_body:setAngle(r)
        physic_body:setLinearVelocity(vx, vy)
        physic_body:setAngularVelocity(va)
      end
    end
end

return SnapshotReceivedHandler
