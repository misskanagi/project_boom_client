require("scripts.system.observer")

-- Observers.
function a( subject )
  print( "a", type(subject) )
end

function b( data, subject, extra )
  print( "b", data, type(subject), extra )
end

o = {}
function o:m( subject, extra )
  print( "o:m", type(self), type(subject), extra )
end

-- First Observation
reg, dereg, notify = observer.create()

reg( nil, "signal", nil, a )
reg( nil, "signal", "lol", b )
print( "First notification" )
notify( nil, "signal", "zomg" )
dereg( nil, "signal", nil, a )
print( "Second notification" )
notify( nil, "signal" )

-- Second Observation

s = {}
s.reg, s.dereg, s.notify = observer.create()
s.signal = observer.signal( s, s.notify, "signal" )

s:reg( "signal", nil, a )
s:reg( "signal", o, o.m )
print( "Third notification" )
s.signal("rofl")
s:dereg( "signal" )

s:reg( "signal", o, o.m )
print( "Fourth notification" )
o = nil
collectgarbage()
s:notify( "signal" )
