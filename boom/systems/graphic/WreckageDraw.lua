local WreckageDraw = class("WreckageDraw", System)

function WreckageDraw:draw()
    for index, entity in pairs(self.targets) do
        local wreckage = entity:get("Wreckage")
        love.graphics.draw(wreckage.wreckage_ps, wreckage.x, wreckage.y)
    end
end

function WreckageDraw:requires()
    return {"Wreckage"}
end

return WreckageDraw
