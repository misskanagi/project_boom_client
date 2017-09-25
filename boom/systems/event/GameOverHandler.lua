local GameOverHandler = class("GameOverHandler", System)
local game_state = require("libs.hump.gamestate")

function GameOverHandler:fireGameOver(event)
    --ugly!    Need review...
    local myId = net.playerId
    local masterId = net.roomId  --房主Id和房间Id一致
    local winOrLose = false --是否赢了
    
    local winGroupId = nil
    local entities = engine:getEntitiesWithComponent("Group")
    for _, entity in pairs(entities) do 
      local group_component = entity:get("Group")
      --可以获取两队的kd数据
      if group_component.lives > 0 then
        winGroupId = group_component.id
      end
      for __, player_info in pairs(group_component.players_info) do
        --获取player_info
        if player_info.player_id == myId then --找到了本人自己
          if group_component.lives > 0 then
            winOrLose = true
            break
          end
        end
      end
    end
    
    local gameover = require "boom.scenes.gameover"
    local init_table = {}
    
    if myId == masterId then  --如果是房主，需要向Server发送gameover的请求
      net:requestGameOver(winGroupId)
    end
    init_table["myId"] = myId
    init_table["winOrLose"] = winOrLose
    game_state.switch(gameover, init_table)
end

return GameOverHandler
