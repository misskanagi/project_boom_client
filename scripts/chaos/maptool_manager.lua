-- 管理地图上，一轮轮产生的道具
local anim8 = require "libs/anim8"
local maptool_manager = {}

local lifetime = 5 --每个实例在地图上的存活寿命（s）
local twinkle_time = 3 --每个实例在剩3s时开始闪烁
local maptool_width = 32
local maptool_height = 32 --在地图上绘制的地图道具的尺寸
local instances = {} --当前存活着的实例
local maptool_flyspeed = 1000 --重发道具的移动速度
--[[
每个instance的kv：
k:  id : 全局统一
v:  {一组属性}
]]--
--加载maptool的图像/动画资源
local grid_twinkle = anim8.newGrid(32,32, 64, 64, 0, 0, 0) --frameW,frameH,imageW,imageH,left,top,border
local anim_twinkle = anim8.newAnimation(grid_twinkle(1,1, 1,2, 2,1), twinkle_time, "pauseAtEnd") --用于复制的一个模板anim
local image_twinkle = love.graphics.newImage("assets/explode.png")

--更新地图上的道具信息
--到最后时限播放道具闪烁的动画
--被打掉重发的道具计算移动后的新坐标（更新到x_old,y_old中，绘制也是绘制x_old,y_old），移动的速度是maptool_flyspeed.
function maptool_manager.update(dt)
  for tool_id, maptool_item in pairs(instances) do
    --在重发道具飞到新位置之前是不会计算其剩余时间的，
    if (maptool_item.x_old and maptool_item.y_old) and (maptool_item.x_old ~= maptool_item.x_new or maptool_item.y_old ~= maptool_item.y_new) then
      local fly_distance = dt * maptool_flyspeed
      --更新位置
      local distance2 = math.pow((maptool_item.x_new - maptool_item.x_old), 2) + math.pow((maptool_item.y_new - maptool_item.y_old), 2)
      local distance = math.sqrt(distance2)
      --distance按照xy轴上的距离差的比例分到xy轴上
      local abs_dvalue_x = math.abs(maptool_item.x_old - maptool.x_new)
      local abs_dvalue_y = math.abs(maptool_item.y_old - maptool.y_new)
      local fly_distance_x = (fly_distance / distance) * abs_dvalue_x
      local fly_distance_y = (fly_distance / distance) * abs_dvalue_y 
      if math.abs(maptool_item.x_old - maptool.x_new) <= fly_distance_x then
        maptool_item.x_old = maptool_item.x_new
      else
        if maptool_item.x_old > maptool_item.x_new then
          maptool_item.x_old = maptool_item.x_old - fly_distance_x
        else
          maptool_item.x_old = maptool_item.x_old + fly_distance_x
        end
      end
      if math.abs(maptool_item.y_old - maptool.y_new) <= fly_distance_y then
        maptool_item.y_old = maptool_item.y_new
      else
        if maptool_item.y_old > maptool_item.y_new then
          maptool_item.y_old = maptool_item.y_old - fly_distance_y
        else
          maptool_item.y_old = maptool_item.y_old + fly_distance_y
        end
      end
    else
      maptool_item["lifetime"] = maptool_item["lifetime"] - dt
      if maptool_item["lifetime"] <= 0 then
        maptool_manager.killInstance(tool_id)
      elseif maptool_item["lifetime"] <= twinkle_time then
        maptool_item["anim_twinkle"]:update(dt)
      end
    end
    
    
  end
end

--绘制到地图上
function maptool_manager.draw()
  for tool_id, maptool_item in pairs(instances) do
    -- 不同class的道具使用不同的颜色绘制，武器使用红色，道具使用白色，装备使用灰色
    local r,g,b,a = love.graphics.getColor()
    if maptool_item.class == "weapon" then
      --红色
      love.graphics.setColor(255,0,0,255)
    elseif maptool_item.class == "tool" then
      --白色
      love.graphics.setColor(255,0,0,255)
    else
      --灰色
      love.graphics.setColor(255,0,0,255)
    end
    
    if maptool_item.x_old and maptool_item.y_old then --绘制重发的道具
      if maptool_item["lifetime"] <= twinkle_time then
        --绘制闪烁动画
        maptool_item["anim_twinkle"]:draw(image_twinkle, maptool_item.x_old, maptool_item.y_old, 0, 1, 1, maptool_width/2, maptool_height/2)
      else
        --正常绘制图像
        love.graphics.rectangle("line", maptool_item.x_old, maptool_item.y_old, maptool_width, maptool_height)
      end
    else --绘制非重发的道具
      if maptool_item["lifetime"] <= twinkle_time then
        --绘制闪烁动画
        maptool_item["anim_twinkle"]:draw(image_twinkle, maptool_item.x_new, maptool_item.y_new, 0, 1, 1, maptool_width/2, maptool_height/2)
      else
        --正常绘制图像
        love.graphics.rectangle("line", maptool_item.x_new, maptool_item.y_new, maptool_width, maptool_height)
      end
    end
    love.graphics.setColor(r,g,b,a)
  end
end

--添加一波本地道具实例，为他们创建body。每一个实例的id和其他Client是统一的。
--tool_infos(table):
      --[[
        id:全局唯一，标识一个坦克
        class:"weapon"/"tool"/"fitting"
        type:class中的哪一个
        x_old,y_old:如果是道具重发的话，则存在x_old/y_old字段
        x_new,y_new:最终的位置
        lifetime:在地图上维持的时间
      ]]--
function maptool_manager.addInstances(tool_infos)
  for tool_id, info_item in pairs(tool_infos) do
    instances[tool_id] = {}
    instances[tool_id]["id"] = tool_id
    instances[tool_id]["class"] = info_item.class
    instances[tool_id]["type"] = info_item.type
    instances[tool_id]["x_old"] = info_item.x_old
    instances[tool_id]["y_old"] = info_item.y_old
    instances[tool_id]["x_new"] = info_item.x_new
    instances[tool_id]["y_new"] = info_item.y_new
    instances[tool_id]["body"] = love.physics.newBody(world, instances[tool_id]["x_new"], instances[tool_id]["y_new"], "static")
    local shape = love.physics.newRectangleShape(0, 0, maptool_width, maptool_height)
    local fixture = love.physics.newFixture(instances[tool_id]["body"], shape, 0) 
    fixture:setUserData(instances[tool_id])
    instances[tool_id]["colltype"] = "maptool"
    instances[tool_id]["lifetime"] = info_item.lifetime or lifetime
    instances[tool_id]["anim_twinkle"] = anim_twinkle:clone()
  end
end

--删除一个本地的地图道具实例
function maptool_manager.killInstance(tool_id)
  -- 销毁body，删除instances中的项
  if instances[tool_id] then
    instances[tool_id]["body"]:destroy()
    instances[tool_id] = nil --让GC去删
  end
end


return maptool_manager