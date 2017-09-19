-- 登陆游戏
local login = class("login")
local LoginNetHandler = class("LoginNetHandler", System)
local login_net_handler = LoginNetHandler()
local game_state = require("libs.hump.gamestate")
local bgimg = love.graphics.newImage("assets/bgimg.jpg")
local img_head = love.graphics.newImage("assets/magic.jpg")
local cam = require "boom.camera"
local camera = cam:instance()
local camera_shaking_interval = 1  --shake一次的时间长度
local camera_shaking_account = 0   --已经shake了多久
local camera_shaking = false
local camera_start_shake, camera_stop_shake, camera_update

local gui = require("libs.Gspot")
package.loaded["./libs/Gspot"] = nil
require "./libs/gooi"
local group_dl = 1 -- 驾驶证的控件group
local group_kb = 2 -- 小键盘的控件group
local keyboard_to_gamepad = {
  ["up"] = "dpup",
  ["down"] = "dpdown",
  ["left"] = "dpleft",
  ["right"] = "dpright",
  ["a"] = "b",
  ["b"] = "a"
}
--函数前置声明
local login_pressed, exit_pressed, enter_kb_psw, enter_kb_id, open_kb, close_kb, delete_char, processbar_login_update

--键盘控件
local keyboard_text, keyboard_label, btn_cancel, btn_delete, btn_confirm
--driving license控件
local text_id, text_psw, btn_exit, btn_login, label_head, processbar_login
--
local label_driving_license, label_id, label_psw, pOneLine, pBtnsLine, pGrid
--
local comps = {}

local lg = love.graphics
--所有的尺寸全都固定
local window_w = 480
local window_h = 320
local driving_liscense_x = 20
local driving_liscense_y = 80
local driving_license_w = 440
local driving_license_h = 160
local processbar_x = 20
local processbar_y = 280
local processbar_w = 440
local processbar_h = 10
local keyboard_x = 20
local keyboard_y = 60
local keyboard_w = 440
local keyboard_h = 180
local keyboard_text_x = 20
local keyboard_text_y = 20
local keyboard_text_w = 440
local keyboard_text_h = 30
local keyboard_btns_x = 20
local keyboard_btns_y = 260
local keyboard_btns_w = 440
local keyboard_btns_h = 30
local text = ""
local debug_on = false
local breath_loop_time = 1 --呼吸灯的时间长度
local breath_acc_time = breath_loop_time
local breath_sniff = false -- 是否是在吸气，吸气的话breath_acc_time递增

local login_success = false --已经成功登陆校验
local logining = false --是否正在登陆中
local login_feedback1 = false  --发出过了feedback否
local login_feedback2 = false
local login_feedback3 = false
local myId = nil
local got_login_response = false  --是否接收到Server的输入
--状态机
local states = {
  ["focous_id"] = {["dpdown"] = "focous_psw", ["b"] = "kb_id", ["exit_func"] = function() color = text_id.style.bgColor text_id:bg({color[1],color[2],color[3],0}) end},
  ["focous_psw"] = {["dpup"] = "focous_id", ["b"] = "kb_psw", ["dpdown"] = "focous_login", ["exit_func"] = function() color = text_psw.style.bgColor text_psw:bg({color[1],color[2],color[3],0}) end},
  ["focous_login"] = {["dpleft"] = "focous_exit", ["dpup"] = "focous_psw", ["b"] = "pressed_login", ["exit_func"] = function() btn_login:success() end},
  ["focous_exit"] = {["dpright"] = "focous_login", ["dpup"] = "focous_psw", ["b"] = "pressed_exit", ["exit_func"] = function() btn_exit:danger() end},
  ["kb_id"] = {["enter_func"] = function() enter_kb_id() end},
  ["kb_psw"] = {["enter_func"] = function() enter_kb_psw() end},
  ["pressed_login"] = {["enter_func"] = function() login_pressed() end},
  ["pressed_exit"] = {["enter_func"] = function() exit_pressed() end}
}
local current_state = "focous_id"


local keyboard_items = {[1] = {"0","1","2","3","4","5","6","7","8","9"},
  [2] = {"q","w","e","r","t","y","u","i","o","p"},
  [3] = {"a","s","d","f","g","h","j","k","l","."},
  [4] = {"z","x","c","v","b","n","m","_","?","!"}}
