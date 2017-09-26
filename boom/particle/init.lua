--local AssetsManager = require("assets")
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
    elseif type == "heal_explosion" then
      return self:createHealExplosionParticleSystem()
    elseif type == "adv_explosion" then
      return self:createAdvancedExplosionParticleSystem()
    elseif type == "nuclear_explosion" then
      return self:createNuclearExplosionParticleSystem()
    elseif type == "landmine_explosion" then
      return self:createLandmineExplosionParticleSystem()
    elseif type == "item_explosion" then
      return self:createItemDestroyParticleSystem()
    elseif type == "default_wreckage" then
      return self:createDefaultWreckageParticleSystem()
    elseif type == "barrier_wreckage" then
      return self:createBarrierWreckageParticleSystem()
    end
    return nil
end

function ParticleSystemManager:createGatlinParticleSystem()
    local tex = assets.particles.line2px
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
    local tex = assets.particles.spark
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
    local tex = assets.particles.circle
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
    local tex = assets.particles.circle
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

function ParticleSystemManager:createHealExplosionParticleSystem()
    local tex = assets.particles.cross
    local emitter = love.graphics.newParticleSystem(tex,8)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",16,16)
    emitter:setEmissionRate(20)
    emitter:setEmitterLifetime(1)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,1)
    emitter:setRadialAcceleration(0,10)
    emitter:setRotation(0,1)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,80)
    emitter:setSpin(0,0)
    emitter:setSpinVariation(0)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1)
    emitter:setSizeVariation(0)
    emitter:setColors(255,255,255,255 )
    return emitter
end

function ParticleSystemManager:createAdvancedExplosionParticleSystem()
    local tex = assets.particles.circle
    local emitter = love.graphics.newParticleSystem(tex,128)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",16,16)
    emitter:setEmissionRate(1200)
    emitter:setEmitterLifetime(0.25)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.20000000298023)
    emitter:setRadialAcceleration(0,0)
    emitter:setRotation(0,10)
    emitter:setTangentialAcceleration(0,10)
    emitter:setSpeed(0,500)
    emitter:setSpin(0,10)
    emitter:setSpinVariation(1)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1,1)
    emitter:setSizeVariation(1)
    emitter:setColors(104,204,51,255, 204,104,51,255 )
    return emitter
end

function ParticleSystemManager:createNuclearExplosionParticleSystem()
    local tex = assets.particles.twirl
    local emitter = love.graphics.newParticleSystem(tex,256)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",48,48)
    emitter:setEmissionRate(2500)
    emitter:setEmitterLifetime(1.0499999523163)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.20000000298023)
    emitter:setRadialAcceleration(0,103)
    emitter:setRotation(0,30)
    emitter:setTangentialAcceleration(0,30)
    emitter:setSpeed(0,2000)
    emitter:setSpin(0,51)
    emitter:setSpinVariation(1)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(64,64)
    emitter:setSizes(1,1)
    emitter:setSizeVariation(1)
    emitter:setColors(204,204,51,255, 204,104,51,255 )
    return emitter
end

function ParticleSystemManager:createLandmineExplosionParticleSystem()
    local tex = assets.particles.circle
    local emitter = love.graphics.newParticleSystem(tex,128)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",24,24)
    emitter:setEmissionRate(1200)
    emitter:setEmitterLifetime(0.25)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0,0.20000000298023)
    emitter:setRadialAcceleration(0,103)
    emitter:setRotation(0,30)
    emitter:setTangentialAcceleration(0,30)
    emitter:setSpeed(0,500)
    emitter:setSpin(0,51)
    emitter:setSpinVariation(1)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1,1)
    emitter:setSizeVariation(1)
    emitter:setColors(204,204,51,255, 204,104,51,255 )
    return emitter
end

function ParticleSystemManager:createItemDestroyParticleSystem()
    local tex = assets.particles.spark
    local emitter = love.graphics.newParticleSystem(tex,64)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",16,16)
    emitter:setEmissionRate(231)
    emitter:setEmitterLifetime(0.8)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(0.6)
    emitter:setRadialAcceleration(0,10)
    emitter:setRotation(0,5)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,40)
    emitter:setSpin(0,10)
    emitter:setSpinVariation(0)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(2.5,2.5)
    emitter:setSizes(1)
    emitter:setSizeVariation(0)
    emitter:setColors(255,255,255,180 )
    return emitter
end

function ParticleSystemManager:createDefaultWreckageParticleSystem()
    local tex = assets.particles.smoke
    local emitter = love.graphics.newParticleSystem(tex,16)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",16,16)
    emitter:setEmissionRate(100)
    emitter:setEmitterLifetime(60)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(100,120)
    emitter:setRadialAcceleration(0,0)
    emitter:setRotation(0,0)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,0)
    emitter:setSpin(0,0)
    emitter:setSpinVariation(2.7755575615629e-17)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(8,8)
    emitter:setSizes(1)
    emitter:setSizeVariation(2.7755575615629e-17)
    emitter:setColors(102,102,102,255 )
    return emitter
end

function ParticleSystemManager:createBarrierWreckageParticleSystem()
    local tex = assets.particles.barrier
    local emitter = love.graphics.newParticleSystem(tex,8)
    emitter:setDirection(0)
    emitter:setAreaSpread("uniform",16,16)
    emitter:setEmissionRate(150)
    emitter:setEmitterLifetime(60)
    emitter:setLinearAcceleration(0,0,0,0)
    emitter:setParticleLifetime(100,120)
    emitter:setRadialAcceleration(0,0)
    emitter:setRotation(0,5)
    emitter:setTangentialAcceleration(0,0)
    emitter:setSpeed(0,0)
    emitter:setSpin(0,0)
    emitter:setSpinVariation(0)
    emitter:setLinearDamping(0,0)
    emitter:setSpread(6.1999998092651)
    emitter:setRelativeRotation(false)
    emitter:setOffset(16,16)
    emitter:setSizes(1)
    emitter:setSizeVariation(0)
    emitter:setColors(255,255,255,255 )
    local q1 = love.graphics.newQuad(0,0,16,16,32,32)
    local q2 = love.graphics.newQuad(16,0,16,16,32,32)
    local q3 = love.graphics.newQuad(0,16,16,16,32,32)
    local q4 = love.graphics.newQuad(16,16,16,16,32,32)
    emitter:setQuads(q1,q2,q3,q4)
    return emitter
end

return ParticleSystemManager
