--网络上传过来的鼠标移动事件
local NetMouseMoved = class("NetMouseMoved")

function NetMouseMoved:initialize(x, y, player_name)
    self.tx = x
    self.ty = y
    self.name = player_name
end

return NetMouseMoved

