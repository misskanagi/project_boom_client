local camera = require("libs.hump.camera")
local boom_camera = {}

local function lerp(a, b, k) --smooth transitions
  if a == b then
    return a
  else
    if math.abs(a-b) < 0.005 then return b else return a * (1-k) + b * k end
  end
end

function boom_camera:new(o)
    o = o or {}
    setmetatable(self, o)
    o.__index = o
    self.shaking = 0
    self.shakingTarget = 0
    self.currShaking = 0
    return self
end

function boom_camera:moveToPlayer()
    for i, e in pairs(engine:getEntitiesWithComponent("IsMyself")) do
        local body = e:get("Physic").body
        local x, y = body:getWorldCenter()
        local dx,dy = x - self.x, y - self.y
        self:move(dx/15, dy/15)
        break
    end
    --local cx,cy = self:position()
    --print(("camX: %04d, camY: %04d"):format(cx,cy))
    return self
end

function boom_camera:shake(shaking, once)
    self.shaking = shaking or 0
    self.currShaking = self.shaking
    self.calm = once or false
    return self
end

function boom_camera:dontPanic()
    self.calm = true
end

function boom_camera:shakeCamera(shaking)
    self:move((math.random()-.5)*self.currShaking, (math.random()-.5)*self.currShaking)
end

function boom_camera:update(dt)
    local _speed = 7
    self.currShaking = lerp(self.currShaking, self.shakingTarget, _speed*dt)
    if not self.calm then
        self.currShaking = self.shaking
    end
    self:apply()
end

function boom_camera:apply()
    self:moveToPlayer()
    self:shakeCamera()
end

function boom_camera:instance()
    if boom_camera.inst == nil then
      boom_camera.inst = boom_camera:new(camera())
    end
    return boom_camera.inst
end

return boom_camera
