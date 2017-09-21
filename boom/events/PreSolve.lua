local PreSolve = class("PreSolve")

function PreSolve:initialize(a, b, coll)
    self.a = a
    self.b = b
    self.coll = coll
end

return PreSolve
