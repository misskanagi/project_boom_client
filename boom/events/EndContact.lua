local EndContact = class("EndContact")

function EndContact:initialize(a, b, coll)
    self.a = a
    self.b = b
    self.coll = coll
end

return EndContact
