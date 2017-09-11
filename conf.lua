function love.conf(t)
	t.identity = "PROJBOOM"
	t.title = "PROJBOOM"
	t.console = false
	t.window.msaa = 2
	t.window.vsync = true
	t.window.height = 800
	t.window.width = 1280
	t.window.fullscreen = true
  t.modules.image = true
  t.modules.timer = true
end
