local GlobalEntityId = Component.create("GlobalEntityId")

function GlobalEntityId:initialize(id)
    if GlobalEntityId.currentId == nil then
      GlobalEntityId.currentId = 0
    end
    GlobalEntityId.currentId = GlobalEntityId.currentId + 1
    self.id = GlobalEntityId.currentId
end

return GlobalEntityId
