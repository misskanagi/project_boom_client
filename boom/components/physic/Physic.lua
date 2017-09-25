local Physic = Component.create("Physic")

function Physic:initialize(body, other_bodies, mli, afc, rfc)
    -- root body
    self.body = body
    self.root_body_id = 1
    -- friction
    self.maxFrictionImpulse = mli or 3
    self.angularFrictionConstant = afc or 0.05
    self.rollFrictionConstant = rfc or 0.05
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
