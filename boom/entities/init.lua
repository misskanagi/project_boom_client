local Player = require "boom.entities.Player"
local Barrier = require "boom.entities.Barrier"
local Light = require "boom.entities.Light"
local Sun = require "boom.entities.Sun"
local Wall = require "boom.entities.Wall"

local EntityManager = {
  entity_list = {},
}

function EntityManager:createEntity(object, layer, map, ...)
  local args = {...}
  local type = object.properties["type"]
  local e = nil
  if type == "Player" or type == "player" then
    e = Player(object, ...)
  elseif type == "Barrier" or type == "barrier" then
    e = Barrier(object, map, ...)
  elseif type == "Light" or type == "light" then
    e = Light(object, ...)
  elseif type == "Sun" or type == "sun" then
    e = Sun(map, ...)
  elseif type == "Wall" or type == "wall" then
    e = Wall(object, ...)
  end
  if e then
    local gid = e:get("GlobalEntityId").id
    EntityManager.entity_list[gid] = e
  end
  return e
end

return EntityManager
