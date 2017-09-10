local Physic = Component.create("Physic")

function Physic:initialize(body, fixture, shape, other_bodies)
    -- root body
    self.body = body
    self.shape = shape
    self.fixture = fixture
    -- none root bodies
    self.other_bodies = other_bodies or {}
end

return Physic
