function love.conf(t)
	t.identity = "PROJBOOM"
	t.title = "PROJBOOM"
	t.console = false
	--t.window.msaa = 4
	t.window.vsync = true
	t.window.height = 680
	t.window.width = 960
	t.window.fullscreen = true
	--t.window.fullscreentype = "exclusive"
  t.modules.image = true
  t.modules.timer = true
end