local keyboard_btns
--keyboard的光标时钟都要是闪烁着的！
current_kb_row = 1
current_kb_col = 1
local current_edit_text = ""
current_keyboard_state = "focous_text"
local sm_keyboard = {
  ["focous_text"] = {["dpdown"] = function()
      current_kb_row = 1
      current_keyboard_state = "focous_keyboard"
      local color = keyboard_text.style.bgColor
      keyboard_text:bg({color[1],color[2],color[3],50})
    end,
    ["dpleft"] = function()
      keyboard_text:moveLeft()
    end,
    ["dpright"] = function()
      keyboard_text:moveRight()
    end,
    ["dpup"] = function()
      current_kb_row = 4
      if current_kb_col < 4 then
        current_keyboard_state = "focous_btn_cancel"
      elseif current_kb_col < 8 then
        current_keyboard_state = "focous_btn_delete"
      else
        current_keyboard_state = "focous_btn_confirm"
      end
      local color = keyboard_text.style.bgColor
      keyboard_text:bg({color[1], color[2], color[3], 50})
    end,
    ["a"] = function() --删除
      keyboard_text:deleteBack()
      --current_edit_text的值从keyboard中重新扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end
  },
  ["focous_keyboard"] = {["dpleft"] = function()
      --消去当前的btn的呼吸灯效果
      local color = keyboard_btns[current_kb_row][current_kb_col].style.bgColor
      keyboard_btns[current_kb_row][current_kb_col]:bg({color[1],color[2],color[3],20})
      current_kb_col = current_kb_col - 1
      if current_kb_col == 0 then
        current_kb_col = 10
      end
    end,
    ["dpright"] = function()
      --消去当前的btn的呼吸灯效果
      keyboard_btns[current_kb_row][current_kb_col]:bg({255,255,255,20})
      current_kb_col = current_kb_col + 1
      if current_kb_col > 10 then
        current_kb_col = 1
      end
    end,
    ["dpup"] = function()
      --消去当前的btn的呼吸灯效果
      keyboard_btns[current_kb_row][current_kb_col]:bg({255,255,255,20})
      if current_kb_row == 1 then
        current_keyboard_state = "focous_text"
      else
        current_kb_row = current_kb_row - 1
      end
    end,
    ["dpdown"] = function()
      --消去当前的btn的呼吸灯效果
      keyboard_btns[current_kb_row][current_kb_col]:bg({255,255,255,20})
      if current_kb_row == 4 then
        if current_kb_col < 4 then
          current_keyboard_state = "focous_btn_cancel"
        elseif current_kb_col < 8 then
          current_keyboard_state = "focous_btn_delete"
        else
          current_keyboard_state = "focous_btn_confirm"
        end
      else
        current_kb_row = current_kb_row + 1
      end
    end,
    ["b"] = function()
      --选中了一个字符，
      local ch_got = keyboard_items[current_kb_row][current_kb_col]
      --设置到keyboard_text上
      keyboard_text:setText(ch_got)
      --更新current_edit_text的数据，从keyboard_text中扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end,
    ["a"] = function() --删除
      keyboard_text:deleteBack()
      --current_edit_text的值从keyboard中重新扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end

  },
  ["focous_btn_cancel"] = {["dpright"] = function()
      current_keyboard_state = "focous_btn_delete"
      btn_cancel:danger()
    end,
    ["dpup"] = function()
      current_keyboard_state = "focous_keyboard"
      btn_cancel:danger()
    end,
    ["dpdown"] = function()
      current_keyboard_state = "focous_text"
      btn_cancel:danger()
    end,
    ["b"] = function()
      --返回driving license界面
      close_kb()
      if current_state == "kb_id" then
        current_state = "focous_id"
      elseif current_state == "kb_psw" then
        current_state = "focous_psw"
      end
    end,
    ["a"] = function()
      keyboard_text:deleteBack()
      --current_edit_text的值从keyboard中重新扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end
  },
  ["focous_btn_delete"] = {["dpright"] = function()
      current_keyboard_state = "focous_btn_confirm"
      btn_delete:warning()
    end,
    ["dpleft"] = function()
      current_keyboard_state = "focous_btn_cancel"
      btn_delete:warning()
    end,
    ["dpup"] = function()
      current_keyboard_state = "focous_keyboard"
      btn_delete:warning()
    end,
    ["dpdown"] = function()
      current_keyboard_state = "focous_text"
      btn_delete:warning()
    end,
    ["b"] = function() --删除
      keyboard_text:deleteBack()
      --current_edit_text的值从keyboard中重新扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end,
    ["a"] = function() --删除
      keyboard_text:deleteBack()
      --current_edit_text的值从keyboard中重新扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end

  },
  ["focous_btn_confirm"] = {["dpleft"] = function()
      current_keyboard_state = "focous_btn_delete"
      btn_confirm:success()
    end,
    ["dpup"] = function()
      current_keyboard_state = "focous_keyboard"
      btn_confirm:success()
    end,
    ["dpdown"] = function()
      current_keyboard_state = "focous_text"
      btn_confirm:success()
    end,
    ["b"] = function()
      --确认输入的内容
      --直接返回driving license界面
      if current_state == "kb_id" then
        --current_edit_text中保存的即是需要设置到text_id上的内容
        text_id.indexCursor = #text_id.letters
        repeat
          text_id:deleteBack()
        until #text_id.letters == 0
        text_id:setText(current_edit_text)
        current_state = "focous_id"
      elseif current_state == "kb_psw" then
        --current_edit_text中保存的即是需要设置到text_id上的内容
        text_psw.indexCursor = #text_psw.letters
        repeat
          text_psw:deleteBack()
        until #text_psw.letters == 0
        text_psw:setText(current_edit_text)
        current_state = "focous_psw"
      end
      close_kb()
    end,
    ["a"] = function() --删除
      keyboard_text:deleteBack()
      --current_edit_text的值从keyboard中重新扒
      current_edit_text = ""
      for k, v in ipairs(keyboard_text.letters) do
        current_edit_text = current_edit_text..v.char
      end
    end
  }
}


