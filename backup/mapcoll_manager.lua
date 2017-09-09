-- 管理地图上的地形块的碰撞
local anim8 = require("libs.anim8")

local mapcoll_manager = {}
local collidable_tile_objects = {} --以tile_gid为key，tile_obj为value
local spriteid_to_object = {} --以layer为key，每一项为一个table，它又是以sprite_id为key，object为value
local tile_gid_base = 1
local map, world, layerss
local layer_count = 1
-- 前置声明
local create_tiles_collision_of_layer, create_polygon_collision_of_layer, get_polygon_vertices
local brick_fade, grass_fade, snow_fade
local get_delay_call, inner_kill_tileobject

--加载各种地形消失的动画资源
--砖块
local grid_brick_fade = anim8.newGrid(32,32, 64, 64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_brick_fade = anim8.newAnimation(grid_brick_fade(1,1, 1,2, 2,1), 0.3, "pauseAtEnd") --用于复制的一个模板anim
local image_brick_fade = love.graphics.newImage("assets/explode.png")
--草皮
local grid_grass_fade = anim8.newGrid(32,32, 64, 64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_grass_fade = anim8.newAnimation(grid_brick_fade(1,1, 1,2, 2,1), 0.3, "pauseAtEnd") --用于复制的一个模板anim
local image_grass_fade = love.graphics.newImage("assets/explode.png")
--雪地
local grid_snow_fade = anim8.newGrid(32,32, 64, 64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_snow_fade = anim8.newAnimation(grid_brick_fade(1,1, 1,2, 2,1), 0.3, "pauseAtEnd") --用于复制的一个模板anim
local image_snow_fade = love.graphics.newImage("assets/explode.png")


local tilefade_anims = {} --所有需要播放的tile消失的动画
local delay_calls = {} --需要延后调用的函数，在update中调用
mapcoll_manager.tilefade_funcs = {}

--为layer中的每一个tile都创建一个碰撞体
create_tiles_collision_of_layer = function(world, layer)
  --collidable_tile_objects[layer] = {}
  spriteid_to_object[layer] = {}
  local colltype = layer["properties"]["colltype"]  --拿到层的colltype属性，这个属性会被赋给该层的每一个tile obj
  for i, tiles in pairs(layer.data) do
    for j, tile in pairs(tiles) do
      --local btype = map:getTilePropertiesById(tile.id)['btype']
      local x = j * tile.width + tile.offset.x
      local y = i * tile.height + tile.offset.y
      local width = tile.width
      local height = tile.height
      local tile_obj = {}
      tile_obj.tile = tile
      tile_obj.x = x - width/2
      tile_obj.y = y - height/2
      tile_obj.width = width
      tile_obj.height = height
      tile_obj.body = love.physics.newBody(world, tile_obj.x, tile_obj.y, "static")  --创建用于碰撞的肉体
      tile_obj.shape = love.physics.newRectangleShape(0, 0, width, height)
      tile_obj.fixture = love.physics.newFixture(tile_obj.body, tile_obj.shape)
      tile_obj.fixture:setUserData(tile_obj)
      tile_obj.colltype = colltype  --设置碰撞块的colltype
      tile_obj.layer = layer
      tile_obj.i = i
      tile_obj.j = j
      tile_obj.sprite_id = layer.sprite_id_table and layer.sprite_id_table[i][j] or 0
      spriteid_to_object[layer][tile_obj.sprite_id] = tile_obj --提供了由layer和sprite_id到tile object的查询能力
      tile_obj.tile_gid = tile_gid_base
      collidable_tile_objects[tile_gid_base] = tile_obj
      tile_gid_base = tile_gid_base + 1
      tile_obj.alive = true -- 表明这个tile object还没有被销毁
      if tile_obj.sprite_id == 0 then
        log.debug("shit,mmp")
      else
        log.debug("good,penny")
      end
    end
  end
end

-- 返回一个会被延时调用的function，这个function会被保存在delay_calls中随着mapcoll_manager的update函数被不断调用
get_delay_call = function(tile_object)
  -- 延迟处理火势蔓延
  local queue = {}  --创建一个待销毁草皮的队列
  --将tile_object加入队列
  queue[1] = tile_object
  local queue_head = 1
  local rest_time_bound = 0.02
  local rest_time = rest_time_bound
  -- 调用该函数时，返回true说明下一轮update还需要调用，火势还需要继续蔓延。
  return function(dt)
    rest_time = rest_time - dt
    if rest_time <= 0 then
      --时间到，开始销毁
      --从queue中取出队头对象，将其有效邻居对象都加入队列中，然后销毁队头，重置时间
      local head = queue[queue_head]
      if head then
        if head.alive == false then
          queue_head = queue_head + 1
          rest_time = rest_time_bound
          return true
        end
        --head一定是一个grass类型的tile object
        local i = head.i
        local j = head.j
        local layer = head.layer
        --上
        if layer.sprite_id_table[i-1] and layer.sprite_id_table[i-1][j] then
          local neighbour_sprite_id = layer.sprite_id_table[i-1][j]
          local neighbour_object = spriteid_to_object[layer][neighbour_sprite_id]
          if neighbour_object.colltype == "grass" then
            --加入队列尾部
            queue[#queue+1] = neighbour_object
          end
        end
        --下
        if layer.sprite_id_table[i+1] and layer.sprite_id_table[i+1][j] then
          local neighbour_sprite_id = layer.sprite_id_table[i+1][j]
          local neighbour_object = spriteid_to_object[layer][neighbour_sprite_id]
          if neighbour_object.colltype == "grass" then
            --加入队列尾部
            queue[#queue+1] = neighbour_object
          end
        end
        --左
        if layer.sprite_id_table[i] and layer.sprite_id_table[i][j-1] then
          local neighbour_sprite_id = layer.sprite_id_table[i][j-1]
          local neighbour_object = spriteid_to_object[layer][neighbour_sprite_id]
          if neighbour_object.colltype == "grass" then
            --加入队列尾部
            queue[#queue+1] = neighbour_object
          end
        end
        --右
        if layer.sprite_id_table[i] and layer.sprite_id_table[i][j+1] then
          local neighbour_sprite_id = layer.sprite_id_table[i][j+1]
          local neighbour_object = spriteid_to_object[layer][neighbour_sprite_id]
          if neighbour_object.colltype == "grass" then
            --加入队列尾部
            queue[#queue+1] = neighbour_object
          end
        end
        --上下左右如果有且是草皮，都已经进了队列。此时销毁head，更新closure中的变量。
        inner_kill_tileobject(head.tile_gid)
        queue_head = queue_head + 1
        rest_time = rest_time_bound
        return true
      else
        return false
      end
    end
  end
end

-- 让layer中sprite_id对应的tile obj消失的函数
function mapcoll_manager.kill_tileobject(tile_gid)
  if collidable_tile_objects[tile_gid] then
    local tile_object = collidable_tile_objects[tile_gid]
    -- 看一下走哪条路线
    -- 以下部分是延时火势蔓延的实现，封装到一个closure中
    if tile_object.colltype == "grass" then
      local delay_call = get_delay_call(tile_object)
      --添加delay_call到delay_calls
      delay_calls[#delay_calls+1] = delay_call
    else
      if tile_object.alive == false then
        return
      end
      tile_object.alive = false
      -- 碰撞体销毁
      tile_object.body:destroy()
      -- 播放专属于这个地形消失的动画
      local fade_func = mapcoll_manager.tilefade_funcs[tile_object.colltype]["fade_func"]
      fade_func(tile_object.x, tile_object.y)
      -- 在tileInstances中将这个一个tile_object删除即可
      local layer = tile_object.layer
      layer.sprite_id_table[tile_object.i][tile_object.j] = nil  --在layer的sprite_id_table中删除对应项
      local tile = tile_object.tile
      local tileset = tile.tileset
      local batch = layer["batches"][tileset]
      local quad = love.graphics.newQuad(0, 0, 32, 32,340,206)
      if tile_object.sprite_id ~= 0 then
        batch:set(tile_object.sprite_id, quad, -100000, -100000)  --把废弃的块图像替换成quad圈出的图像并且绘制到（-100000,-100000）处
      end
    end
  end
end

--专为火势蔓延而生
inner_kill_tileobject = function(tile_gid)
  if collidable_tile_objects[tile_gid] then
    local tile_object = collidable_tile_objects[tile_gid]
    if tile_object.alive == false then
      return
    end
    tile_object.alive = false
    -- 碰撞体销毁
    tile_object.body:destroy()
    -- 播放专属于这个地形消失的动画
    local fade_func = mapcoll_manager.tilefade_funcs[tile_object.colltype]["fade_func"]
    fade_func(tile_object.x, tile_object.y)
    -- 在tileInstances中将这个一个tile_object删除即可
    local layer = tile_object.layer
    layer.sprite_id_table[tile_object.i][tile_object.j] = nil  --在layer的sprite_id_table中删除对应项
    local tile = tile_object.tile
    local tileset = tile.tileset
    local batch = layer["batches"][tileset]
    local quad = love.graphics.newQuad(0, 0, 32, 32,340,206)
    if tile_object.sprite_id ~= 0 then
      batch:set(tile_object.sprite_id, quad, -100000, -100000)  --把废弃的块图像替换成quad圈出的图像并且绘制到（-100000,-100000）处
    end
  end
end


-- 获取一个对象层中的对边形对象（object）的所有多边形顶点。
get_polygon_vertices = function(object)
  local vertices = {}
  for _, vertex in ipairs(object.polyline) do
    table.insert(vertices, vertex.x)
    table.insert(vertices, vertex.y)
  end
  return vertices
end

--为layer中的每一个object都创建一个多边形的碰撞体
create_polygon_collision_of_layer = function(world, layer)
  local colltype = layer["properties"]["colltype"] or ""
  for _, object in ipairs(layer.objects) do
    -- object即一个多边形碰撞体
    local coll_obj = {}
    coll_obj.colltype = colltype
    if object.shape == "rectangle" then
      --创建一个矩形碰撞体
      coll_obj.shape = love.physics.newRectangleShape(object.x + math.floor(object.width/2), object.y + math.floor(object.height/2), object.width, object.height)
      coll_obj.body = love.physics.newBody(world, 0, 0, "static")
      coll_obj.body:setFixedRotation(true)
      coll_obj.fixture = love.physics.newFixture(coll_obj.body, coll_obj.shape, 0)
      coll_obj.fixture:setRestitution(0)
      coll_obj.fixture:setUserData(coll_obj)
    elseif object.shape == "polyline" then
      local coll_obj = {}
      coll_obj.shape = love.physics.newChainShape(true, unpack(vertices))
      coll_obj.body = love.physics.newBody(world, 0, 0, "static")
      --body:setFixedRotation(true)
      coll_obj.fixture = love.physics.newFixture(coll_obj.body, coll_obj.shape, 0)
      coll_obj.fixture:setRestitution(0)
      coll_obj.fixture:setUserData(coll_obj)
    end
  end
end

-- 地图已经通过sti加载，map_instance是地图对象的实例，world_instance是需要创建物理的world实例
mapcoll_manager.load = function(map_instance, world_instance)
  map = map_instance
  world = world_instance
  -- 为整个世界的边界创建4条lineshape的碰撞体
  local map_width = map_instance.width * map_instance.tilewidth
  local map_height = map_instance.height * map_instance.tileheight
  local world_body = love.physics.newBody(world, 0, 0, "static")
  local world_shape1 = love.physics.newEdgeShape( -10, -10, map_width + 20, -10)
  local world_shape2 = love.physics.newEdgeShape( -10, -10, -10, map_height + 20)
  local world_shape3 = love.physics.newEdgeShape( map_width + 20, -10, map_width + 20, map_height + 20)
  local world_shape4 = love.physics.newEdgeShape( -10, map_height + 20, map_width + 20, map_height + 20)
  love.physics.newFixture(world_body, world_shape1)
  love.physics.newFixture(world_body, world_shape2)
  love.physics.newFixture(world_body, world_shape3)
  love.physics.newFixture(world_body, world_shape4)
  -- 围栏已设
  layers = map_instance.layers --此时layers中有实际层数的2倍
  layer_count = #layers --layer_count中存放了实际的层数
  --地图已经加载，需要创建出地形的碰撞对象
  --[[
    1.遍历所有的图层，找出有collidable属性为true的层来
    2.在这些层中，
      a)属性type == "tilelayer"的layer都是需要对里面所有的tile创建出static body的
      b)属性type == "objectgroup"的layer，对立面的每一个object，直接创建出一个PolygonShape的static body来
    3.关于地形上的碰撞对象的管理，托管给mapcoll_manager
  ]]--

  for i = 1, layer_count do
    local current_layer = layers[i]
    if current_layer["properties"]["collidable"] then
      if current_layer["type"] == "tilelayer" then
        create_tiles_collision_of_layer(world_instance, current_layer)
      elseif current_layer["type"] == "objectgroup" then
        create_polygon_collision_of_layer(world_instance, current_layer)
      end
    end
  end
end

function mapcoll_manager.update(self, dt)
  for k, v in pairs(tilefade_anims) do
    v:update(dt, k)
  end
  for k, delay_call in pairs(delay_calls) do
    if delay_call(dt) == false then
      --这个delay_call已经燃烧殆尽了，可以删除了
      delay_calls[k] = nil
    end
  end
end

function mapcoll_manager.draw(self)
  for _, v in pairs(tilefade_anims) do
    v:draw()
  end
end

-- 为会消失的地形创建一波消失函数
-- 砖块消失
brick_fade = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_brick_fade:clone() --clone一份anim_brick_fade

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      tilefade_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_brick_fade, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(tilefade_anims, anim_item)
end

-- 草地消失
grass_fade = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_grass_fade:clone() --clone一份anim_grass_fade

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      tilefade_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_grass_fade, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(tilefade_anims, anim_item)
end

-- 雪地消失
snow_fade = function(x, y)
  local anim_item = {}
  anim_item.anim = anim_snow_fade:clone() --clone一份anim_snow_fade

  anim_item.update = function(self, dt, k)  -- k指的是在anims_to_play中的key
    if anim_item["anim"]:isPaused() == false then
      anim_item["anim"]:update(dt)
    else
      --此时anim_item已经没有存在的价值了
      tilefade_anims[k] = nil
    end
  end

  anim_item.draw = function(self)
    anim_item["anim"]:draw(image_snow_fade, x, y, 0, 1, 1, 16, 16)
  end

  table.insert(tilefade_anims, anim_item)
end

--
mapcoll_manager.tilefade_funcs["brick"] = {["type"] = "brick", ["fade_func"] = brick_fade}
mapcoll_manager.tilefade_funcs["grass"] = {["type"] = "grass", ["fade_func"] = grass_fade}
mapcoll_manager.tilefade_funcs["snow"] = {["type"] = "snow", ["fade_func"] = snow_fade}


return mapcoll_manager
