local ParticleSystemManager = {}

function ParticleSystemManager:createParticleSystem(type)
    if type == "gun" then
      return self:createGatlinParticleSystem()
    elseif type == "gun_hit" then
      return self:createGatlinHitParticleSystem()
    elseif type == "booster_fire" then
      return self:createBoosterFireParicleSystem()
    elseif type == "explosion" then
      return self:createExplosionParticleSystem()
    end
    return nil
end

function ParticleSystemManager:createGatlinParticleSystem()
    local tex = love.graphics.newImage("assets/particles/line2px.png")
    local emitter = love.graphics.newParticleSystem(tex,32)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",1,2)
    emitter:setEmissionRate(100)
    emitter:setEmitterLifetime(1)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.10000000149012)
    emitter:setRadialAcceleration(0,0)
    emitter:setRotation(0,0)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,800)
    emitter:setSpin(0,0)
    emitter:setSpinVariation(2.7755575615629e-17)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(0.10000000149012)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1,1,1,1,1)
    emitter:setSizeVariation(0)
    emitter:setColors(218,187,50,255)
    return emitter
end

function ParticleSystemManager:createGatlinHitParticleSystem()
    local tex = love.graphics.newImage("assets/particles/spark.png")
    local emitter = love.graphics.newParticleSystem(tex,64)
    emitter:setDirection(0)
    emitter:setAreaSpread("normal",1,3.0999999046326)
    emitter:setEmissionRate(100)
    emitter:setEmitterLifetime(0.54000002145767)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.30000001192093)
    emitter:setRadialAcceleration(0,0)
    emitter:setRotation(0,0)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,100)
    emitter:setSpin(0,0)
    emitter:setSpinVariation(2.7755575615629e-17)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(1)
    emitter:setRelativeRotation(false)
    emitter:setOffset(2.5,2.5)
    emitter:setSizes(1,1,1,1,1)
    emitter:setSizeVariation(0)
    emitter:setColors(218,187,50,193 )
    return emitter
end

function ParticleSystemManager:createBoosterFireParicleSystem()
    local tex = love.graphics.newImage("assets/particles/circle.png")
    local emitter = love.graphics.newParticleSystem(tex,32)
    emitter:setDirection(0)
    emitter:setAreaSpread("none",0,0)
    emitter:setEmissionRate(500)
    emitter:setEmitterLifetime(1)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.10000000149012)
    emitter:setRadialAcceleration(0,0)
    emitter:setRotation(0,0)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,500)
    emitter:setSpin(0,0)
    emitter:setSpinVariation(0)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(0)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1)
    emitter:setSizeVariation(0)
    emitter:setColors(218,107,77,255 )
    return emitter
end

function ParticleSystemManager:createExplosionParticleSystem()
    local tex = love.graphics.newImage("assets/particles/circle.png")
    local emitter = love.graphics.newParticleSystem(tex,64)
    emitter:setDirection(0)
    emitter:setAreaSpread("normal",8,8)
    emitter:setEmissionRate(600)
    emitter:setEmitterLifetime(0.20000000298023)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.20000000298023)
    emitter:setRadialAcceleration(0,100)
    emitter:setRotation(0,10)
    emitter:setTangentialAcceleration(0,100)
    emitter:setSpeed(0,204.69999694824)
    emitter:setSpin(0,100)
    emitter:setSpinVariation(0)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1,0.6)
    emitter:setSizeVariation(0)
    emitter:setColors(210,170,76,255, 220,51,44,255 )
    return emitter
end

return ParticleSystemManager
