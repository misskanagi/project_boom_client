local PSM = require "boom.particle"
local Firable = Component.create("Firable")

function Firable:initialize(light_world)
    self.cmd = {
      fire = false,
    }
    self.fire_ps = PSM:createParticleSystem("gun")
    self.fire_light = light_world:newLight(0, 0, 255, 205, 200, 50)
    self.fire_range = 300*32
    self.fire_dmg = 0.15
    --self.fire_light:setAngle(math.pi/8)
    self.fire_light:setGlowStrength(2.0)
    self.height = 5
    self.fire_light:setPosition(0, 0, self.height)
    self.fire_light:setVisible(false)
    --hit specific
    self.all_hit_ps = {}
    self.all_hit_pos = {}
    self.hit_max = 7
    for i=1, self.hit_max, 1 do
        self.all_hit_ps[i] = PSM:createParticleSystem("gun_hit")
        self.all_hit_pos[i] = {x = nil, y = nil, r = nil}
    end
    self.hit_curr = 1
    self.hit_active = 0
end

return Firable
