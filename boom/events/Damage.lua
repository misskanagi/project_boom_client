local Damage = class("Damage")

function Damage:initialize(src_entity, dst_entity, dmg, dist, range)
    self.src_entity = src_entity
    self.dst_entity = dst_entity
    self.dmg = dmg
    self.dist = dist or 0
    self.range = range or 32
end

return Damage
