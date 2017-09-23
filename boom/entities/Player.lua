local Physic = require "boom.components.physic.Physic"
local CollisionCallbacks = require("boom.components.physic.CollisionCallbacks")

local IsPlayer = require "boom.components.identifier.IsPlayer"
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")
local IsMyself = require("boom.components.identifier.IsMyself")
local IsRoomMaster = require("boom.components.identifier.IsRoomMaster")
local PlayerName = require("boom.components.identifier.PlayerName")
local HasWreckage = require("boom.components.identifier.HasWreckage")

local Drivable = require "boom.components.control.Drivable"
local Firable = require "boom.components.control.Firable"
local Launchable = require "boom.components.control.Launchable"

local Tire = require "boom.components.vehicle.Tire"
local Turret = require "boom.components.vehicle.Turret"
local Booster = require("boom.components.vehicle.Booster")

local ShaderCircle = require("boom.components.graphic.ShaderCircle")
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")

local Health = require("boom.components.logic.Health")


-- player entity
local createPlayer = function(x, y, w, h, r, world, light_world, player_id, is_myself, is_room_master)
    local e = Entity()
    local sx, sy = x + w/2, y + h/2
    local tire = Tire(world, sx, sy)
    local turret = Turret(world, sx, sy)
    local cx, cy = tire.body:getWorldCenter()
    local revolute_joint = love.physics.newRevoluteJoint(
        tire.body, turret.body, cx, cy, false)
    e:add(tire)
    e:add(turret)
    e:add(Physic(tire.body, {turret.body}))
    t = light_world and e:add(ShaderPolygon(light_world, tire.body))
    sdt = light_world and e:add(Light(light_world, sx, sy, 4))
    e:get("Light").light:setAngle(math.pi/4)
    e:get("Light").light:setGlowStrength(1.0)
    e:add(HasWreckage("DefaultWreckage"))
    e:add(IsPlayer())
    e:add(Drivable())
    e:add(Firable(light_world))
    e:add(Launchable())
    e:add(PlayerName(player_id or "unname"))
    if is_myself then
      e:add(IsMyself())
    end
    if is_room_master then
      e:add(IsRoomMaster())
    end
    e:add(Health(100))
    e:add(GlobalEntityId())
    tire.body:setUserData(e)
    --[[add CollisionCallbacks
    e:add(CollisionCallbacks(
        function(other_entity, coll)
            print(other_entity:get("GlobalEntityId").id)
        end
    ))]]
    return e
end
return createPlayer
