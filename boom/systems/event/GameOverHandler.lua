local GameOverHandler = class("GameOverHandler", System)
local game_state = require("libs.hump.gamestate")

function GameOverHandler:fireGameOver(event)
    --ugly!    Need review...
    local myId = net.playerId
    local masterId = net.roomId  --房主Id和房间Id一致
    local winOrLose = false --是否赢了
    local group_info = {}
    local winGroupId = nil
    local entities = engine:getEntitiesWithComponent("Group")
    for _, entity in pairs(entities) do 
      local group_component = entity:get("Group")
      group_info[group_component.id] = group_component.players_info
      --可以获取两队的kd数据
      if group_component.lives > 0 then
        winGroupId = group_component.id
      else 
        winGroupId = 3 - group_component.id
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
      print("requestGameOver")
      net:requestGameOver(winGroupId)
    end
    --[[init_table["myId"] = myId
    init_table["winOrLose"] = winOrLose
    init_table["group_info"] = group_info
    game_state.switch(gameover, init_table)]]--
end

function GameOverHandler:fireGameOverBroadcast(event)
    --ugly!    Need review...
    local myId = net.playerId
    local winOrLose = false --是否赢了
    local group_info = {}
    local winGroupId = nil
    local entities = engine:getEntitiesWithComponent("Group")
    for _, entity in pairs(entities) do 
      local group_component = entity:get("Group")
      group_info[group_component.id] = group_component.players_info
      --可以获取两队的kd数据
      if group_component.lives > 0 then
        winGroupId = group_component.id
      end
      for __, player_info in pairs(group_component.players_info) do
        --获取player_info
        if player_info.player_id == myId then --找到了本人自己
          if event.winGroupId == group_component.id then
            winOrLose = true
            break
          end
        end
      end
    end
    
    local gameover = require "boom.scenes.gameover"
    local init_table = {}
    
    init_table["myId"] = myId
    init_table["winOrLose"] = winOrLose
    init_table["group_info"] = group_info
    local system_manager = require("boom.systems")
    --system_manager.removeSpawners()
    --system_manager:removeAllEntities(engine:getRootEntity())
    system_manager:removeAllEntities(engine.rootEntity)
    --system_manager.removeAllEntities_norec(engine.rootEntity)
    
    engine:stopSystem("SpawnableSync")
    game_state.switch(gameover, init_table)
end

return GameOverHandler
