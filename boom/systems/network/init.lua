local SendPhysicSnapshot = require "boom.systems.network.SendPhysicSnapshot"
local Ping = require "boom.systems.network.Ping"

local network = {
  SendPhysicSnapshot(),
  Ping(),
}

network.names = {
  "SendPhysicSnapshot",
  "Ping",
}

return network
