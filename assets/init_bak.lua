local class = require("libs.lovetoys.lib.middleclass")
local AssetsManager = class("AssetsManager")

function AssetsManager:initialize()
    self.images = {
      --particles
      particle_1 = love.graphics.newImage("assets/particles/1.png"),
      particle_2 = love.graphics.newImage("assets/particles/2.png"),
      particle_circle = love.graphics.newImage("assets/particles/circle.png"),
      particle_cloud = love.graphics.newImage("assets/particles/cloud.png"),
      particle_cross = love.graphics.newImage("assets/particles/cross.png"),
      particle_line2px = love.graphics.newImage("assets/particles/line2px.png"),
      particle_ps_earth = love.graphics.newImage("assets/particles/ps_earth.png"),
      particle_ps_mystic = love.graphics.newImage("assets/particles/ps_mystic.png"),
      particle_shockwave = love.graphics.newImage("assets/particles/shockwave.png"),
      particle_smoke = love.graphics.newImage("assets/particles/smoke.png"),
      particle_spark = love.graphics.newImage("assets/particles/spark.png"),
      particle_twirl = love.graphics.newImage("assets/particles/twirl.png"),
      particle_wisp = love.graphics.newImage("assets/particles/wisp.png"),
      particle_barrier = love.graphics.newImage("assets/particles/barrier.png"),
      --weapons
      landmine = love.graphics.newImage("assets/weapons/landmine.png"),
      --items
      item_landmine = love.graphics.newImage("assets/items/item_landmine.png"),
      item_shield = love.graphics.newImage("assets/items/item_shield.png"),
      item_booster = love.graphics.newImage("assets/items/item_booster.png"),
      item_adv_shell = love.graphics.newImage("assets/items/item_adv_shell.png"),
      item_bullet = love.graphics.newImage("assets/items/item_heal_shell.png"),
      item_health_box = love.graphics.newImage("assets/items/item_health_box.png"),
      item_heal_shell = love.graphics.newImage("assets/items/item_heal_shell.png"),
      item_normal_shell = love.graphics.newImage("assets/items/item_normal_shell.png"),
      item_nuclear_shell = love.graphics.newImage("assets/items/item_nuclear_shell.png"),
      item_sneak = love.graphics.newImage("assets/items/item_sneak.png"),
      item_wrench = love.graphics.newImage("assets/items/item_wrench.png"),
    }
end

function AssetsManager:instance()
    if AssetsManager.inst == nil then
        AssetsManager.inst = AssetsManager()
    end
    return AssetsManager.inst
end

return AssetsManager
