local Physic = require "boom.components.physic.Physic"
local IsPlayer = require "boom.components.identifier.IsPlayer"
local Controllable = require "boom.components.control.Controllable"
local Tire = require "boom.components.vehicle_part.Tire"
local Turret = require "boom.components.vehicle_part.Turret"
local ShaderCircle = require("boom.components.graphic.ShaderCircle")
local ShaderPolygon = require("boom.components.graphic.ShaderPolygon")
local Light = require("boom.components.graphic.Light")
local GlobalEntityId = require("boom.components.identifier.GlobalEntityId")
local IsMyself = require("boom.components.identifier.IsMyself")
local PlayerName = require("boom.components.identifier.PlayerName")

-- player entity
local createPlayer = function(object, world, light_world, player_id, is_myself)
    local e = Entity()
    local o = object
    local sx, sy = o.x + o.width/2, o.y + o.height/2
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
    e:add(IsPlayer())
    e:add(Controllable())
    e:add(PlayerName(player_id or "unname"))
    if is_myself then
      e:add(IsMyself())
    end
    e:add(GlobalEntityId())
    tire.body:setUserData(e)
    return e
end
return createPlayer
