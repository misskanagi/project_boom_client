local ItemSpin = class("ItemSpin", System)

function ItemSpin:update(dt)
    for index, entity in pairs(self.targets) do
        local body = entity:get("Physic").body
        body:setAngularVelocity(1.0)
    end
end

function ItemSpin:requires()
    return {"IsItem", "Physic"}
end

return ItemSpin
