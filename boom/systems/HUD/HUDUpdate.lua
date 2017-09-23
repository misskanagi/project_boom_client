local HUDUpdate = class("HUDUpdate", System)
require "/libs/gooi"

function HUDUpdate:update(dt)
  gooi.update(dt)
end


return HUDUpdate