--点击了登陆按钮以后的逻辑
login_pressed = function()
  --删除所有的component！
  --[[for k,v in pairs(comps) do
    gooi.removeComponent(v)
  end
  game_state.switch(roomlist,{["myId"] = "lsm"})]]--


  --实现登陆的逻辑
  local str_id = ""
  for k, v in ipairs(text_id.letters) do    --文本信息保存在了text_id的letters成员中，letters是个table，每一个项也是个table，其中char属性是真正的字符
    str_id = str_id..v.char
  end
  local str_psw = ""
  for k, v in ipairs(text_psw.letters) do    --文本信息保存在了text_id的letters成员中，letters是个table，每一个项也是个table，其中char属性是真正的字符
    str_psw = str_psw..v.char
  end
  --此时此刻，校验两个文本框中的内容是否都有了，如果有一个没有的话，那么提示用户需要输入
  if #str_id == 0 or #str_psw == 0 then
    --播放嘟嘟的音效
    --设置红框进行警示
    if #str_id == 0 then
      text_id:bg({255,0,0,100})
    end
    if #str_psw == 0 then
      text_psw:bg({255,0,0,100})
    end
    --切换状态
    if #str_id == 0 then
      current_state = "focous_id"
    else
      current_state = "focous_psw"
    end
    camera_start_shake(0.2 ,5)   --
  else
    --------------------------------------------------
    --本地的输入检查已经完成，将string name|string password发送到S  --str_id,str_psw交给Server
    myId = str_id
    processbar_login:increaseAt(0.2)
    logining = true  --进入正在登陆中的状态
    if not test_on_windows then
      net:requestLogin(str_id, str_psw)
    else
      --模拟一个通过情况
      --[[for k,v in pairs(comps) do
        gooi.removeComponent(v)
      end
      game_state.switch(roomlist,{["myId"] = "lsm"})]]--
      got_login_response = true
      login_success = true
    end
  end
end

--更新processbar_login_update的方法
processbar_login_update = function()
  local info1 = "Your information is checked."
  local info2 = "A country does not have permanent friends, or permanent enemies."
  local info3 = "Good luck."
  if processbar_login:getValue() >= 0.2 and not login_feedback1 then
    if not got_login_response then  --当没有获取到Server响应时先卡住
      --现在需要让进度条卡在0.2的位置，不再继续下去
      processbar_login:increaseAt(0)
    elseif login_success then  --获取了响应且成功了以后
      camera_start_shake(100, 3)
      gui:feedback(info1)
      login_feedback1 = true
      processbar_login:increaseAt(0.3)
    end
  elseif processbar_login:getValue() >= 0.49 and not login_feedback2 then
    gui:feedback(info2)
    login_feedback2 = true
  elseif processbar_login:getValue() >= 0.79 and not login_feedback3 then
    gui:feedback(info3)
    login_feedback3 = true
  elseif processbar_login:getValue() >= 1 then
    --进度条已经到达了，执行切换工作
    camera_stop_shake()
    local init_table = {}
    init_table["myId"] = myId
    game_state.switch(roomlist, init_table)
  end
