--驾驶舱：LR，小地图
local weapon_store = require("boom.item.weapon_store")

local cockpit = {}
cockpit.showing_map = true
cockpit.map_width = 200
cockpit.map_height = 200
cockpit.lr_square_size = 50

--绘制出来
function cockpit.draw()
  local screen_width = love.graphics.getWidth()
  local screen_height = love.graphics.getHeight()

  local r,g,b,a = love.graphics.getColor()
  -- 绘制L键框
  -- 计算位置
  local square_size = cockpit.lr_square_size * window_scale
  local square_x = 10
  local square_y = 10
  local current_font = love.graphics.getFont()
  for i = 1, #player.weapons do
    -- 绘制square的背景，此处用白色
    love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle("fill", square_x, square_y, square_size, square_size)
    -- 绘制武器图片，(square_x,square_y)处
    local weapon_type = player["weapons"][i]["type"]
    local weapon_count = player["weapons"][i]["count"]
    local weapon_img = weapon_store[weapon_type]["sprite"]
    love.graphics.draw(weapon_img, square_x, square_y, 0, square_size/weapon_img:getWidth(), square_size/weapon_img:getHeight())
    --绘制武器剩余个数
    love.graphics.setColor(105,105,105,255)
    love.graphics.print(weapon_count, square_x + square_size - current_font:getWidth(weapon_count)*window_scale, square_y + square_size - current_font:getHeight(weapon_count)*window_scale,0,window_scale,window_scale)
    --印度红画框框喔
    love.graphics.setColor(205,92,92, 255)
    if i == player.current_weapon_index then
      -- 绘制一个选中的粗线框
      local prev_line_width = love.graphics.getLineWidth()
      love.graphics.setLineWidth(prev_line_width * 3)
      --绘制方框，(square_x,square_y)处
      love.graphics.rectangle("line", square_x, square_y, square_size, square_size)
      love.graphics.setLineWidth(prev_line_width)
    else
      love.graphics.rectangle("line", square_x, square_y, square_size, square_size)
    end
    -- 更新square_x, square_y
    square_x = square_x + square_size
  end

  -- 绘制R键框
  -- 计算位置
  local square_rx = screen_width - (3 * square_size + 10)
  for i = 1, #player.weapons do
    -- 绘制square的背景，此处用白色
    love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle("fill", square_rx, square_y, square_size, square_size)
    -- 绘制武器图片，(square_x,square_y)处
    local tool_type = player["tools"][i]["type"]
    local tool_count = player["tools"][i]["count"]
    --local tool_img = tool_store[tool_type]["sprite"]
    --love.graphics.draw(tool_img, square_rx, square_y, 0, square_size/tool_img:getWidth(), square_size/tool_img:getHeight())
    --绘制武器剩余个数
    love.graphics.setColor(105,105,105,255)
    love.graphics.print(tool_count, square_rx + square_size - current_font:getWidth(tool_count)*window_scale, square_y + square_size - current_font:getHeight(tool_count)*window_scale,0,window_scale,window_scale)
    --印度红画框框喔
    love.graphics.setColor(205,92,92, 255)
    if i == player.current_tool_index then
      -- 绘制一个选中的粗线框
      local prev_line_width = love.graphics.getLineWidth()
      love.graphics.setLineWidth(prev_line_width * 3)
      --绘制方框，(square_x,square_y)处
      love.graphics.rectangle("line", square_rx, square_y, square_size, square_size)
      love.graphics.setLineWidth(prev_line_width)
    else
      love.graphics.rectangle("line", square_rx, square_y, square_size, square_size)
    end
    -- 更新square_x, square_y
    square_rx = square_rx + square_size
  end
  love.graphics.setColor(r,g,b,a)

  -- 绘制小地图
  if cockpit.showing_map then
    local r,g,b,a = love.graphics.getColor()
    --计算出绘制位置

    local map_width = cockpit.map_width * window_scale
    local map_height = cockpit.map_height * window_scale
    local map_x = 10
    local map_y = screen_height - map_height - 10
    love.graphics.setColor(r,g,b,100)
    --开始绘制地图吧
    love.graphics.rectangle("fill", map_x, map_y, map_width, map_height)
    --绘制完成，记得还原画笔喔
    love.graphics.setColor(r,g,b,a)
  end
end

return cockpit
