local sti = require("libs//sti")
local gui = require "./libs/Gspot"
package.loaded["./libs/Gspot"] = nil
fire_freeze_time = 0 --at the very beginning, the player can shot right away!
collided = false
text = ""
angle1 = 0
angle2 = 0
layers = {}
static_zones = {}
local main = {}

--临时用这个函数，里面存在疑点。最烂的办法可以手动解析map.lua文件，然后将每一个块存起来。
function loadTiles(world, layer)
  for i, tiles in pairs(layer.data) do
    for j, tile in pairs(tiles) do
      --local btype = map:getTilePropertiesById(tile.id)['btype']
      local x = j * tile.width + tile.offset.x
      local y = i * tile.height + tile.offset.y
      local width = tile.width
      local height = tile.height
      local obj = {}
      obj.x = x - width/2
      obj.y = y - height/2
      obj.width = width
      obj.height = height
      obj.body = love.physics.newBody(world, obj.x, obj.y, "static")  --创建用于碰撞的肉体
      obj.shape = love.physics.newRectangleShape(0, 0, width, height)
      obj.fixture = love.physics.newFixture(obj.body, obj.shape)
      obj.fixture:setUserData(obj) 
      static_zones[obj] = true
    end
  end
end

--player_update是一个colsure
function get_player_update()
  return function(self, dt)
    if self.is_keyboard_controlling == false then
      self.x = self.body:getX()
      self.y = self.body:getY()
      return
    end
  
    for _, contact_tank in pairs(self.contactlist) do 
      if contact_tank.direction == self.direction then
        self.body:setLinearVelocity(0,0)
        return
      end
    end
    
    local current_speed = math.max(self.body:getLinearVelocity())

    if self.direction == "down" then
      self.body:applyLinearImpulse(0,200)
      --self.body:setLinearVelocity(0, self.speed)
    elseif self.direction == "up" then
      self.body:applyLinearImpulse(0,-200)
      --self.body:setLinearVelocity(0, -self.speed)
    elseif self.direction == "left" then
      self.body:applyLinearImpulse(-200,0)
      --self.body:setLinearVelocity(-self.speed, 0)
    elseif self.direction == "right" then
      self.body:applyLinearImpulse(200,0)
      --self.body:setLinearVelocity(self.speed, 0)
    end
  
    self.x = self.body:getX()
    self.y = self.body:getY()
  end
end



function love.load()
  screen_width = love.graphics.getWidth()
  screen_height = love.graphics.getHeight()
  map = sti("maps//mission3.lua")
  layers = map.layers
  
  world = love.physics.newWorld(0, 0, true) -- x_gravity, y_gravity, could sleep?
  --love.physics.setMeter(32)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  layer = map:addCustomLayer("Sprites", 4)
  -- 为water，blocks，iron三个层添加碰撞body
  layer_water = map.layers["water"]
  layer_blocks = map.layers["blocks"]
  layer_iron = map.layers["iron"]
  loadTiles(world,layer_water)
  loadTiles(world,layer_blocks)
  loadTiles(world,layer_iron)
  local player1, player2
  
  --实验：创建一个多边形的碰撞body
  poly = {}
  poly.body = love.physics.newBody(world, 0 , 0 , "static")
  poly.shape = love.physics.newChainShape(true, 2*32,3*32, 5*32,3*32, 5*32,9*32, 10*32,9*32, 10*32,10*32, 2*32,10*32)
  poly.fixture = love.physics.newFixture(poly.body, poly.shape)
  poly.fixture:setUserData(poly) 
  static_zones[poly] = true
  
  player1 = {}
  player1.sprite = love.graphics.newImage("assets/tank_blue_fire0.png")
  player1.direction = "up"
  player1.is_keyboard_controlling = false
  player1.x = 50
  player1.y = 50
  player1.speed = 450
  player1.width = player1.sprite:getWidth()
  player1.height = player1.sprite:getHeight()
  player1.ox = player1.sprite:getWidth()/2
  player1.oy = player1.sprite:getHeight()/2
  player1.body = love.physics.newBody(world, player1.x, player1.y, "dynamic")  --创建用于碰撞的肉体
  player1.body:setLinearVelocity(0,0)
  player1.body:setFixedRotation(true)
  player1.body:setLinearDamping(10)
  player1.shape = love.physics.newRectangleShape(0, 0, player1.width-2, player1.height-2)
  player1.fixture = love.physics.newFixture(player1.body, player1.shape, 10)
  player1.fixture:setRestitution(0.1)
  player1.fixture:setUserData(player1) 
  player1.contactlist = {}
  
  player1.update = get_player_update()
  
  
  player2 = {}
  player2.sprite = love.graphics.newImage("assets/tank_green_fire0.png")
  player2.is_keyboard_controlling = false
  player2.direction = "down"
  player2.x = 10
  player2.y = 10
  player2.speed = 400
  player2.width = player2.sprite:getWidth()
  player2.height = player2.sprite:getHeight()
  player2.ox = player2.sprite:getWidth()/2
  player2.oy = player2.sprite:getHeight()/2
  player2.body = love.physics.newBody(world, player2.x, player2.y, "dynamic")  --创建用于碰撞的肉体
  player2.body:setLinearVelocity(0,0)
  player2.body:setFixedRotation(true)
  player2.body:setLinearDamping(10)
  --player2.body:setAngularDamping(2^53)
  player2.shape = love.physics.newRectangleShape(0, 0, player2.width-2, player2.height-2)
  player2.fixture = love.physics.newFixture(player2.body, player2.shape, 20) 
  player2.fixture:setRestitution(0.1)
  player2.fixture:setUserData(player2) 
  player2.contactlist = {}  -- 某一项：player1 = {["direction"] = "left"}
  player2.update = get_player_update()
  
  layer.player1 = player1
  layer.player2 = player2

  -- Add controls to player
  layer.update = function(self, dt)
    self.player1:update(dt)
    self.player2:update(dt)
  end

  -- Draw player
  layer.draw = function(self)
    -- choose the rotation
    local rotate_table = {up = math.rad(0), left = math.rad(270), down = math.rad(180), right =math.rad(90)}
    love.graphics.draw(
        self.player1.sprite,
        self.player1.body:getX(),
        self.player1.body:getY(),
        rotate_table[self.player1.direction],
        1,
        1,
        self.player1.ox,
        self.player1.oy
    )
    love.graphics.draw(
        self.player2.sprite,
        self.player2.body:getX(),
        self.player2.body:getY(),
        rotate_table[self.player2.direction],
        1,
        1,
        self.player2.ox,
        self.player2.oy
    )
    love.graphics.polygon("line",self.player1.body:getWorldPoints(self.player1.shape:getPoints()))
    love.graphics.polygon("line",self.player2.body:getWorldPoints(self.player2.shape:getPoints()))
  end