end

function login:leave()
  --删除所有的component！
  for k,v in pairs(comps) do
    gooi.removeComponent(v)
  end
end

--点击了exit按钮以后的逻辑
exit_pressed = function()
  love.event.quit()
end

--打开小键盘的逻辑
open_kb = function(init_string)
  --设置keyboard_text中的内容
  if init_string then
    keyboard_text:setText(init_string)
  end
  --keyboard_text.showingCursor = true
  gooi.focused = keyboard_text   --设置焦点为keyboard_text
  keyboard_text.hasFocus = true  --让keyboard_text的光标能够update起来
  -- 恢复两个text_id和text_psw的外框颜色
  local color = text_id.style.bgColor
  text_id:bg({color[1],color[2],color[3],0})
  text_psw:bg({color[1],color[2],color[3],0})
end

--在退出键盘，返回时，需要将键盘的各种状态置回初始值
close_kb = function()
  keyboard_text:setText("")
  current_keyboard_state = "focous_text"
  current_kb_col = 1
  current_kb_row = 1
  --关闭所有呼吸灯
  local color = keyboard_text.style.bgColor
  keyboard_text:bg({color[1],color[2],color[3],100})
  keyboard_btns[current_kb_row][current_kb_col]:bg({255,255,255,20})
  btn_cancel:danger()
  btn_delete:warning()
  btn_confirm:success()
  --删除keyboard_text的所有字符
  keyboard_text.indexCursor = #keyboard_text.letters
  repeat
    keyboard_text:deleteBack()
  until #keyboard_text.letters == 0
end

--进入kb_id状态时的函数
enter_kb_id = function()
  -- 首先获取text_id中的值
  text = "enter_kb_id"
  current_edit_text = ""
  for k, v in ipairs(text_id.letters) do    --文本信息保存在了text_id的letters成员中，letters是个table，每一个项也是个table，其中char属性是真正的字符
    current_edit_text = current_edit_text..v.char
  end
  --text = str
  keyboard_text.inputtype = "cleartext"
  keyboard_label:setText("Id:")
  open_kb(current_edit_text)
end

--进入kb_psw状态时的函数
enter_kb_psw = function()
  text = "enter_kb_psw"
  current_edit_text = ""
  for k, v in ipairs(text_psw.letters) do    --文本信息保存在了text_psw的letters成员中，letters是个table，每一个项也是个table，其中char属性是真正的字符
    current_edit_text = current_edit_text..v.char
  end
  --text = str
  keyboard_text.inputtype = "ciphertext"
  keyboard_label:setText("Pd:")
  open_kb(current_edit_text)
end


