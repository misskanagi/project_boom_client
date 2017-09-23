local network = require("boom.network")
local timer = require("libs.hump.timer")
local SendPhysicSnapshot = class("SendPhysicSnapshot", System)

local elapsed = 0.0
local every = 0.033

function SendPhysicSnapshot:update(dt)
    elapsed = elapsed + dt
    if elapsed > every then
      elapsed = 0.0
      for _, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
          if e:get("IsRoomMaster") then
            self:sendSnapshot()
          end
          break
      end
    end
end

function SendPhysicSnapshot:sendSnapshot()
  local snapshot_entities = {}
  for k, entity in pairs(self.targets) do
    -- root body
    local body = entity:get("Physic").body
    if body:getType() == "dynamic" then
    --if entity:get("IsPlayer") then
      local snapshot_entity = {
        worldId = 1,
        entityId = entity:get("EntityId").id,
        status = 1,
        bodies = {},
      }
      for k, b in pairs(entity:get("Physic").bodies) do
        local x, y = b:getWorldCenter()
        local r = b:getAngle()
        local vx, vy = b:getLinearVelocity()
        local va = b:getAngularVelocity()
        local snapshot_body = {
          bodyId = k,
          x = x,
          y = y,
          rotation = r,
          vx = vx,
          vy = vy,
          va = va,
        }
        -- add body
        snapshot_entity.bodies[#snapshot_entity.bodies+1] = snapshot_body
      end
      -- add entity
      snapshot_entities[#snapshot_entities+1] = snapshot_entity
    end
  end
  if #snapshot_entities>0 then
    network:instance():sendSnapshot(snapshot_entities)
  end
end

function SendPhysicSnapshot:requires()
    return {"Physic", "EntityId"}
end

return SendPhysicSnapshot
