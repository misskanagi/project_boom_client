-- 管理所有的weapon，包括每种weapon的参数，播放爆炸画面的函数
local anim8 = require("libs.anim8")

local grid_explode = anim8.newGrid(32,32, 64, 64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_explode = anim8.newAnimation(grid_explode(1,1, 1,2, 2,1), 0.1, "pauseAtEnd") --用于复制的一个模板anim
local image_explode = love.graphics.newImage("assets/explode.png")
-- 加载所有的武器的图像
local image_bullet0 = love.graphics.newImage("assets/raw/bullet0.png")
local image_fireball = love.graphics.newImage("assets/raw/fireball.png")
local image_missile = love.graphics.newImage("assets/raw/missile.png")
local image_landmine = love.graphics.newImage("assets/raw/landmine.png")
local image_missile2 = love.graphics.newImage("assets/raw/missile2.png")
-- 函数的前置声明
local weapon_kill
local bullet0_create, bullet0_update, bullet0_draw, bullet0_explode
local fireball_create, fireball_update, fireball_draw, fireball_explode
local missile_create, missile_update, missile_draw, missile_explode
local landmine_create, landmine_update, landmine_draw, landmine_explode

local weapon_store = {}
local metatable_weapon_store = {}
-- 为weapon创建默认值
metatable_weapon_store.__index = function(_, key)
  return weapon_store["bullet0"]
end
setmetatable(weapon_store, metatable_weapon_store)

weapon_store.explode_anims = {}  --武器的爆炸函数合集


--bullet0型子弹爆炸函数
bullet0_explode = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_explode:clone() --clone一份anim_explode

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      weapon_store.explode_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_explode, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(weapon_store.explode_anims, anim_item)
end

--bullet1型子弹爆炸函数
fireball_explode = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_explode:clone() --clone一份anim_explode

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      weapon_store.explode_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_explode, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(weapon_store.explode_anims, anim_item)
end


--missile型导弹爆炸函数
missile_explode = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_explode:clone() --clone一份anim_explode

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      weapon_store.explode_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_explode, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(weapon_store.explode_anims, anim_item)
end

--landmine型导弹爆炸函数
landmine_explode = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_explode:clone() --clone一份anim_explode

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      weapon_store.explode_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_explode, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(weapon_store.explode_anims, anim_item)
end

-- 创建一个bullet0的实例
bullet0_create = function(x, y, direction)
  weapon_info = weapon_store["bullet0"]  --武器库中的武器信息
  local obj = {}
  obj.type = "bullet0"
  obj.alive = true
  obj.width = weapon_info["sprite"]:getWidth()
  obj.height = weapon_info["sprite"]:getHeight()
  obj.direction = direction
  obj.colltype = "weapon"
  obj.owner_id = player_id

  if direction == "left" then
    obj.x = player.x - (player.width/2 + obj.width/2 + 2)
    obj.y = player.y
  elseif direction == "right" then
    obj.x = player.x + (player.width/2 + obj.width/2 + 2)
    obj.y = player.y
  elseif direction == "up" then
    obj.x = player.x
    obj.y = player.y - (player.height/2 + obj.height/2 + 2)
  elseif direction == "down" then
    obj.x = player.x
    obj.y = player.y + (player.height/2 + obj.height/2 + 2)
  end
  obj.alive = true
  obj.distance = weapon_info.distance

  --创建一个bullet0的碰撞体并赋予其匀速移动
  obj.body = love.physics.newBody(world, obj.x, obj.y, "dynamic")
  if obj.direction == "left" then
    obj.body:setLinearVelocity(-weapon_info.speed,0)
  elseif obj.direction == "right" then
    obj.body:setLinearVelocity(weapon_info.speed,0)
  elseif obj.direction == "up" then
    obj.body:setLinearVelocity(0,-weapon_info.speed)
  elseif obj.direction == "down" then
    obj.body:setLinearVelocity(0,weapon_info.speed)
  end

  obj.body:setFixedRotation(true)
  obj.shape = love.physics.newRectangleShape(0, 0, obj.width, obj.height)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 0)
  obj.fixture:setRestitution(0)
  obj.fixture:setUserData(obj)
  --设置obj的各种回调
  obj.update = bullet0_update
  obj.draw = bullet0_draw
  obj.kill = weapon_kill
  obj.explode = bullet0_explode
  return obj
end

bullet0_update = function(self, dt)
  weapon_info = weapon_store["bullet0"]
  if self.alive then
    self.x = self.body:getX()
    self.y = self.body:getY()
    self.distance = self.distance - weapon_info.speed * dt
    if self.distance <= 0 or self.alive == false then
      --该子弹已经到了射程, 毁灭它
      self.explode(self.x, self.y)  --爆炸！！
      self.alive = false
      self.body:destroy()
    end
  end
