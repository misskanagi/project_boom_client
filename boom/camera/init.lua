local camera = require("libs.hump.camera")
local boom_camera = camera()

function boom_camera:moveToPlayer()
    for i, e in pairs(engine:getEntitiesWithComponent("IsPlayer")) do
        local p = e:get("Position")
        local dx,dy = p.x - self.x, p.y - self.y
        self:move(dx/10, dy/10)
        break
    end
    local cx,cy = self:position()
    --print(("camX: %04d, camY: %04d"):format(cx,cy))
end

function boom_camera:update(dt)
    self:moveToPlayer()
end

return boom_camera
