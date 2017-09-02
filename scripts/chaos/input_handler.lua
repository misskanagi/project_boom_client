--封装所有的输入操作
local weapon_store = require "./scripts/chaos/weapon_store"
local tool_store = require "./scripts/chaos/tool_store"
local cockpit = require "./scripts/chaos/cockpit"
local input_handler = {}
--前置声明
local move_up, move_right, move_down, move_right, fire, use_tool, change_weapon, change_tool, toggle_fullscreen, exit_fullscreen, release_direction_key, toggle_map, donothing, toggle_fix_eyeshot
local map_ps4_joystick
local eyeshot_fixed = false

--按键和操作之间的映射关系
local key_op_map = {}
key_op_map["up"] = "OP_UP"
key_op_map["left"] = "OP_LEFT"
key_op_map["right"] = "OP_RIGHT"
key_op_map["down"] = "OP_DOWN"
key_op_map["f"] = "OP_FIRE"
key_op_map["l"] = "OP_CHANGE_WEAPON"
key_op_map["r"] = "OP_CHANGE_TOOL"
key_op_map["x"] = "OP_USE_TOOL"
key_op_map["m"] = "OP_TOGGLE_MAP"
key_op_map["f1"] = "OP_ENTER_FULLSCREEN"
key_op_map["f2"] = "OP_EXIT_FULLSCREEN"
setmetatable(key_op_map, {["__index"] = function(_, key) return "OP_NIL" end})

-- 手柄按键和操作之间的映射关系
local joystick_op_map = {}
joystick_op_map["dpup"] = "OP_UP"
joystick_op_map["dpleft"] = "OP_LEFT"
joystick_op_map["dpright"] = "OP_RIGHT"
joystick_op_map["dpdown"] = "OP_DOWN"
joystick_op_map["leftshoulder"] = "OP_CHANGE_WEAPON"
joystick_op_map["rightshoulder"] = "OP_CHANGE_TOOL"
joystick_op_map["a"] = "OP_USE_TOOL"
joystick_op_map["b"] = "OP_FIRE"
joystick_op_map["x"] = "OP_TOGGLE_MAP"
joystick_op_map["y"] = "OP_NIL"
joystick_op_map["leftstick"] = "OP_NIL"
joystick_op_map["rightstick"] = "OP_TOGGLE_FIX_EYESHOT"
joystick_op_map["guide"] = "OP_TOGGLE_FULLSCREEN" --ps4 PS键
joystick_op_map["back"] = "OP_NIL" --ps4 SHARE键
joystick_op_map["start"] = "OP_NIL" -- ps4 OPTIONS键
setmetatable(joystick_op_map, {["__index"] = function(_, key) return "OP_NIL" end})
--

local joystick_mapped = false -- 未安装过。

map_ps4_joystick = function(joystick_guid)
  log.debug("map_ps4_joystick")
  love.joystick.setGamepadMapping(joystick_guid, "a", "button", 2)
  love.joystick.setGamepadMapping(joystick_guid, "b", "button", 3)
  love.joystick.setGamepadMapping(joystick_guid, "x", "button", 1)
  love.joystick.setGamepadMapping(joystick_guid, "y", "button", 4)
  love.joystick.setGamepadMapping(joystick_guid, "leftshoulder", "button", 5)--ps4 l1
  love.joystick.setGamepadMapping(joystick_guid, "rightshoulder", "button", 6) --ps4 r1
  love.joystick.setGamepadMapping(joystick_guid, "leftstick", "button", 11) --ps4 左摇杆按下
  love.joystick.setGamepadMapping(joystick_guid, "rightstick", "button", 12) --ps4 右摇杆按下
  love.joystick.setGamepadMapping(joystick_guid, "guide", "button", 13)  --ps4 PS键
  love.joystick.setGamepadMapping(joystick_guid, "back", "button", 9) --ps4 SHARE键
  love.joystick.setGamepadMapping(joystick_guid, "start", "button", 10)-- ps4 OPTIONS键
  love.joystick.setGamepadMapping(joystick_guid, "dpup", "hat", 1, "u")
  love.joystick.setGamepadMapping(joystick_guid, "dpdown", "hat", 1, "d")
  love.joystick.setGamepadMapping(joystick_guid, "dpleft", "hat", 1, "l")
  love.joystick.setGamepadMapping(joystick_guid, "dpright", "hat", 1, "r")
  joystick_mapped = true
end