--更新状态
states.update = function(dt)
  if breath_sniff then
    breath_acc_time = breath_acc_time + dt
    if breath_acc_time >= breath_loop_time then
      breath_acc_time = breath_loop_time
      breath_sniff = false
    end
  else
    breath_acc_time = breath_acc_time - dt
    if breath_acc_time <= 0 then
      breath_acc_time = 0
      breath_sniff = true
    end
  end

  if current_state == "focous_id" then
    local color = text_id.style.bgColor
    --text_id:bg({240, 173, 78,(breath_acc_time / breath_loop_time) * 180 + 75})
    text_id:bg({color[1],color[2],color[3],(breath_acc_time / breath_loop_time) * 180 + 75})
  elseif current_state == "focous_psw" then
    local color = text_psw.style.bgColor
    text_psw:bg({color[1],color[2],color[3],(breath_acc_time / breath_loop_time) * 180 + 75})
  elseif current_state == "focous_login" then
    btn_login:bg({92, 184, 92, (breath_acc_time / breath_loop_time) * 180 + 75}) --
  elseif current_state == "focous_exit" then
    btn_exit:bg({217, 83, 79, (breath_acc_time / breath_loop_time) * 180 + 75}) --
  elseif current_state == "kb_id" or current_state == "kb_psw" then
    --
    if current_keyboard_state == "focous_text" then
      local color = keyboard_text.style.bgColor
      keyboard_text:bg({color[1], color[2], color[3], (breath_acc_time / breath_loop_time) * 180 + 75})
    elseif current_keyboard_state == "focous_keyboard" then
      -- 找出current_kb_row,current_kb_col对应的btn
      if keyboard_btns and keyboard_btns[current_kb_row] then
        local keyboard_current_btn = keyboard_btns[current_kb_row][current_kb_col]
        local color = keyboard_current_btn.style.bgColor
        keyboard_current_btn:bg({color[1],color[2],color[3],20 + (breath_acc_time / breath_loop_time) * 50})
      end
    elseif current_keyboard_state == "focous_btn_cancel" then
      btn_cancel:bg({217, 83, 79, (breath_acc_time / breath_loop_time) * 180 + 75})
    elseif current_keyboard_state == "focous_btn_delete" then
      btn_delete:bg({240, 173, 78, (breath_acc_time / breath_loop_time) * 180 + 75})
    elseif current_keyboard_state == "focous_btn_confirm" then
      btn_confirm:bg({92, 184, 92, (breath_acc_time / breath_loop_time) * 180 + 75})
    end
  end
end

--通过手柄的键改变状态
states.transfer = function(button)
  if current_state == "kb_id" or current_state == "kb_psw" then
    -- 如果当前状态是在kb_id/kb_psw，那么所有按键操作都是在sm_keyboard这个状态机中产生效果
    local btn_func = sm_keyboard[current_keyboard_state][button]
    if btn_func then
      btn_func()
    end


  elseif states[current_state][button] then
    if states[current_state]["exit_func"] then
      states[current_state]["exit_func"]()
    end
    current_state = states[current_state][button] -- 切换状态，调整呼吸
    text = current_state
    --进入状态，先调用新状态的enter方法
    if states[current_state]["enter_func"] then
      states[current_state]["enter_func"]()
    end
    breath_sniff = false
    breath_acc_time = breath_loop_time
  end
end