end

bullet0_draw = function(self)
  weapon_info = weapon_store["bullet0"]
  local rotate_table = {up = math.rad(0), left = math.rad(270), down = math.rad(180), right =math.rad(90)}
  if self.alive then
    love.graphics.draw(
      weapon_info.sprite,
      math.floor(self.x),
      math.floor(self.y),
      rotate_table[self.direction],
      1,
      1,
      self.width/2,
      self.height/2
    )
    if debug_on then
      love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
  end
end

weapon_kill = function(self)
  self.explode(self.x, self.y)  --爆炸！！
  self.alive = false
  self.body:destroy()
end

-- 创建一个bullet1的实例
fireball_create =  function(x, y, direction)
  weapon_info = weapon_store["fireball"]  --武器库中的武器信息
  local obj = {}
  obj.type = "fireball"
  obj.alive = true
  obj.width = weapon_info["sprite"]:getWidth()
  obj.height = weapon_info["sprite"]:getHeight()
  obj.direction = direction
  obj.colltype = "weapon"
  obj.owner_id = player_id

  if direction == "left" then
    obj.x = player.x - (player.width/2 + obj.width/2 + 2)
    obj.y = player.y
  elseif direction == "right" then
    obj.x = player.x + (player.width/2 + obj.width/2 + 2)
    obj.y = player.y
  elseif direction == "up" then
    obj.x = player.x
    obj.y = player.y - (player.height/2 + obj.height/2 + 2)
  elseif direction == "down" then
    obj.x = player.x
    obj.y = player.y + (player.height/2 + obj.height/2 + 2)
  end
  obj.alive = true
  obj.distance = weapon_info.distance

  --创建一个bullet1的碰撞体并赋予其匀速移动
  obj.body = love.physics.newBody(world, obj.x, obj.y, "dynamic")
  if obj.direction == "left" then
    obj.body:setLinearVelocity(-weapon_info.speed,0)
  elseif obj.direction == "right" then
    obj.body:setLinearVelocity(weapon_info.speed,0)
  elseif obj.direction == "up" then
    obj.body:setLinearVelocity(0,-weapon_info.speed)
  elseif obj.direction == "down" then
    obj.body:setLinearVelocity(0,weapon_info.speed)
  end

  obj.body:setFixedRotation(true)
  obj.shape = love.physics.newRectangleShape(0, 0, obj.width, obj.height)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 0)
  obj.fixture:setRestitution(0)
  obj.fixture:setUserData(obj)
  --设置obj的各种回调
  obj.update = fireball_update
  obj.draw = fireball_draw
  obj.kill = weapon_kill
  obj.explode = fireball_explode
  return obj
end

fireball_update = function(self, dt)
  weapon_info = weapon_store["fireball"]
  if self.alive then
    self.x = self.body:getX()
    self.y = self.body:getY()
    self.distance = self.distance - weapon_info.speed * dt
    if self.distance <= 0 or self.alive == false then
      --该子弹已经到了射程, 毁灭它
      self.explode(self.x, self.y)  --爆炸！！
      self.alive = false
      self.body:destroy()
    end
  end
end

fireball_draw = function(self)
  weapon_info = weapon_store["fireball"]
  local rotate_table = {up = math.rad(0), left = math.rad(270), down = math.rad(180), right =math.rad(90)}
  if self.alive then
    love.graphics.draw(
      weapon_info.sprite,
      math.floor(self.x),
      math.floor(self.y),
      rotate_table[self.direction],
      1,
      1,
      self.width/2,
      self.height/2
    )
    if debug_on then
      love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
  end
end

