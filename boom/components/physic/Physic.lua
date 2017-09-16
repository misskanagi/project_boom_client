local Physic = Component.create("Physic")

function Physic:initialize(body, other_bodies)
    -- root body
    self.body = body
    self.root_body_id = 1
    -- none root bodies
    self.other_bodies = other_bodies or {}
    -- id to body list
    self.bodies = {}
    self.bodies[self.root_body_id] = self.body
    if other_bodies then
      for i=1, #other_bodies, 1 do
        self.bodies[i+1] = other_bodies[i]
      end
    end
end

return Physic
