local Controllable = Component.create("Controllable")

function Controllable:initialize()
end

function Controllable:moveUp(body)
    body:applyLinearImpulse( 0, 1 )
end

function Controllable:moveDown(body)
    body:applyLinearImpulse( 0, -1 )
end

function Controllable:moveLeft(body)
    body:applyLinearImpulse( -1, 0 )
end

function Controllable:moveRight(body)
    body:applyLinearImpulse( 1, 0 )
end

return Controllable
