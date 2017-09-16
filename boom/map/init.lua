-- sti
local sti = require("libs.sti")

local createMap = function(path)
  local map = sti(path)
  return map
end

return createMap
