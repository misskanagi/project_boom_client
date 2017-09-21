local CollisionCallbacks = Component.create("CollisionCallbacks")

function CollisionCallbacks:initialize(beginContact, endContact, pre, post)
    self.beginContact = beginContact or function(that_entity, coll) end
    self.endContact = endContact or function(that_entity, coll) end
    self.preSolve = pre or function(that_entity, coll) end
    self.postSolve = post or function(that_entity, coll, normalimpulse, tangentimpulse) end
end

return CollisionCallbacks
