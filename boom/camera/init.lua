local camera = require("libs.hump.camera")
local boom_camera = camera()

function boom_camera:moveToPlayer()
    for i, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local body = e:get("Physic").body
        local x, y = body:getWorldCenter()
        local dx,dy = x - self.x, y - self.y
        self:move(dx/15, dy/15)
        break
    end
    local cx,cy = self:position()
    --print(("camX: %04d, camY: %04d"):format(cx,cy))
end

function boom_camera:update(dt)
    self:moveToPlayer()
end

return boom_camera