function login:enter()
  if not test_on_windows then
    net:connect("192.168.1.101", 8080)
    --net:connect("172.28.37.19", 8080)
    --net:connect("114.212.83.208", 8080)
    net:startReceiving()
  end
  --注册事件监听函数
  print("login:enter()")
  gui:setOriginSize(window_w, window_h)    --不加这一个调用，scrollview会出问题
  eventmanager:addListener("LoginRes", login_net_handler, login_net_handler.fireLoginResEvent)
  --love.window.setMode(window_w, window_h)  --登陆窗口小小的
  --lg.setBackgroundColor(95, 158, 160) --skyblue
  --lg.setBackgroundColor()

  font_big = lg.newFont("assets/font/Arimo-Bold.ttf", 18)
  font_small = lg.newFont("assets/font/Arimo-Bold.ttf", 13)
  style = {
    font = font_small,
    radius = 5,
    innerRadius = 3,
    showBorder = true,
  }

  gooi.setStyle(style)
  gooi.desktopMode()

  gooi.shadow()
  --gooi.mode3d()
  --gooi.glass()

  lg.setDefaultFilter("nearest", "nearest")

  style.font = font_big
  label_driving_license = gooi.newLabel({text = "Driving License", x = 10, y = 20, w = window_w-20, h = 60, group = group_dl}):center()
  style.font = font_small
  -- grid layout
  pGrid = gooi.newPanel({x = driving_liscense_x, y = driving_liscense_y , w = driving_license_w, h = driving_license_h, layout = "grid 5x3"})
  pGrid
  :setRowspan(1, 1, 5) --头像
  :setColspan(2, 2, 2)
  :setColspan(4, 2, 2)
  --pGrid:fg(component.colors.blue)
  local img_bullet = lg.newImage("assets/sign_bullet.png")
  
  text_id = gooi.newText({w = 300, group = group_dl}):bg({209,209,209,0}):setText(""):setTooltip("please enter your honourable id :)") -- 输入id的文本框
  text_psw = gooi.newText({w = 300, group = group_dl, inputtype = "ciphertext"}):bg({209,209,209,0}):setText(""):setTooltip("please enter your powerful password :o"):fg({255,255,255,255}) -- 输入password的文本框
  label_id = gooi.newLabel({text = "enter your id:", group = group_dl}):left():setIcon(img_bullet)
  label_psw = gooi.newLabel({text = "enter your password:", group = group_dl}):left():setIcon(img_bullet)
  btn_exit = gooi.newButton({text = "Exit", group = group_dl}):center():inverted():danger():onRelease(exit_pressed)
  btn_login = gooi.newButton({text = "Login", group = group_dl}):center():inverted():success():onRelease(login_pressed)
  label_head = gooi.newLabel({text = "", group = group_dl}):bg({0, 0, 0}):setIcon(img_head)
  pGrid:add(label_id, "1,2")
  pGrid:add(text_id, "2,2")
  pGrid:add(label_psw, "3,2")
  pGrid:add(text_psw, "4,2")
  pGrid:add(btn_exit, "5,2")
  pGrid:add(btn_login, "5,3")
  pGrid:add(label_head, "1,1")
  pGrid.layout.debug = false
  --login的进度条
  processbar_login = gooi.newBar({x = processbar_x, y = processbar_y, w = processbar_w, h = processbar_h, value = 0, group = group_dl})
  :setRadius(0, 5)
  :bg({0,0,0,30})
  :fg({255, 255, 255, 255})

  ------------------
  --创建键盘控件
  pOneLine = gooi.newPanel({x = keyboard_text_x, y = keyboard_text_y, w = keyboard_text_w, h = keyboard_text_h, layout = "grid 1x11"})
  pOneLine:setColspan(1, 1, 2)
  pOneLine:setColspan(1, 3, 9)
  keyboard_text = gooi.newText({group = group_kb}):bg({209,209,209,50})
  --style.font = font_big
  keyboard_label = gooi.newLabel({text = "Enter:", group = group_kb}):left()
  --style.font = font_small
  pOneLine:add(keyboard_label, "1,1")
  :add(keyboard_text, "1,3")
  pKeyboard = gooi.newPanel({x = keyboard_x, y = keyboard_y , w = keyboard_w, h = keyboard_h, layout = "grid 4x10"})
  --创建10个数字，26个字母和4个特殊字符
  keyboard_btns = {}
  for row_id, line_item in ipairs(keyboard_items) do
    keyboard_btns[row_id] = {}
    for col_id, character_item in ipairs(line_item) do
      -- character_item就是对应的字符
      local btn_ch = gooi.newButton({text = character_item, group = group_kb}):center():bg({255,255,255,20})
      keyboard_btns[row_id][col_id] = btn_ch
      pKeyboard:add(btn_ch, row_id..","..col_id)
      table.insert(comps, btn_ch)
    end
  end


  pKeyboard.layout.debug = true
  pBtnsLine = gooi.newPanel({x = keyboard_btns_x, y = keyboard_btns_y, w = keyboard_btns_w, h = keyboard_btns_h, layout = "grid 1x3"})
  -- 放弃输入/删除字符/确认输入
  btn_cancel = gooi.newButton({text = "cancel", group = group_kb}):center():danger()
  btn_delete = gooi.newButton({text = "delete", group = group_kb}):center():warning()
  btn_confirm = gooi.newButton({text = "confirm", group = group_kb}):center():success()
  pBtnsLine:add(btn_cancel, "1,1")
  :add(btn_delete, "1,2")
  :add(btn_confirm, "1,3")


  --所有的控件添加到comps中，以方便以后切换到另一个场景的时候移除。
  table.insert(comps, login_pressed)
  table.insert(comps, keyboard_text)
  table.insert(comps, exit_pressed)
  table.insert(comps, enter_kb_psw)
  table.insert(comps, enter_kb_id)
  table.insert(comps, open_kb)
  table.insert(comps, close_kb)
  table.insert(comps, delete_char)
  table.insert(comps, keyboard_label)
  table.insert(comps, btn_cancel)
  table.insert(comps, btn_delete)
  table.insert(comps, btn_confirm)
  table.insert(comps, text_id)
  table.insert(comps, text_psw)
  table.insert(comps, btn_exit)
  table.insert(comps, btn_login)
  table.insert(comps, label_head)
  table.insert(comps, processbar_login)
  table.insert(comps, label_driving_license)
  table.insert(comps, label_id)
  table.insert(comps, label_psw)
  table.insert(comps, pOneLine)
  table.insert(comps, pBtnsLine)
  table.insert(comps, pGrid)

  -- camera operations

  --local zm = math.min(love.graphics.getWidth()/window_w, love.graphics.getHeight()/window_h)
  --camera:zoom(zm)
  camera:lookAt(window_w/2, window_h/2)
  --camera_start_shake(0.2, 5)
