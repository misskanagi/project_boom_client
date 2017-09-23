local class = require "libs.lovetoys.lib.middleclass"

local GameRoomInfo = class("GameRoomInfo")

function GameRoomInfo:initialize(map_name, players_per_team,
                                 lives_per_team, battle_mode,
                                 room_master_id, my_id,
                                 players_info)
    self.map_name = map_name
    self.players_per_team = players_per_team
    self.lives_per_team = lives_per_team
    self.battle_mode = battle_mode
    self.room_master_id = room_master_id
    self.my_id = my_id
    self.players_info = players_info
end

return GameRoomInfo
