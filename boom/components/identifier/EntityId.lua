local EntityId = Component.create("EntityId")

function EntityId:initialize(id)
    self.id = id
end

return EntityId
