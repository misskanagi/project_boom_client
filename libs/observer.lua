-- Observer design pattern.
-- Produces a few functions that have a closure that implements
-- subject-observer notification.

-- Example usage:
-- subject.reg, subject.dereg, subject.notify = observer.create()
-- subject:reg( "signal", observer, method )
-- subject:reg( "signal", nil, function )
-- subject:notify( "signal" )
-- subject:dereg( "signal", observer, method )
-- subject:dereg( "signal", nil, function )

--local table = require("table");
--local base = require("base");
--local setmetatable = base.setmetatable
--local ipairs = base.ipairs
local table = table;
local setmetatable = setmetatable
local ipairs = ipairs

module("observer")

function create()
  -- Containter holds the filter, and handlers and observers.
  local container = {}

  -- Provision for garbage collection, weak metatable and sentinel.
  local weak = { __mode = "kv" }

  -- Register
  -- Creates an observation between the Subject data and the
  -- Observer data, using filter Signal and handler Method.
  -- Usage:
  --   s:register( "update", o, o.m )
  local register = function( subject, signal, observer, method )
    t = container[signal] or {}
    local o = observer or weak
    local k = { method, o }
    setmetatable( k, weak )
    table.insert( t, k )
    container[signal] = t
  end

  -- Deregister
  -- Removes any observations in the Signal filter, either matching
  -- the Observer and Method, or the whole filter if both are nil.
  -- Usage:
  --   s:deregister( "update" )
  --   s:deregister( "update", o )
  --   s:deregister( "update", o, o.m )
  local deregister = function( subject, signal, observer, method )
    t = container[signal]
    if not t then return end
    if not method and not observer then
      container[signal] = nil
      return
    end
    local i, v
    i = #t
    while i > 0 do
      v = t[i] or {}
      if  ( not method   or v[1] == method )
      and ( not observer or v[2] == observer ) then
        table.remove( t, i )
      end
      i = i - 1
    end
  end

  -- Notify
  -- Uses the Signal Filter to notify all observations via their
  -- registered handlers.
  -- Usage:
  --   s:notify( "update" )
  local notify = function( subject, signal, ... )
    t = container[signal]
    if not t then return end
    for i, v in ipairs( t ) do
      if v[2] == weak then
        v[1](subject, ...)
      elseif v[2] then
        v[1](v[2], subject, ...)
      end
      -- garbage collected observers (nil) are skipped.
    end
  end

  return register, deregister, notify
end

-- Signal
-- Convienience function that gives a shorthand to sending a
-- notification.
-- Usage:
--   s.update = signal( s, s.notify, "update" )
--   s.update()
function signal( subject, notify, name )
  return function( ... )
    return notify( subject, name, ... )
  end
end
