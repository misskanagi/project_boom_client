local Health = Component.create("Health")

function Health:initialize(v)
    self.value = v
    self.max_value = self.value
    self.death = 0
    self.src_dmg_entity = nil
end

return Health
