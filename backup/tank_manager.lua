-- 专门用于管理所有的tank对象以及坦克的参数
local anim8 = require("libs.anim8")
local weapon_store = require("boom.item.weapon_store")
local tool_store = require("boom.item.tool_store")

local tank_manager = {}

-- 加载一些资源
local image_tank_blue_run = love.graphics.newImage("assets/tank_blue_run.png")
local grid_tank_blue_run = anim8.newGrid(32,32, 128,64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_tank_blue_run = anim8.newAnimation(grid_tank_blue_run('1-4',1,'1-4',2), 0.2)
---
local image_tank_green_run = love.graphics.newImage("assets/tank_green_run.png")
local grid_tank_green_run = anim8.newGrid(32,32, 128,64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_tank_green_run = anim8.newAnimation(grid_tank_green_run('1-4',1,'1-4',2), 0.2)
--
local image_tombstone = love.graphics.newImage("assets/tombstone.jpg")

local tanks = {} -- 现在game中的所有tank对象集合
tank_store = {} --所有的坦克车型的参数集合，用type索引
tank_manager.tanks = tanks
tank_manager.tank_store = tank_store

-- 各种不同type的坦克的性能参数，不涉及具体对象的数值
-- 弹性暂时还没有引入tank性能
tank_store["tank_blue"] = {["type"] = "tank_blue", ["sprite"] = image_tank_blue_run, ["anim_run"] = anim_tank_blue_run, ["hp_max"] = 100, ["mass"] = 50, ["acceleration"] = 10,
                          ["damping"] = 20, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32}
tank_store["tank_green"] = {["type"] = "tank_green", ["sprite"] = image_tank_green_run, ["anim_run"] = anim_tank_green_run, ["hp_max"] = 100, ["mass"] = 50, ["acceleration"] = 10,
                          ["damping"] = 15, ["speed_max"] = 600, ["width"] = 32, ["height"] = 32}

--player的坦克更新函数
local player_update = function(self, dt)
  --这些是有待调整的。。。。
  -- 更新player的子弹数据
  if self.bullets then
    for k, bullet in ipairs(self.bullets) do
      bullet:update(dt)
    end
  end

  -- 需要注意的是，在这里就将player.bullets中alive为false的子弹剔除（直接简单粗暴地用GC）
  local _bullets_ = {}
  for _, bullet_item in ipairs(self.bullets) do
    if bullet_item.alive then
      _bullets_[#_bullets_ + 1] = bullet_item
    end
  end
  self.bullets = _bullets_
  _bullets_ = nil
  log.debug("bullets's count = "..(#self.bullets))
  -- player.bullets整理完毕

  if self.alive == false then
    goto update_tank_to_server
  end

  -- 调用所有的bufs
  for k,v in pairs(player.bufs) do
    v(dt, k)
  end

  if self.is_keyboard_controlling == false then
    self.x = self.body:getX()
    self.y = self.body:getY()
    self["anim_run"]:pauseAtStart()
    goto update_tank_to_server
  end

  do --这样创造出一个block，之前的goto语句不会jump into local对象的作用域中。
    self["anim_run"]:resume()
    local impluse = self.mass * self.acceleration * (1000 * dt)
    local speed_max = self.speed --玩家的当前速度
    local current_speed_x, current_speed_y = self.body:getLinearVelocity()
    if self.direction == "down" then
      if current_speed_y >= speed_max then
        self.body:setLinearVelocity(0, speed_max)
      else
        self.body:applyLinearImpulse(0, impluse)
      end
    elseif self.direction == "up" then
      if current_speed_y <= -speed_max then
        self.body:setLinearVelocity(0, -speed_max)
      else
        self.body:applyLinearImpulse(0, -impluse)
      end
    elseif self.direction == "left" then
      if current_speed_x <= -speed_max then
        self.body:setLinearVelocity(-speed_max, 0)
      else
        self.body:applyLinearImpulse(-impluse, 0)
      end
    elseif self.direction == "right" then
      if current_speed_x >= speed_max then
        self.body:setLinearVelocity(speed_max, 0)
      else
        self.body:applyLinearImpulse(impluse, 0)
      end
    end
    self.x = self.body:getX()
    self.y = self.body:getY()
    self["anim_run"]:update(dt)
  end

  --上传到Server用于同步。只有自己的tank是需要更新到Server的，其他care的东西，不存在的。
  ::update_tank_to_server:: do
    --gui:feedback("update_tank_to_server")
    --发送自己的tank信息到S
  end
end

--非player玩家的坦克更新函数
local tank_update = function(self, dt)
  if self.alive == false then
    return
  end
  self["anim_run"]:update(dt)
  self.body:setPosition(self.x, self.y)
end

--非player的坦克绘制
local tank_draw = function(self)
  local rotate_table = {up = math.rad(0), left = math.rad(270), down = math.rad(180), right = math.rad(90)}
  if self.alive == false then
    --判断是否这个坦克的剩余生命数已经是0，如果是的话，就画一个墓碑在对应xy
    if self.lifeleft and self.lifeleft == 0 then
      love.graphics.draw(image_tombstone, self.x, self.y)
    end
    return
  end

  -- 坦克是活着的。
  local tank_info = tank_store[self.type]
  --隐身状态
  if self.status == "hiding" then
    --什么都不画出来
  --鸡血模式
  elseif self.status == "onfire" then
    -- 绘制fitting
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    love.graphics.draw()
    -- 绘制血线
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  --无敌模式
  elseif self.status == "invincible" then
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  --重生中
  elseif self.status == "reborn" then
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  -- 正常状态
  else
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    -- 绘制血线
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  end

  -- 还要把挂在本坦克上的所有子弹给画好(因为地雷要在地面上，所以)
  if self.bullets then
    for _, bullet in pairs(self.bullets) do
      bullet:draw()
    end
  end

  -- 绘制伤害动画（被打中的时候身上会一隐一隐）
end

-- player的坦克的绘制函数
local player_draw = function(self)
  local rotate_table = {up = math.rad(0), left = math.rad(270), down = math.rad(180), right = math.rad(90)}

  if self.alive == false then
    -- 如果玩家已经阵亡
    return
  end

  -- 坦克是活着的。
  local tank_info = tank_store[self.type]
  --根据玩家的不同状态来绘制
  --隐身状态
  if self.status == "hiding" then
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 30)
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    love.graphics.setColor(r,g,b,a)
  --鸡血模式
  elseif self.status == "onfire" then
    -- 绘制fitting
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    love.graphics.draw()
    -- 绘制血线
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  --无敌模式
  elseif self.status == "invincible" then
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  --重生中
  elseif self.status == "reborn" then
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  -- 正常状态
  else
    self["anim_run"]:draw(tank_info.sprite, self.x, self.y, rotate_table[self.direction], 1, 1, tank_info.width/2, tank_info.height/2)
    -- 绘制血线
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 200)
    love.graphics.rectangle("line", self.x - 16, self.y - 30, 32, 5)
    --根据血量的多少来设置不同的颜色，分别是绿，黄，红
    if self.hp / tank_info.hp_max >= 2/3 then
      love.graphics.setColor(0, 255, 0, 200)
    elseif self.hp / tank_info.hp_max >= 1/3 then
      love.graphics.setColor(255, 255, 0, 200)
    else
      love.graphics.setColor(255, 0, 0, 200)
    end
    love.graphics.rectangle("fill", self.x - 15, self.y - 29, math.floor(32 * self.hp/tank_info.hp_max), 3)
    love.graphics.setColor(r,g,b,a)
  end

  -- 还要把挂在本坦克上的所有子弹给画好(因为地雷要在地面上，所以)
  if self.bullets then
    for _, bullet in pairs(self.bullets) do
      bullet:draw()
    end
  end

  -- 绘制伤害动画
end

local function tank_hurt(self, lose)
  self.hp = math.max(self.hp - lose, 0)
  if self.hp <= 0 then
    self:kill()
  end
end

local function tank_kill(self)
  -- 销毁body，直到服务器下一次重新产生一个新的tank_item的数据出来，重新创建新的tank_item放到tanks中去。
  self["alive"] = false
  self.body:destroy()
  -- 播放一个炸毁的动画
end

--设置tank对象的damping
local function set_damping(self, damping)
  self.body:setLinearDamping(damping)
end


-- 初始化所有的tanks
tank_manager.load = function(tanks_initial_table)
  -- 此时player的坦克也是混在里面的，注意把它挂到global player的引用上即可
  for k, init_item in pairs(tanks_initial_table) do
    local id = init_item.id -- id是tanks的索引
    local tank = {}
    setmetatable(tank, {["__index"] = {["colltype"] = "tank"} }) -- 默认值

    -- 只把和对象有关的动态属性赋予tanks中的对应项，而type对应的性能参数则无须重复拷贝了
    tank["id"] = id
    tank["type"] = init_item.type or "tank_blue"
    local tank_info = tank_store[init_item.type]
    tank["hp"] = init_item.hp or tank_info.hp_max

    tank["fitting"] = init_item.fitting --需要绘制用
    tank["bullets"] = {} -- 泛指所有已经打出去的武器，各种子弹/地雷
    tank["x"] = init_item.x or 32
    tank["y"] = init_item.y or 32
    tank["direction"] = init_item.direction
    local anim_run = tank_info.anim_run
    tank["anim_run"] = anim_run:clone()
    tank["alive"] = init_item.alive or true
    tank["width"] = tank_info.width
    tank["height"] = tank_info.height
    tank["speed"] = tank_info.speed_max

    -- 创建碰撞体
    tank.body = love.physics.newBody(world, init_item.x, init_item.y, "dynamic")
    tank.body:setLinearVelocity(0, 0)
    tank.body:setFixedRotation(true)
    tank.body:setLinearDamping(tank_info.damping)
    --tank.shape = love.physics.newRectangleShape(0, 0, tank_info.width, tank_info.height)
    tank.shape = love.physics.newPolygonShape( -16, -8, -16, 8, -8, 16, 8, 16, 16, 8, 16, -8, 8, -16, -8, -16 )
    tank.fixture = love.physics.newFixture(tank.body, tank.shape, tank_info.mass)
    tank.fixture:setRestitution(0) --弹性
    tank.fixture:setUserData(tank)
    -- 创建各种回调
    tank.update = ((id ~= player_id) and tank_update) or player_update
    tank.draw = ((id ~= player_id) and tank_draw) or player_draw
    tank.hurt = tank_hurt
    tank.kill = tank_kill
    tank.set_damping = set_damping
    -- 添加到tanks中。
    tanks[id] = tank
    if player_id == id then
       player = tanks[player_id]
      --加一点player独有的控制属性
      player.is_keyboard_controlling = false
      player["current_weapon_index"] = 1
      player["current_tool_index"] = 1
      player["weapons"] = init_item.weapons or {}
      player["tools"] = init_item.tools or {}
      player["mass"] = tank_info.mass
      player["acceleration"] = tank_info.acceleration
      player["hiding"] = false
      player["bufs"] = {} --   player时，依次调用一遍
    end
  end
end


tank_manager.update = function(tanks_update_table, dt)
  for k, update_item in pairs(tanks_update_table) do
    -- 从tanks_update_table中一条条抽出数据覆盖tanks的数据
    local tank_id = update_item["id"]
    -- 如果是非player的tank，才将数据拷贝到tanks中，如果是player的数据条，直接无视。
    if tank_id ~= player_id and tanks[tank_id] then
      -- 判断tank_id对应的坦克是否还活着。
      if update_item["alive"] == false then
        -- 更新的信息中该tank是挂了的，说明这个坦克已经跪了。
        tanks[tank_id]["alive"] = false
        tanks[tank_id]["x"] = update_item["x"]
        tanks[tank_id]["y"] = update_item["y"]  --可以每一个Client画一个墓碑在这儿。。。
        tanks[tank_id]["lifeleft"] = update_item["lifeleft"]
        tanks[tank_id]["type"] = update_item["type"] or tanks[tank_id]["type"]
      elseif tanks[tank_id]["alive"] == false then
        -- 更新的信息中，该tank是活着的，而本地保存的状态表明该tank挂了，说明此时要复活它
        -- 重新创建该tank_item
        tanks[tank_id]["alive"] = true
        local tank_info = tank_store[tanks[tank_id]["type"]] -- 获取当前车型信息
        tanks[tank_id]["hp"] = update_item["hp"]
        tanks[tank_id]["direction"] = update_item["direction"]
        tanks[tank_id]["x"] = update_item["x"]  -- S新分配的位置
        tanks[tank_id]["y"] = update_item["y"]  -- S新分配的位置
        tanks[tank_id]["type"] = update_item["type"] or tanks[tank_id]["type"]
        --重建碰撞体
        tanks[tank_id]["body"] = love.physics.newBody(world, update_item.x, update_item.y, "dynamic")  --创建用于碰撞的肉体
        tanks[tank_id]["body"]:setLinearVelocity(0, 0)
        tanks[tank_id]["body"]:setFixedRotation(true)
        tanks[tank_id]["body"]:setLinearDamping(tank_info.damping)
        local shape = love.physics.newRectangleShape(0, 0, tank_info.width, tank_info.height)
        local fixture = love.physics.newFixture(tanks[tank_id]["body"], shape, tank_info.mass)
        fixture:setRestitution(0)
        fixture:setUserData(tanks[tank_id])
        tanks[tank_id]["lifeleft"] = update_item["lifeleft"] --还剩几条命
        tanks[tank_id]["bullets"] = update_item["bullets"] --属于tank_id发出的子弹们
        tanks[tank_id]["fitting"] = update_item["fitting"]
        tanks[tank_id]["status"] = update_item["status"] -- 无敌，隐身，鸡血，重生
      else
        -- 坦克活着呢
        tanks[tank_id]["direction"] = update_item["direction"]
        tanks[tank_id]["x"] = update_item["x"]
        tanks[tank_id]["y"] = update_item["y"]
        tanks[tank_id]["hp"] = update_item["hp"]
        tanks[tank_id]["type"] = update_item["type"] or tanks[tank_id]["type"]
        tanks[tank_id]["bullets"] = update_item["bullets"]
        -- 更新hp/fitting情况，以供绘置
        tanks[tank_id]["fitting"] = update_item["fitting"]
        tanks[tank_id]["status"] = update_item["status"] -- 无敌，隐身，鸡血，重生
      end
      tanks[tank_id]:update(dt)

    elseif tank_id == player_id then
      if player["alive"] == false then
        -- 此时player是死了的，判断update_item中是否也是挂了的，如果是的话，player就彻底死了。。。。
        if update_item["alive"] == false then
          player["type"] = update_item.type or player["type"] --也许有彩蛋，阵亡后会绘制成特殊type的tank
          player["lifeleft"] = update_item.lifeleft or 0 -- 一条命都没有剩下
        else
          --player复活！
          player["x"] = update_item["x"]
          player["y"] = update_item["y"]
          player["direction"] = update_item["direction"]
          player["lifeleft"] = update_item["lifeleft"]
          player["status"] = update_item["status"] or "reborn"
          player["fitting"] = update_item["fitting"]
          player["type"] = update_item["type"] or player["type"]
          player["hp"] = update_item["hp"]
          player["alive"] = true
          -- bullets信息无须从S处同步，因为这个信息和tank本身存活与否没有关系的。例如player虽然挂了，但是他的landmine还是可以继续留下去的。
        end
      end
      player:update(dt)
    end
  end
end

function tank_manager.draw()
  for k, tank_item in pairs(tank_manager.tanks) do
    tank_item:draw()
    if debug and tank_item.alive then
      love.graphics.polygon("line", tank_item.body:getWorldPoints(tank_item.shape:getPoints()))
    end
  end
end


return tank_manager
