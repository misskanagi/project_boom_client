local Player = require "boom.entities.Player"
local PlayerSpawner = require "boom.entities.PlayerSpawner"
local Barrier = require "boom.entities.Barrier"
local BarrierExplosive = require "boom.entities.BarrierExplosive"
local BarrierWreckage = require "boom.entities.BarrierWreckage"
local DefaultWreckage = require "boom.entities.DefaultWreckage"
local Light = require "boom.entities.Light"
local Sun = require "boom.entities.Sun"
local Wall = require "boom.entities.Wall"
local Water = require "boom.entities.Water"
local NormalShell = require "boom.entities.NormalShell"
local HealShell = require "boom.entities.HealShell"
local AdvancedShell = require "boom.entities.AdvancedShell"
local NuclearShell = require "boom.entities.NuclearShell"
local Landmine = require "boom.entities.Landmine"
local ItemManager = require "boom.entities.items"
local ItemSpawner = require "boom.entities.ItemSpawner"
local Group = require "boom.entities.Group"

local EntityManager = {}

function EntityManager:init(layer, map, world, shader)
  self.entity_list = {}
  self.layer = layer
  self.map = map
  self.world = world
  self.shader = shader
  ItemManager:init(layer, map, world, shader)
end

function EntityManager:removeEntityFromList(gid)
  self.entity_list[gid] = nil
end

function EntityManager:createEntity(type, ...)
  local args = {...}
  local e = nil
  local x, y, w, h, r = args[1], args[2], args[3], args[4], args[5]
  if type == "Player" or type == "player" then
    -- player need entity id from parameter!
    local player_id, is_myself, is_room_master, id, group_id = args[6], args[7], args[8], args[9], args[10]
    --print("_____!!!!!!!!!!group_id = "..group_id)
    e = Player(x, y, w, h, r, self.world, self.shader, player_id, is_myself, is_room_master, id, group_id)
  elseif type == "PlayerSpawner" or type == "playerspawner" then
    local player_id, is_myself, is_room_master, id = args[6], args[7], args[8], args[9]
    --print("_____!!!!!!!!!!group_id = "..group_id)
    e = PlayerSpawner(x, y, w, h, r, self.world, self.shader, player_id, is_myself, is_room_master, id)
  elseif type == "Barrier" or type == "barrier" then
    local object = args[1]
    e = Barrier(object, self.map, self.world, self.shader)
  elseif type == "BarrierWreckage" or type == "barrierwreckage" then
    e = BarrierWreckage(x, y)
  elseif type == "BarrierExplosive" or type == "barrierexplosive" then
    local object = args[1]
    e = BarrierExplosive(object, self.map, self.world, self.shader)
  elseif type == "BloodSpring" or type == "bloodspring" then
    e = ItemSpawner(x, y, w, h, r, {"BloodSpringItem"}, self.world, self.shader, 0.5, 255, 0, 0)
  elseif type == "DefaultWreckage" or type == "defaultwreckage" then
    e = DefaultWreckage(x, y)
  elseif type == "Light" or type == "light" then
    local r, g, b, range = args[6], args[7], args[8], args[9]
    e = Light(x, y, w, h, r, self.world, self.shader, r, g, b, range)
  elseif type == "Sun" or type == "sun" then
    e = Sun(self.map, self.shader)
  elseif type == "Wall" or type == "wall" then
    e = Wall(x, y, w, h, r, self.world, self.shader)
  elseif type == "Water" or type == "water" then
    e = Water(x, y, w, h, r, self.world, self.shader)
  elseif type == "NormalShell" or type == "normalshell" then
    local dmg, range = args[6], args[7]
    e = NormalShell(x, y, w, h, r, dmg, range, self.world, self.shader)
  elseif type == "Group" or type == "group" then
    local id, lives, players_info = args[1], args[2], args[3]
    e = Group(id, lives, players_info)
  elseif type == "HealShell" or type == "healshell" then
    local heal, range = args[6], args[7]
    --print("heal:"..heal..", range"..range)
    e = HealShell(x, y, w, h, r, heal, range, self.world, self.shader)
  elseif type == "AdvancedShell" or type == "advancedshell" then
    local dmg, range = args[6], args[7]
    e = AdvancedShell(x, y, w, h, r, dmg, range, self.world, self.shader)
  elseif type == "NuclearShell" or type == "nuclearshell" then
    local dmg, range = args[6], args[7]
    e = NuclearShell(x, y, w, h, r, dmg, range, self.world, self.shader)
  elseif type == "Landmine" or type == "landmine" then
    local dmg, range = args[6], args[7]
    e = Landmine(x, y, w, h, r, dmg, range, self.world, self.shader)
  elseif type == "ItemSpawner" or type == "itemspawner" then
    local item_list = args[6]
    e = ItemSpawner(x, y, w, h, r, item_list, self.world, self.shader)
  else
    e = ItemManager:createItem(type, ...)
  end
  if e and e:has("EntityId") then
    print(type)
    local gid = e:get("EntityId").id
    --print("gid = "..gid)
    self.entity_list[gid] = e
  end
  return e
end

return EntityManager
