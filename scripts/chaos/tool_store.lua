-- 负责管理所有的道具的信息
local weapon_store = require "./scripts/chaos/weapon_store"

local tool_store = {}
--local函数的前置声明
local apply_hp_advance, apply_speed_advance, apply_invincible, apply_hiding, apply_onfire
--加载一波动画
local anim_hp_advance
local anim_speed_advance
local anim_invincible
local anim_hiding
local anim_onfire
tool_store.apply_anims = {}  --发动道具以后，要播放的动画
--记录player身上的buf的状态
local under_speed_advance = false
local under_invincible = false
local under_hiding = false
local under_onfire = false

--回血30点，可以快速重复使用，效果累加
apply_hp_advance = function()
  -- 加成到player上
  local hp_value = 30
  player.hp = math.min(player.hp + hp_value, tank_store[player.type]["hp_max"])
  -- 播放动画
end

--快速移动30点，持续2s，不可以多次使用叠加效果，快速多次使用只能更新效果剩余时间
apply_speed_advance = function()
  -- 加成到player上
  local speed_value = 100
  local time_bound = 10
  local time = time_bound
  local prev_speed = tank_store[player.type]["speed_max"]
  --为player添加一个buf，buf是一个closure.
  local buf_obj = function(dt, k)
    if under_speed_advance and time == time_bound then
      return
    end
    under_speed_advance = true -- 本buf_obj开始生效
    time = time - dt
    if time <= 0 then
      under_speed_advance = false
      -- 可以恢复使用本buf之前的player的状态了，并且删除player.bufs中的本项
      if debug_on then gui:feedback("resume player.speed to "..prev_speed) end
      player.speed = prev_speed
      table.remove(player.bufs, k)
      
    else
      -- 还没到点儿，buf依然有效
      player.speed = prev_speed + speed_value
      if debug_on then gui:feedback("player.speed is under buf :"..player.speed) end
    end
  end
  table.insert(player.bufs, buf_obj)
end

--无敌5s，不可以多次使用叠加效果，快速多次使用只能更新效果剩余时间
apply_invincible = function()
  -- 加成到player上
end

--隐身5s，快速多次使用能累加效果剩余时间
apply_hiding = function()
  -- 改变player的隐身属性
  local time_bound = 2
  local time = time_bound
  --为player添加一个buf，buf是一个closure.
  local buf_obj = function(dt, k)
    if under_hiding and time == time_bound then
      return
    end
    under_hiding = true -- 本buf_obj开始生效
    time = time - dt
    if time <= 0 then
      under_hiding = false
      -- 可以恢复使用本buf之前的player的状态了，并且删除player.bufs中的本项
      if debug_on then gui:feedback("resume player to visible.") end
      table.remove(player.bufs, k)
      player.status = "" --某一次update的轮回中，player的隐身状态暂时地解除了，这个工作能够成功与否依赖于<后>使用的buf在player.bufs的<后>面
    else
      -- 还没到点儿，buf依然有效
      player.status = "hiding"
      if debug_on then gui:feedback("player now is hiding. :)") end
    end
  end
  table.insert(player.bufs, buf_obj)
  --table.insert(player.bufs, #(player.bufs)+1, buf_obj)
end

--集中火力，不可以多次使用叠加效果，快速多次使用只能更新效果剩余时间
apply_onfire = function()
  -- 加成到player上
end


function tool_store.update(self, dt)
  --update anims_to_play_once中的动画
  for k, v in pairs(self.apply_anims) do
    v:update(dt, k)
  end
end

function tool_store.draw(self)
  --绘制anims_to_play_once中的动画
  for _, v in pairs(self.apply_anims) do
    v:draw()
  end
end

tool_store["hp_advance"] = {["type"] = "hp_advance", ["apply"] = apply_hp_advance} --回血
tool_store["speed_advance"] = {["type"] = "speed_advance", ["apply"] = apply_speed_advance} --快速移动
tool_store["invincible"] = {["type"] = "invincible", ["apply"] = apply_invincible} --无敌
tool_store["hiding"] = {["type"] = "hiding", ["apply"] = apply_hiding} --隐身
tool_store["onfire"] = {["type"] = "onfire", ["apply"] = apply_onfire} --集中火力

return tool_store