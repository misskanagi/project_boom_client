local SendPhysicSnapshot = require "boom.systems.network.SendPhysicSnapshot"

local network = {
  SendPhysicSnapshot(),
}

network.names = {
  "SendPhysicSnapshot",
}

return network
