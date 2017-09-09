local KeyboardEvent = class("KeyboardEvent", System)

function KeyboardEvent:fireEvent(event)
    if event.key == "w" then
        for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
            entity:get("Controllable"):moveUp(entity:get("physic").body)
        end
    elseif event.key == "s" then
        for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
            entity:get("Controllable"):moveDown(entity:get("physic").body)
        end
    elseif  event.key == "a" then
        for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
            entity:get("Controllable"):moveLeft(entity:get("physic").body)
        end
    elseif  event.key == "d" then
        for index, entity in pairs(engine:getEntitiesWithComponent("Controllable")) do
            entity:get("Controllable"):moveRight(entity:get("physic").body)
        end
    end
end

return KeyboardEvent
