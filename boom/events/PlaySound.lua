local PlaySound = class("PlaySound")

function PlaySound:initialize(sound, src_entity)
    self.sound = sound
    self.src_entity = src_entity or nil
end

return PlaySound
