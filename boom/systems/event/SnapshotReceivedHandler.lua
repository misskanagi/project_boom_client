local entity_manager = require "boom.entities"
local SnapshotReceivedHandler = class("SnapshotReceivedHandler", System)


function SnapshotReceivedHandler:fireSnapshotReceived(event)
    local roomId = event.roomId
    local snapshot_entities = event.entities
    for _, se in pairs(snapshot_entities) do
      local id = se.entityId
      local e = entity_manager.entity_list[id]
      -- update every body of this entity
      if e then
          for _, b in pairs(se.bodies) do
            local bodyId = b.bodyId
            --local x, y, r, vx, vy, va = b.x, b.y, b.rotation, b.vx, b.vy, b.va
            e:get("Physic").lerp = {}
            e:get("Physic").lerp[bodyId] = {
                x = b.x,
                y = b.y,
                r = b.rotation,
                vx = b.vx,
                vy = b.vy,
                va = b.va,
            }
          end
      end
    end
end

return SnapshotReceivedHandler