end

function login:update(dt)
  if logining then
    --检查channel是否有已经有了返回值，如果有，检查是否登陆成功
    if got_login_response then  --已经获取到了Server的响应
      if not login_success then
        --身份验证未通过 --登陆失败
        logining = false
        login_success = false
        got_login_response = false
        --log.debug("id:"..str_id..", psw:"..str_psw)
        --此时说明登陆失败，提示玩家登陆信息有误
        camera_start_shake(0.2, 5)
        text_id:bg({255,0,0,100})
        text_psw:bg({255,0,0,100})
        current_state = "focous_id"   --把焦点重新给到玩家的登陆信息输入框
        processbar_login.value = 0
        processbar_login:increaseAt(0)
      else
        --此时登陆已经成功了，但是不在此处进行场景切换，而是交给processbar的update函数
      end
    end
  end
  processbar_login_update(dt)
  states.update(dt)
  gooi.update(dt)
  gui:update(dt)
  if not test_on_windows then
    net:update(dt)
  end
  camera_update(dt)
end

function login:draw()
  --设置一个背景图片
  
  lg.draw(bgimg,0,0)
  camera:attach()


  --绘制一个矩形框将框内信息框住
  if current_state == "kb_id" or current_state == "kb_psw" then
    local r,g,b,a = lg.getColor()
    lg.setColor(0, 0, 0, 127)
    lg.rectangle("fill", 0, 0, window_w, window_h)
    gooi.draw(group_kb)
    lg.setColor(r,g,b,a)
  else
    local r,g,b,a = lg.getColor()
    lg.setColor(0, 0, 0, 127)
    lg.rectangle("fill", 0, 0, window_w, window_h)
    lg.setColor(0, 0, 0, 127)
    lg.rectangle("fill", 10, 20, window_w-20, 60)
    lg.setColor(0, 0, 0, 60)
    lg.rectangle("fill", 10, 80, window_w-20, 170)
    lg.rectangle("line", 10, 20, window_w-20, window_h-90)
    lg.setColor(r,g,b,a)
    --statemachine的当前状态决定了控件的外观，例如焦点的呼吸灯
    gooi.draw(group_dl)
    gui:draw()
  end
  --
  camera:detach()

  if debug_on then lg.print(text) end
end

function login:keypressed(key, scancode)
  local button = keyboard_to_gamepad[key]
  states.transfer(button)
end


function login:keyreleased(key)
end

function login:textinput(text)
  --gooi.textinput(text)
end

function login:gamepadpressed(joystick, button)
  -- 此处直接处理所有的手柄操作
  states.transfer(button)
end

function login:gamepadreleased(joystick, button)

end

--处理接收到网络的LoginRes以后的事件
function LoginNetHandler:fireLoginResEvent(event)
  print("LoginNetHandler:fireLoginResEvent")
  got_login_response = true
  if event.resultCode == 1 then
    --登录成功
    print("LoginNetHandler success")
    login_success = true

    ----------
    --[[local init_table = {}
    init_table["myId"] = myId
    game_state.switch(roomlist, init_table)]]--
    --------
  else
    print("LoginNetHandler fail")
    login_success = false
  end
end


function quit()
  love.event.quit()
end

--camera相关的函数
camera_start_shake = function(time, strength)
  camera_shaking = true
  camera_shaking_interval = time
  camera_shaking_account = 0
  camera:shake(strength)
  camera:shakeCamera()
end

camera_stop_shake = function()
  camera:dontPanic()
  camera_shaking = false
  camera_shaking_account = 0
  camera:lookAt(window_w/2, window_h/2)
end

camera_update = function(dt)
  if camera_shaking then
    camera:update(dt)
    if camera_shaking_account > camera_shaking_interval then
      --别再shake了
      camera_stop_shake()
    else 
      camera_shaking_account = camera_shaking_account + dt
    end
  end
end

return login
