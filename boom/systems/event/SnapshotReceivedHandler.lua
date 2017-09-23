local entity_manager = require "boom.entities"
local SnapshotReceivedHandler = class("SnapshotReceivedHandler", System)

local function lerp(a, b, k) --smooth transitions
  if a == b then
    return a
  else
    if math.abs(a-b) < 0.05 then return b else return a * (1-k) + b * k end
  end
end

function SnapshotReceivedHandler:fireSnapshotReceived(event)
    local roomId = event.roomId
    local snapshot_entities = event.entities
    for _, se in pairs(snapshot_entities) do
      local id = se.entityId
      local e = entity_manager.entity_list[id]
      -- update every body of this entity
      if e then
          -- update health
          if e:has("Health") then
            e:get("Health").value = se.health
          end
          -- update launchable
          if e:has("Launchable") then
            e:get("Launchable").shell_name = se.shellName
            e:get("Launchable").shell_count = se.shellCount
          end
          -- update bodies
          for _, b in pairs(se.bodies) do
            local bodyId = b.bodyId
            local x, y, r, vx, vy, va = b.x, b.y, b.rotation, b.vx, b.vy, b.va
            local physic_body = e:get("Physic").bodies[bodyId]
            local ox, oy = physic_body:getWorldCenter()
            local oor = physic_body:getAngle()
            local ovx, ovy = physic_body:getLinearVelocity()
            local ova = physic_body:getAngularVelocity()
            local C = 0.5--math.random(100)/100
            physic_body:setPosition(lerp(ox, x, C), lerp(oy, y, C))
            physic_body:setAngle(lerp(oor, r, C))
            physic_body:setLinearVelocity(lerp(ovx, vx, C), lerp(ovy, vy, C))
            physic_body:setAngularVelocity(lerp(ova, va, C))
          end
      end
    end
end

return SnapshotReceivedHandler
