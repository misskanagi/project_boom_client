local Group = Component.create("Group")

function Group:initialize(id, lives, players_info)
    self.id = id
    self.lives = lives
    print(self.lives)
    self.players_info = {}
    if players_info then
        for _, player_info in pairs(players_info) do
            if player_info.group_id == id then
                self.players_info[#self.players_info+1] = {player_id = player_info.player_id, tank_type = player_info.tank_type, kill = 0, death = 0}
            end
        end
    end
end

return Group
