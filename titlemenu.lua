-- title-menu.lua是进游戏的第一个菜单
networker = require "./scripts/chaos/networker"
local gui = require "./libs/Gspot"
--必须到package.loaded表中把"./libs/Gspot"为key的项删除，不然的话，其他文件中require "./libs/Gspot"会直接到package.loaded中先找，导致使用和这里gui同一个的对象
package.loaded["./libs/Gspot"] = nil  

local titlemenu = {}
local timer = 0  --在title_menu中消耗的总时间（单位：s）
local menu_items = {[1] = "button1", [2] = "button2", [3] = "button3"}
local menu_focous_index = 1 -- 默认焦点在第一个菜单按钮上
local ready = false -- 没有选中菜单项为false，选中菜单项为true
local target = 1

local first_time_to_update = true

local image_title = {}
local menu_item_storymode = {}
local menu_item_multimode = {}
local menu_item_other = {}
local menu = {}  --包含以上menu_item的一个menu
local button_storymode = nil
local button_multimode = nil
local button_other = nil

local menu_item_width = 0
local menu_item_height = 0
local menu_base_x = 0
local menu_base_y = 0
local menu_item_gapsize = 0

function titlemenu.load()
  gui.util.setfont(gui, "assets/font/fertigo_pro_regular.ttf", 32)
  -- 以下是一些控件的初始化以及回调实现
  image_title.image = love.graphics.newImage("assets//title_pic.jpg")
  image_title.width = (image_title.image):getWidth()
  image_title.height = (image_title.image):getHeight()
  image_title.x = math.floor((love.graphics.getWidth()-image_title.width)/2)
  image_title.y = 20
  image_title.draw = function (self)
    love.graphics.draw(self.image, self.x, self.y)
  end 
  
  
  menu_item_width = image_title.width
  menu_item_height = 60
  menu_base_x = math.floor((love.graphics.getWidth() - menu_item_width)/2)
  menu_base_y = image_title.height + image_title.y + 50
  menu_item_gapsize = 20
  button_storymode = gui:text("story mode", {x = menu_base_x, y = menu_base_y, w = menu_item_width, h = menu_item_height}, nil, false)
  button_multimode = gui:text("multi mode", {x = menu_base_x, y = menu_base_y + menu_item_height + menu_item_gapsize, w = menu_item_width, h = menu_item_height})
  button_other = gui:text("other", {x = menu_base_x, y = menu_base_y + (menu_item_height + menu_item_gapsize) * 2, w = menu_item_width, h = menu_item_height})
end


function titlemenu.update(dt)
  if first_time_to_update then
    titlemenu.load()
    first_time_to_update = false
  end
  
  gui:update(dt)
  timer = timer + dt
  if ready then
    if target == 2 then
      whereami = places["selectroom"] -- now start to play!
      ready = false
    end
  end
end

function titlemenu.draw()
  image_title:draw()
  gui:draw()
  -- 根据玩家的选项，绘制一个焦点框
  love.graphics.polygon("line", menu_base_x, menu_base_y + (menu_item_height+menu_item_gapsize) * (menu_focous_index-1),
                                menu_base_x + menu_item_width, menu_base_y + (menu_item_height+menu_item_gapsize) * (menu_focous_index-1), 
                                menu_base_x + menu_item_width, menu_base_y + (menu_item_height+menu_item_gapsize) * (menu_focous_index-1) + menu_item_height,
                                menu_base_x, menu_base_y + (menu_item_height+menu_item_gapsize) * (menu_focous_index-1) + menu_item_height)
end

function titlemenu.keypressed(key)
  if key == "up" then
    menu_focous_index = menu_focous_index - 1
    if menu_focous_index == 0 then
      menu_focous_index = 3
    end
  elseif key == "down" then
    menu_focous_index = menu_focous_index + 1
    if menu_focous_index == 4 then
      menu_focous_index = 1
    end
  end
  
  if key == "return" or key == "a" then
    -- 玩家确认了某一项
    ready = true
    target = menu_focous_index
  end
end

function titlemenu.keyreleased(key)
end

function titlemenu.mousepressed(x, y, button)
  log.debug("title_menu.mousepressed")
	gui:mousepress(x, y, button) -- pretty sure you want to register mouse events
end

function titlemenu.mousereleased(x, y, button)
	gui:mouserelease(x, y, button)
end

return titlemenu