gui = require "./libs/Gspot"
package.loaded["./libs/Gspot"] = nil
local anim8 = require "./libs/anim8"
local weapon_store = require "./scripts/chaos/weapon_store"
local input_handler = require "./scripts/chaos/input_handler"
local tank_manager = require "./scripts/chaos/tank_manager"
local cockpit = require "./scripts/chaos/cockpit"
local mapcoll_manager = require "./scripts/chaos/mapcoll_manager"
local maptool_manager = require "./scripts/chaos/maptool_manager"

local game = {}
local timer = 0 --在game中消耗的总时间（单位：s）
local tool_id_base = 1 --模拟发道具用
local tool_lasttime = 0

local first_time_to_update = true

--一些一定会有的对象
local map = nil
local layer_sprite = nil
local tanks = {} -- 所有tank，包括player在内
local tanks_update_info = {} --S端维护这一个所有tank的更新状态的字典。所谓的shared model
player = {}  --玩家操纵的tank对象
player_id = 2 --每一个Client都有唯一的一个id。
local game_thread = nil
local channel_tank = nil --channel_tank是发送最新的坦克数据的通道。
local channel_maptool = nil --channel_maptool是发送最新的道具数据的通道。
local channel_tilebreak = nil --channel_tilebreak是发送地形块对象毁坏信息的通道
local channel_control = nil --channel_control是发送游戏控制信息的通道，例如gamebegin/gameover
local initial_succeed = false --如果成功的掉用了game.load(initial_string)初始化了，那么就置true
debug_on = false
--gdt = dt
window_scale = 1 --屏幕缩放比
window_fade_x = 0 --玩家的tank不一定是正好在屏幕正中的，只需要设置这两个值即可
window_fade_y = 0
--fake
sprite_id_table = {}


