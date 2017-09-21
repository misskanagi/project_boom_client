local BeginContact = class("BeginContact")

function BeginContact:initialize(a, b, coll)
    self.a = a
    self.b = b
    self.coll = coll
end

return BeginContact