--不同系统对应不同厂商的手柄guid有不同的函数映射
local JOYSTICK_INFO = {}
JOYSTICK_INFO["OS X"] = {["GUID"] = "4c05000000000000cc09000000000000", ["mapfunc"] = map_ps4_joystick, ["sticktype"] = "PS4"}
JOYSTICK_INFO["Windows"] = {["GUID"] = "4c05cc09000000000000504944564944", ["mapfunc"] = map_ps4_joystick, ["sticktype"] = "PS4"}

function input_handler.map_joystick(joystick)
  log.debug(joystick:getGUID())
  log.debug(love.system.getOS())
  -- 还未映射过ps4手柄
  local joystick_guid = joystick:getGUID()
  local system = love.system.getOS()
  if joystick_mapped == false then
    local map_func = JOYSTICK_INFO[system]["mapfunc"]
    map_func(joystick_guid)
  end
end

--仅用于input_handler.handle_joystick_axis_ops()的几个控制变量
local left_stick_used = false
local right_stick_used = false
local l2_used = false
local r2_used = false

function input_handler.handle_joystick_axis_ops(joystick)
  if joystick == nil then
    return
  end

  local leftx, lefty, rightx, l2, r2, righty = joystick:getAxes()
  --以防在joystick:getAxes()前拔出了手柄，此处要判断是否获取到了正确的axis值
  if (leftx==nil or lefty==nil or rightx==nil or righty==nil or l2==nil or r2==nil) then
    return
  end
  -- 先处理左摇杆的逻辑(-1是最左，1是最右)
  if leftx <= -0.7 then --左摇杆向左移动了
    move_left()
    left_stick_used = true
  elseif leftx >= 0.7 then
    move_right()
    left_stick_used = true
  elseif lefty <= -0.7 then --左摇杆向左移动了
    move_up()
    left_stick_used = true
  elseif lefty >= 0.7 then
    move_down()
    left_stick_used = true
  else
    --release_direction_key()
    if left_stick_used then
      left_stick_used = false
      release_direction_key()
    end
  end
  
  -- 处理右摇杆的逻辑（移动视野）
  if rightx <= -0.7 then --右摇杆向左移动了
    window_fade_x = window_fade_x + 2
    right_stick_used = true
  elseif rightx >= 0.7 then
    window_fade_x = window_fade_x - 2
    right_stick_used = true
  elseif righty <= -0.7 then --左摇杆向左移动了
    window_fade_y = window_fade_y + 2
    right_stick_used = true
  elseif righty >= 0.7 then
    window_fade_y = window_fade_y - 2
    right_stick_used = true
  else
    --此时此刻，右摇杆是松掉了的
    if eyeshot_fixed == false then
      --乍一松开右摇杆
      if right_stick_used then
        right_stick_used = false
      else --不是刚松开了，那就缓慢把视点调回正中
        if window_fade_x < -3 then
          window_fade_x = window_fade_x + 4
        elseif window_fade_x > 3 then
          window_fade_x = window_fade_x - 4
        else
          window_fade_x = 0
        end
        if window_fade_y < -3 then
          window_fade_y = window_fade_y + 4
        elseif window_fade_y > 3 then
          window_fade_y = window_fade_y - 4
        else
          window_fade_y = 0
        end
      end
    end
  end  --“当你在凝视深渊的时候，深渊也正在凝视着你。 --尼采”
  
  -- 处理l2的逻辑（目前想让它的功能是切歌）（松手-1，按下1）
  
  -- 处理r2的逻辑（目前想让它的功能是切歌）（松手-1，按下1）
  if r2_used then
    --必须松了手以后在按才能开火
    if r2 <= -0.7 then
      r2_used = false
    end
  else
    if r2 >= 0.7 then
      r2_used = true
      fire()
    end
  end
end

function input_handler.getop(key)
  return key_op_map[key]
end

-- 如果使用手柄操作，通过该函数获取键对应的操作
function input_handler.get_joystick_op(button)
  --gui:feedback(""..button)
  return joystick_op_map[button]
end

-- 以下是各种handler
move_up = function()
  player.direction = "up" -- 更新坦克方向
  player.is_keyboard_controlling = true
end

move_left = function()
  player.direction = "left" -- 更新坦克方向
  player.is_keyboard_controlling = true
end

move_right = function()
  player.direction = "right" -- 更新坦克方向
  player.is_keyboard_controlling = true
end

move_down = function()
  player.direction = "down" -- 更新坦克方向
  player.is_keyboard_controlling = true
end

