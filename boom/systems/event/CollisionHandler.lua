local CollisionHandler = class("CollisionHandler", System)

function CollisionHandler:fireBeginContact(event)
    local ba = event.a:getBody()
    local bb = event.b:getBody()
    local entity_a = ba:getUserData()
    local entity_b = bb:getUserData()
    if entity_a and entity_b and
       entity_a:isInstanceOf(Entity) and
       entity_b:isInstanceOf(Entity) then
        local cba = entity_a:get("CollisionCallbacks")
        local cbb = entity_b:get("CollisionCallbacks")
        if cba then
          cba.beginContact(entity_b, event.coll)
        end
        if cbb then
          cbb.beginContact(entity_a, event.coll)
        end
    end
end

function CollisionHandler:fireEndContact(event)
    local ba = event.a:getBody()
    local bb = event.b:getBody()
    local entity_a = ba:getUserData()
    local entity_b = bb:getUserData()
    if entity_a and entity_b and
       entity_a:isInstanceOf(Entity) and
       entity_b:isInstanceOf(Entity) then
        local cba = entity_a:get("CollisionCallbacks")
        local cbb = entity_b:get("CollisionCallbacks")
        if cba then
          cba.endContact(entity_b, event.coll)
        end
        if cbb then
          cbb.endContact(entity_a, event.coll)
        end
    end
end

function CollisionHandler:firePreSolve(event)
    local ba = event.a:getBody()
    local bb = event.b:getBody()
    local entity_a = ba:getUserData()
    local entity_b = bb:getUserData()
    if entity_a and entity_b and
       entity_a:isInstanceOf(Entity) and
       entity_b:isInstanceOf(Entity) then
        local cba = entity_a:get("CollisionCallbacks")
        local cbb = entity_b:get("CollisionCallbacks")
        if cba then
          cba.preSolve(entity_b, event.coll)
        end
        if cbb then
          cbb.preSolve(entity_a, event.coll)
        end
    end
end

function CollisionHandler:firePostSolve(event)
    local ba = event.a:getBody()
    local bb = event.b:getBody()
    local entity_a = ba:getUserData()
    local entity_b = bb:getUserData()
    if entity_a and entity_b and
       entity_a:isInstanceOf(Entity) and
       entity_b:isInstanceOf(Entity) then
        local cba = entity_a:get("CollisionCallbacks")
        local cbb = entity_b:get("CollisionCallbacks")
        if cba then
          cba.postSolve(entity_b, event.coll, event.normalimpulse, event.tangentimpulse)
        end
        if cbb then
          cbb.postSolve(entity_a, event.coll, event.normalimpulse, event.tangentimpulse)
        end
    end
end

return CollisionHandler