-- 仅被调用一次，加载地图资源，精灵图资源，初始化各种对象。实现各种tank、player、layer_sprite的回调函数。
function game.load(initial_string)
  --创建一个可以使用physics的世界。
  world = love.physics.newWorld(0, 0, true) 
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  
  -- 刚刚进入战场，地图对象，其他Client的对象都还没有创建出来，此函数负责创建这些对象。initial_string中有创建这些对象所需的一切。
  log.trace("game.load(initial_string),\n   initial_string:"..initial_string)
  --解析initial_string，使用protobuf反序列化函数
  local obj_response = loadstring(initial_string)()
  map = obj_response[1]
  tanks_initial_table = obj_response[2] --所有其他的tank
  
  --扩充map对象和tanks对象
  local map_id = map["id"]
  local map_path = "maps/"..map_id..".lua"
  map = sti("maps/jungle1.lua")--,{"box2d"}) --把地图创建出来
  if map == nil then
    log.error("Failed to load the map.")
    love.window.close()
  end
  --map:box2d_init(world)

  -- 在地图上创建包含坦克和子弹的层
  layer_sprite = map:addCustomLayer("Sprites", #map.layers+1)  
  mapcoll_manager.load(map, world)
  tank_manager.load(tanks_initial_table)  --初始化所有的坦克
  layer_sprite.tanks = tank_manager.tanks
  
  --一些组件必须在layer_sprite.draw中进行绘制，这样才会有正确的坐标偏移和缩放
  layer_sprite.draw = function(self)
    weapon_store:draw() 
    tank_manager.draw()
    mapcoll_manager:draw()
    maptool_manager.draw()
  end
end


function game.update(dt)
  input_handler.handle_joystick_axis_ops(joystick1) --乱战模式一般只有一个主手柄
  timer = timer + dt
  -- 刚进入游戏战斗，从game_thread获取需要的数据
  if first_time_to_update then
    --专门开一个thread，用于源源不断地从Server处获取状态更新。
    game_thread = love.thread.newThread("scripts/chaos/game_thread.lua")
    channel_tank = love.thread.getChannel("channel_tank")  --channel_tank是获取最新的坦克数据的通道。
    channel_maptool = love.thread.getChannel("channel_maptool") --channel_maptool是获取最新的道具数据的通道。
    channel_tilebreak = love.thread.getChannel("channel_tilebreak") --channel_tilebreak是获取地形块对象毁坏信息的通道
    channel_control = love.thread.getChannel("channel_control") --channel_control是获取游戏控制信息的通道，例如gamebegin/gameover
    game_thread:start()
    first_time_to_update = false
  end
  
  if initial_succeed == false then
    -- S广播gamebegin + group信息，紧接着S广播所有的tank信息过来，有了这两个以后可以进行game.load
    -- 这里玩家需要等待channel_control的gamebegin信息
    local initial_string = channel_tank:pop()
    if initial_string then
      game.load(initial_string)
      initial_succeed = true
    end
  else
    -- 已经完成了game.load，常规update
    -- 从channel_control/channel_maptool/channel_tilebreak/channel_tank中获取更新的数据。
    local control_update = channel_control:pop()
    if control_update then
      
    end
    
    local maptool_update = channel_maptool:pop()
    if maptool_update then
      --maptool_manager.addInstances(maptool_update)
      --maptool_manager.update(dt)
    end
    
    local tilebreak_update = channel_tilebreak:pop()
    if tilebreak_update then
      -- tilebreak_update是一个table，key是tile_gid，
    end
    
    local tank_update = channel_tank:pop()
      --gui:feedback("tank_update")
    if tank_update then
      --tank_update是所有tank的更新信息合集table
      --tank_manager.update(tank_update, dt)
  
    end
    
    -- S广播所有的tanks的数据
    hotdata_tank = channel_tank:pop()
    if hotdata_tank ~= nil then
      -- 如果从channel_hotdata中获得了最新数据的话，将其解析出来，用于更新tanks的数据。
      log.debug("layer_sprite.update()! -hotdata_tank:"..hotdata_tank)
      local tanks_update_info = loadstring(hotdata_tank)()
      tank_manager.update(tanks_update_info, dt)
    end
    
    --S广播一轮地图道具的信息：{道具id+class（即是武器/道具/装备） + type + xy}
    hotdata_tool = channel_maptool:pop()
    if hotdata_tool ~= nil then
      log.debug("layer_sprite.update()! -hotdata_tool:"..hotdata_tool)
    end
    --------------------------------------------------
    -- 模拟一下每10s有一波新道具进来
    local classes = {"weapon","tool","fitting"}
    local types = {["weapon"] = {"bullet0","fireball","missile","landmine"},
                    ["tool"] = {"hp_advance","speed_advance","invincible","hiding","onfire"},
                    ["fitting"] = {"yueyadun","snowboard","sharkskin"}}
    
    if timer - tool_lasttime > 10 then
      --超过了时间间隔了
      local maptool_infos = {}
      for i = 1, 5 do
        local item = {}
        item.class = classes[math.random(1,3)]
        local choice_count = #(types[item.class])
        item.type = types[item.class][math.random(1, choice_count)]
        item.x_new = math.random(40, 500)
        item.y_new = math.random(40, 500)
        maptool_infos[tool_id_base] = item
        tool_id_base = tool_id_base + 1
      end
      maptool_manager.addInstances(maptool_infos)
      gui:feedback("!!!!!!")
      tool_lasttime = timer
    end
    
    weapon_store:update(dt)
    mapcoll_manager:update(dt)
    map:update(dt)
    maptool_manager.update(dt)
    world:update(dt)
    gui:update(dt)
  end
end

function game.draw()
  if initial_succeed then 
    local screen_width = love.graphics.getWidth() / window_scale
    local screen_height = love.graphics.getHeight() / window_scale
    -- Translate world so that player is always centred
    local tx = math.floor(screen_width / 2 - player.x)
    local ty = math.floor(screen_height / 2 - player.y)
    -- Draw world
    map:draw(tx + window_fade_x, ty + window_fade_y, window_scale, window_scale)
    if debug_on then
      --map:box2d_draw(tx + window_fade_x, ty + window_fade_y, window_scale, window_scale)
    end
    -- 绘制玩家的操作控制信息，如L/R控制的道具列表
    cockpit.draw()
    gui:draw()
    --love.graphics.print("position:"..(math.floor(player.x))..","..(math.floor(player.y)))
  end
  
end

-- 4个碰撞回调
function beginContact(a, b, coll) end

function endContact(a, b, coll) 
  item_a = a:getUserData()
  item_b = b:getUserData()
  -- 正常碰撞返回
  if item_a == nil or item_b == nil then
    return
  end
  
  if (item_a.colltype == "weapon" and item_b.colltype == "tank") or (item_a.colltype == "tank" and item_b.colltype == "weapon") then

  elseif (item_a.colltype == "weapon" and item_b.colltype == "weapon") then
    
  elseif (item_a.colltype == "tank" and item_b.colltype == "brick") or (item_a.colltype == "brick" and item_b.colltype == "tank") then
    
  elseif (item_a.colltype == "weapon" and item_b.colltype == "brick") or (item_a.colltype == "brick" and item_b.colltype == "weapon") then
   
  elseif (item_a.colltype == "tank" and item_b.colltype == "steel") or (item_a.colltype == "steel" and item_b.colltype == "tank") then
    
  elseif (item_a.colltype == "weapon" and item_b.colltype == "steel") or (item_a.colltype == "steel" and item_b.colltype == "weapon") then
    
  elseif (item_a.colltype == "tank" and item_b.colltype == "snow") or (item_a.colltype == "snow" and item_b.colltype == "tank") then
    -- 坦克上雪
    coll:setEnabled(false)
    if item_a.colltype == "tank" then
      --判断tank.fitting是否为滑雪板
      if item_a.fitting == "snowboard" then
        --恢复tank的速度
      else
        --恢复tank的阻尼
        item_a:set_damping(tank_store[item_a.type]["damping"])
      end
    else
      if item_b.fitting == "snowboard" then
        --恢复tank的速度
      else
        --恢复tank的阻尼
        item_b:set_damping(tank_store[item_b.type]["damping"])
      end
    end
  elseif (item_a.colltype == "weapon" and item_b.colltype == "snow") or (item_a.colltype == "snow" and item_b.colltype == "weapon") then
    
  elseif (item_a.colltype == "tank" and item_b.colltype == "grass") or (item_a.colltype == "grass" and item_b.colltype == "tank") then
    
  elseif (item_a.colltype == "weapon" and item_b.colltype == "grass") or (item_a.colltype == "grass" and item_b.colltype == "weapon") then
    
 
  elseif (item_a.colltype == "water" and item_b.colltype == "tank") or (item_a.colltype == "tank" and item_b.colltype == "water") then
  end
  
end

function preSolve(a, b, coll) 
  item_a = a:getUserData()
  item_b = b:getUserData()
  -- 正常碰撞返回
  if item_a == nil or item_b == nil then
    return
  end
  
  -- tank和地图上的发放的道具（武器/道具/装备）相碰撞
  if (item_a.colltype == "tank" and item_b.colltype == "maptool") or (item_a.colltype == "maptool" and item_b.colltype == "tank") then
    coll:setEnabled(false)
    -- 销毁道具的本地对象
    -- 判断tank是否是player，如果是player则向S报告playerid+道具id
    -- 如果tank不是player，则什么都不做
    if item_a.colltype == "tank" then
      maptool_manager.killInstance(item_b.id)
      if item_a.id == player_id then
        -- 向S汇报自己碰到了道具
        
      end
    else
      maptool_manager.killInstance(item_a.id)
      if item_b.id == player_id then
        -- 向S汇报自己碰到了道具
        
      end
    end
  elseif (item_a.colltype == "weapon" and item_b.colltype == "tank") or (item_a.colltype == "tank" and item_b.colltype == "weapon") then
    -- 坦克与子弹相撞。
    coll:setEnabled(false)
    -- 首先销毁子弹(是会发生爆炸的，每个Client自己绘制爆炸就行了)
    -- 判断是否是player的坦克，如果是的话则自己要执行扣血逻辑
    -- 如果不是player的坦克，那么什么也不做
    if item_a.colltype == "weapon" then
      if item_a.owner_id == item_b.id then
        --自己扔的武器不会伤害自己（还有队友！）
        return
      end
      item_a:kill()
      --item_b扣血逻辑
      item_b:hurt(weapon_store[item_a.type]["power"])
    else
      if item_b.owner_id == item_a.id then
        --自己扔的武器不会伤害自己（还有队友！）
        return
      end
      item_b:kill()
      --item_a扣血逻辑
      item_a:hurt(weapon_store[item_b.type]["power"])
    end
    
  elseif (item_a.colltype == "weapon" and item_b.colltype == "weapon") then
    -- 子弹与子弹交会，此时的实现是抵消，以后会考虑不同子弹相碰的具体情况
    item_a:kill()
    item_b:kill()
  elseif (item_a.colltype == "tank" and item_b.colltype == "brick") or (item_a.colltype == "brick" and item_b.colltype == "tank") then
    --gui:feedback("tank vs brick!")
  elseif (item_a.colltype == "weapon" and item_b.colltype == "brick") or (item_a.colltype == "brick" and item_b.colltype == "weapon") then
    coll:setEnabled(false)
    --首先销毁武器，判断是否是player的子弹，如果是的话，player向S汇报player_id + 地形块的tile_gid；如果不是的话，什么都不用做
    if item_a.colltype == "weapon" then
      item_a:kill()  --永别了武器，每个Client先都销毁了再说
      if item_a.owner_id == player_id then
        -- 是玩家发射出的子弹，向S汇报被打击的brick对象（tile_gid）
        mapcoll_manager.kill_tileobject(item_b.tile_gid)
        -- to S
        
      end
    else
      item_b:kill()
      if item_b.owner_id == player_id then
        mapcoll_manager.kill_tileobject(item_a.tile_gid)
        -- to S
        
      end
    end
  elseif (item_a.colltype == "tank" and item_b.colltype == "steel") or (item_a.colltype == "steel" and item_b.colltype == "tank") then
    
  elseif (item_a.colltype == "weapon" and item_b.colltype == "steel") or (item_a.colltype == "steel" and item_b.colltype == "weapon") then
    coll:setEnabled(false)
    if item_a.colltype == "weapon" then
      item_a:kill()
    else
      item_b:kill()
    end
  elseif (item_a.colltype == "tank" and item_b.colltype == "snow") or (item_a.colltype == "snow" and item_b.colltype == "tank") then
    -- 坦克上雪
    coll:setEnabled(false)
    if item_a.colltype == "tank" then
      --判断tank.fitting是否为滑雪板
      if item_a.fitting == "snowboard" then
        --tank的速度变快了
      else
        --tank的阻尼变小了
        item_a:set_damping(2)
      end
    else
      if item_b.fitting == "snowboard" then
        
      else
        --tank的阻尼变小了
        item_b:set_damping(2)
      end
    end
  elseif (item_a.colltype == "weapon" and item_b.colltype == "snow") or (item_a.colltype == "snow" and item_b.colltype == "weapon") then
    -- 子弹打在了雪上
    coll:setEnabled(false)
    --首先判断是否是fireball，如果是fireball的话，会毁掉一条线上的雪，但是fireball的射程也会受到影响
    --判断是否是player的子弹，如果是的话，player向S汇报player_id + 地形块的tile_gid；如果不是的话，什么都不用做
    if item_a.colltype == "weapon" then
      if item_a.type == "fireball" and item_a.owner_id == player_id then
        item_a.distance = item_a.distance - 50
        -- 是玩家发射出的子弹，向S汇报被打击的snow对象（tile_gid）
        mapcoll_manager.kill_tileobject(item_b.tile_gid)
        -- to S
        
      end
    else
      if item_b.type == "fireball" and item_b.owner_id == player_id then
        item_b.distance = item_b.distance - 50
        -- 是玩家发射出的子弹，向S汇报被打击的snow对象（tile_gid）
        mapcoll_manager.kill_tileobject(item_a.tile_gid)
        -- to S
        
      end
    end
  elseif (item_a.colltype == "tank" and item_b.colltype == "grass") or (item_a.colltype == "grass" and item_b.colltype == "tank") then
    -- 坦克上草
    coll:setEnabled(false)
  elseif (item_a.colltype == "weapon" and item_b.colltype == "grass") or (item_a.colltype == "grass" and item_b.colltype == "weapon") then
    -- 子弹打在了草上
    coll:setEnabled(false)
    --首先判断是否是fireball，如果是fireball的话，会毁掉一条线上的草，但是fireball的射程也会受到影响
    --判断是否是player的子弹，如果是的话，player向S汇报player_id + 地形块的tile_gid；如果不是的话，什么都不用做
    if item_a.colltype == "weapon" then
      if item_a.type == "fireball" and item_a.owner_id == player_id then
        item_a.distance = item_a.distance - 50
        -- 是玩家发射出的子弹，向S汇报被打击的grass对象（tile_gid）
        mapcoll_manager.kill_tileobject(item_b.tile_gid)
        -- to S
        
      end
    else
      if item_b.type == "fireball" and item_b.owner_id == player_id then
        item_b.distance = item_b.distance - 50
        -- 是玩家发射出的子弹，向S汇报被打击的grass对象（tile_gid）
        mapcoll_manager.kill_tileobject(item_a.tile_gid)
        -- to S
        
      end
    end
  elseif (item_a.colltype == "water" and item_b.colltype == "tank") or (item_a.colltype == "tank" and item_b.colltype == "water") then
    -- 坦克遇到了水，如果坦克有涉水fitting，那么可以通过.
    if item_a.colltype == "tank" then
      if item_a.fitting == "sharkskin" then
        coll:setEnabled(false)
      end
    else
      if item_b.fitting == "sharkskin" then
        coll:setEnabled(false)
      end
    end
  elseif (item_a.colltype == "water" and item_b.colltype == "weapon") or (item_a.colltype == "weapon" and item_b.colltype == "water") then
    coll:setEnabled(false)
  end
end



function postSolve(a, b, coll) end

function game.keypressed(key, scancode, isrepeat)
  log.debug("game.keypressed!")
  local op = input_handler.getop(key)
  input_handler[op].handle()
end

function game.keyreleased(key)
  local op = input_handler.getop(key)
  input_handler[op].post_handle()
end

function game.gamepadpressed(joystick, button)
  local op = input_handler.get_joystick_op(button)
  input_handler[op].handle()
end

function game.gamepadreleased(joystick, button)
  local op = input_handler.get_joystick_op(button)
  input_handler[op].post_handle()
end
return game