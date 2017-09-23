local NormalShellItem = require "boom.entities.items.NormalShellItem"
local BoosterItem = require "boom.entities.items.BoosterItem"
local HealShellItem = require "boom.entities.items.HealShellItem"
local LandmineItem = require "boom.entities.items.LandmineItem"
local AdvancedShellItem = require "boom.entities.items.AdvancedShellItem"
local HealthBoxItem = require "boom.entities.items.HealthBoxItem"
local NuclearShellItem = require "boom.entities.items.NuclearShellItem"

local ItemManager = {}

function ItemManager:init(layer, map, world, shader)
  self.layer = layer
  self.map = map
  self.world = world
  self.shader = shader
end

function ItemManager:createItem(type, ...)
  local args = {...}
  local e = nil
  local x, y, w, h, r = args[1], args[2], args[3], args[4], args[5]
  if type == "NormalShellItem" or type == "normalshellitem" then
    e = NormalShellItem(x, y, r, self.world, self.shader)
  elseif type == "BoosterItem" or type == "boosteritem" then
    e = BoosterItem(x, y, r, self.world, self.shader)
  elseif type == "HealShellItem" or type == "healshellitem" then
    e = HealShellItem(x, y, r, self.world, self.shader)
  elseif type == "LandmineItem" or type == "landmineitem" then
    e = LandmineItem(x, y, r, self.world, self.shader)
  elseif type == "AdvancedShellItem" or type == "advancedshellitem" then
    e = AdvancedShellItem(x, y, r, self.world, self.shader)
  elseif type == "HealthBoxItem" or type == "healthboxitem" then
    e = HealthBoxItem(x, y, r, self.world, self.shader)
  elseif type == "NuclearShellItem" or type == "nuclearshellitem" then
    e = NuclearShellItem(x, y, r, self.world, self.shader)
  end
  return e
end

return ItemManager
