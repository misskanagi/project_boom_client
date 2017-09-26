local PlaySoundHandler = class("PlaySoundHandler", System)

function PlaySoundHandler:firePlaySound(event)
    --love.audio.play( event.sound )
    event.sound:play()
end

return PlaySoundHandler
