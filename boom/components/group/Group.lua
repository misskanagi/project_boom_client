local Group = Component.create("Group")

function Group:initialize(group_id, life_num)
    self.group_id = group_id
    self.life_num = life_num
end

return Group
