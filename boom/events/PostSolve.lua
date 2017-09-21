local PostSolve = class("PostSolve")

function PostSolve:initialize(a, b, coll, normalimpulse, tangentimpulse)
    self.a = a
    self.b = b
    self.coll = coll
    self.normalimpulse = normalimpulse
    self.tangentimpulse = tangentimpulse
end

return PostSolve