end

function love.update(dt)
  gdt = dt
  world:update(dt)
  map:update(dt)
  --gui:update(dt)
end

function love.draw()
  
  local tx = math.floor(screen_width/2 - layer.player1.x)
  local ty = math.floor(screen_height/2 - layer.player1.y)
  --love.graphics.translate(tx, ty)
  map:draw(tx,ty)
  --gui:draw()
end



function love.keypressed( key, scancode, isrepeat )
  local direction_key1 = {w = "up", s = "down", a = "left", d = "right"}
  local direction_key2 = {up = "up", down = "down", left = "left", right = "right"}
  if direction_key1[key] then
    layer.player1.direction = direction_key1[key] -- change to new direction regardless of the current direction.
    layer.player1.is_keyboard_controlling = true
  end
  if direction_key2[key] then
    layer.player2.direction = direction_key2[key] -- change to new direction regardless of the current direction.
    layer.player2.is_keyboard_controlling = true
  end
end

function love.keyreleased( key, scancode, isrepeat )
  local direction_key1 = {w = "up", s = "down", a = "left", d = "right"}
  local direction_key2 = {up = "up", down = "down", left = "left", right = "right"}
  if direction_key1[key] then
    --release a direction key. Check whether there is a valid direction key is still pressed.
    for k, v in pairs(direction_key1) do
      if love.keyboard.isDown(k) then
        layer.player1.is_keyboard_controlling = true
        layer.player1.direction = v
        return
      end
    end
    layer.player1.is_keyboard_controlling = false
  end
  
  if direction_key2[key] then
    --release a direction key. Check whether there is a valid direction key is still pressed.
    for k, v in pairs(direction_key2) do
      if love.keyboard.isDown(k) then
        layer.player2.is_keyboard_controlling = true
        layer.player2.direction = v
        return
      end
    end
    layer.player2.is_keyboard_controlling = false
  end
end

local function get_collidate_direction(cx1, cy1, w1, h1, cx2, cy2, w2, h2)
  if w1+w2 - math.abs(cx1-cx2)*2 > h1+h2-math.abs(cy1-cy2)*2 then
    if cy1 < cy2 then
      return "down", "up"
    else 
      return "up", "down"
    end
  elseif w1+w2 - math.abs(cx1-cx2)*2 < h1+h2-math.abs(cy1-cy2)*2 then
    if cx1 < cx2 then
      return "right", "left"
    else
      return "left", "right"
    end
  else
    return nil, nil
  end
end

-- a和b是两个碰撞的对象，coll则是contact对象。
-- 当两个body产生重叠时，会触发该事件。beginContact->preSolve->postSolve->preSolve->postSolve->.....->endContact
function beginContact(a, b, coll)
  --gui:feedback("beginContact")
  local item_a = a:getUserData()
  local item_b = b:getUserData()
end

function endContact(a, b, coll)
  --gui:feedback("endContact")
  local item_a = a:getUserData()
  local item_b = b:getUserData()
  
end

-- 在碰撞检测之后调用，但是在碰撞冲突之前调用，可以通过contact:setEnabled(false)来禁用此碰撞冲突。
function preSolve(a, b, coll)
  local item_a = a:getUserData()
  local item_b = b:getUserData()
end

function postSolve(a, b, coll)
  --gui:feedback("postSolve")
end

return main
  