-- 开火
fire = function()
  --创建一个子弹
  local current_weapon_item = player["weapons"][player.current_weapon_index]
  local weapon_type = current_weapon_item["type"]
  local weapon_count = current_weapon_item["count"]
  if weapon_count > 0 then
    local weapon_info = weapon_store[weapon_type]
    local weapon_obj = weapon_info.create_instance(player.x, player.y, player.direction)
    player.bullets[#player.bullets+1] = weapon_obj -- add the newly created bullet into the bullets.
    player["weapons"][player.current_weapon_index]["count"] = weapon_count - 1
  else
    --播放一个没有子弹的音效，“咔咔”声。
    gui:feedback("brother, no bullets....")
  end
end

--用道具
use_tool = function()
  if #player["tools"] == 0 then
    -- 没有道具
    gui:feedback("brother, no tools....")
    return
  end
  local current_tool_item = player["tools"][player.current_tool_index]
  local tool_type = current_tool_item["type"]
  local tool_count = current_tool_item["count"]
  if tool_count > 0 then
    if debug then
      gui:feedback("wow, you use a "..tool_type)
    end
    local tool_info = tool_store[tool_type]
    tool_info.apply()
    player["tools"][player.current_tool_index]["count"] = tool_count - 1
  else
    --播放一个没有道具的音效，“嘟嘟”声。
    gui:feedback("brother, no tools....")
  end
end

change_weapon = function()
  if #player.weapons ==  0 then
    return
  end
  player.current_weapon_index = player.current_weapon_index + 1
  if player.current_weapon_index == #player.weapons + 1 then
    player.current_weapon_index = 1
  end
end

change_tool = function()
  if #player.tools == 0 then
    return
  end
  player.current_tool_index = player.current_tool_index + 1
  if player.current_tool_index == #player.tools + 1 then
    player.current_tool_index = 1
  end
end

toggle_fullscreen = function()
  if love.window.getFullscreen() then
    love.window.setFullscreen(false)
    window_scale = 1
  else
    love.window.setFullscreen(true)
    window_scale = math.min(love.graphics.getWidth() / 1280, love.graphics.getHeight() / 720)
  end
  
end

release_direction_key = function()
  --如果释放了一个方向键，那么检查是否还有其他正在按着的方向键，如果有，那么更新方向。
  local op_directions = {["OP_UP"] = "up", ["OP_DOWN"] = "down", ["OP_LEFT"] = "left", ["OP_RIGHT"] = "right"}
  for key, op in pairs(key_op_map) do
    if op_directions[op] then
      if love.keyboard.isDown(key) then
        player.is_keyboard_controlling = true
        player.direction = op_directions[op]
        return
      end
    end
  end
  player.is_keyboard_controlling = false
end

-- 地图开关
toggle_map = function()
  if cockpit.showing_map then
    --收了地图
    cockpit.showing_map = false
  else
    --开开地图
    cockpit.showing_map = true
  end
end

--如果本身固定了视角，那么松开它；如果没有固定视角，那么固定它
toggle_fix_eyeshot = function()
  if eyeshot_fixed then eyeshot_fixed = false else eyeshot_fixed = true end
end

donothing = function()
end

-- 操作和handler的映射
input_handler["OP_UP"] = {["handle"] = move_up, ["post_handle"] = release_direction_key}
input_handler["OP_LEFT"] = {["handle"] = move_left, ["post_handle"] = release_direction_key}
input_handler["OP_RIGHT"] = {["handle"] = move_right, ["post_handle"] = release_direction_key}
input_handler["OP_DOWN"] = {["handle"] = move_down, ["post_handle"] = release_direction_key}
input_handler["OP_FIRE"] = {["handle"] = fire, ["post_handle"] = donothing}
input_handler["OP_USE_TOOL"] = {["handle"] = use_tool, ["post_handle"] = donothing}
input_handler["OP_CHANGE_WEAPON"] = {["handle"] = change_weapon, ["post_handle"] = donothing}
input_handler["OP_CHANGE_TOOL"] = {["handle"] = change_tool, ["post_handle"] = donothing}
input_handler["OP_TOGGLE_FULLSCREEN"] = {["handle"] = toggle_fullscreen, ["post_handle"] = donothing}
input_handler["OP_TOGGLE_MAP"] = {["handle"] = toggle_map, ["post_handle"] = donothing}
input_handler["OP_TOGGLE_FIX_EYESHOT"] = {["handle"] = toggle_fix_eyeshot, ["post_handle"] = donothing}
input_handler["OP_NIL"] = {["handle"] = donothing, ["post_handle"] = donothing}

local metatable_input_handler = {}
metatable_input_handler.__index = function(_, key)
  return input_handler["OP_NIL"]
end
setmetatable(input_handler, metatable_input_handler)
return input_handler