-- 创建一个missile的实例
missile_create =  function(x, y, direction)
  weapon_info = weapon_store["missile"]  --武器库中的武器信息
  local obj = {}
  obj.type = "missile"
  obj.alive = true
  obj.width = weapon_info["sprite"]:getWidth()
  obj.height = weapon_info["sprite"]:getHeight()
  obj.direction = direction
  obj.colltype = "weapon"
  obj.owner_id = player_id

  if direction == "left" then
    obj.x = player.x - (player.width/2 + obj.width/2 + 2)
    obj.y = player.y
  elseif direction == "right" then
    obj.x = player.x + (player.width/2 + obj.width/2 + 2)
    obj.y = player.y
  elseif direction == "up" then
    obj.x = player.x
    obj.y = player.y - (player.height/2 + obj.height/2 + 2)
  elseif direction == "down" then
    obj.x = player.x
    obj.y = player.y + (player.height/2 + obj.height/2 + 2)
  end
  obj.alive = true
  obj.distance = weapon_info.distance

  --创建一个missile的碰撞体并赋予其匀速移动
  obj.body = love.physics.newBody(world, obj.x, obj.y, "dynamic")
  if obj.direction == "left" then
    obj.body:setLinearVelocity(-weapon_info.speed,0)
  elseif obj.direction == "right" then
    obj.body:setLinearVelocity(weapon_info.speed,0)
  elseif obj.direction == "up" then
    obj.body:setLinearVelocity(0,-weapon_info.speed)
  elseif obj.direction == "down" then
    obj.body:setLinearVelocity(0,weapon_info.speed)
  end

  obj.body:setFixedRotation(true)
  obj.shape = love.physics.newRectangleShape(0, 0, obj.width, obj.height)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 0)
  obj.fixture:setRestitution(0)
  obj.fixture:setUserData(obj)
  --设置obj的各种回调
  obj.update = missile_update
  obj.draw = missile_draw
  obj.kill = weapon_kill
  obj.explode = missile_explode
  return obj
end

missile_update = function(self, dt)
  weapon_info = weapon_store["missile"]
  if self.alive then
    self.x = self.body:getX()
    self.y = self.body:getY()
    self.distance = self.distance - weapon_info.speed * dt
    if self.distance <= 0 or self.alive == false then
      --该子弹已经到了射程, 毁灭它
      self.explode(self.x, self.y)  --爆炸！！
      self.alive = false
      self.body:destroy()
    end
  end
end

missile_draw = function(self)
  weapon_info = weapon_store["missile"]
  local rotate_table = {up = math.rad(0), left = math.rad(270), down = math.rad(180), right =math.rad(90)}
  if self.alive then
    love.graphics.draw(
      weapon_info.sprite,
      math.floor(self.x),
      math.floor(self.y),
      rotate_table[self.direction],
      1,
      1,
      self.width/2,
      self.height/2
    )
    if debug_on then
      love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
  end
end

-- 创建一个landmine的实例
landmine_create =  function(x, y, direction)
  weapon_info = weapon_store["landmine"]  --武器库中的武器信息
  local obj = {}
  obj.type = "landmine"
  obj.alive = true
  obj.x = x
  obj.y = y
  obj.width = weapon_info["sprite"]:getWidth()
  obj.height = weapon_info["sprite"]:getHeight()
  obj.colltype = "weapon"
  obj.owner_id = player_id

  --创建一个missile的碰撞体并赋予其匀速移动
  obj.body = love.physics.newBody(world, obj.x, obj.y, "static")
  obj.body:setFixedRotation(true)
  obj.shape = love.physics.newRectangleShape(0, 0, obj.width, obj.height)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape, 0)
  obj.fixture:setRestitution(0)
  obj.fixture:setUserData(obj)
  --设置obj的各种回调
  obj.update = landmine_update
  obj.draw = landmine_draw
  obj.kill = weapon_kill
  obj.explode = landmine_explode
  return obj
end

landmine_update = function(self, dt)
  -- 地雷每一帧都不用变化，除了倒计时功能引入
end

landmine_draw = function(self)
  weapon_info = weapon_store["landmine"]
  if self.alive then
    love.graphics.draw(
      weapon_info.sprite,
      math.floor(self.x),
      math.floor(self.y),
      0,
      1,
      1,
      self.width/2,
      self.height/2
    )
    if debug_on then
      love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
  end
end

function weapon_store.update(self, dt)
  for k, v in pairs(self.explode_anims) do
    v:update(dt, k)
  end
end

function weapon_store.draw(self)
  for _, v in pairs(self.explode_anims) do
    v:draw()
  end
end

-- 武器库中的所有武器
weapon_store["bullet0"] = {["type"] = "bullet0", ["colltype"] = "weapon", ["sprite"] = image_bullet0, ["power"] = 10, ["speed"] = 1000, ["distance"] = 500,
                            ["create_instance"] = bullet0_create}
weapon_store["fireball"] = {["type"] = "fireball", ["colltype"] = "weapon", ["sprite"] = image_fireball, ["power"] = 15, ["speed"] = 1200, ["distance"] = 600,
                            ["create_instance"] = fireball_create}
weapon_store["missile"] = {["type"] = "missile", ["colltype"] = "weapon", ["sprite"] = image_missile, ["power"] = 30, ["speed"] = 800, ["distance"] = 800,
                            ["create_instance"] = missile_create}
weapon_store["landmine"] = {["type"] = "landmine", ["colltype"] = "weapon", ["sprite"] = image_landmine, ["power"] = 5,
                            ["create_instance"] = landmine_create}

return weapon_store
