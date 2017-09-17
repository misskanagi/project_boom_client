local netLib = require "library"
local json = require "libs.json"
--events
local events = require("boom.events")

local network = {
  cmd_code = {
    DEDAULT = 0,

    LOGIN_REQ = 101,
    LOGIN_RES = 102,

    GET_ROOM_LIST_REQ = 201,
    GET_ROOM_LIST_RES = 202,
    CREATE_ROOM_REQ = 203,
    CREATE_ROOM_RES = 204,
    ENTER_ROOM_REQ = 205,
    ENTER_ROOM_RES = 206,
    ENTER_ROOM_BROADCAST = 207,
    QUIT_ROOM_REQ = 208,
    QUIT_ROOM_BROADCAST = 209,

    GAME_READY_REQ = 301,
    GAME_READY_BROADCAST = 302,
    GAME_CANCEL_READY = 303,
    GAME_CANCEL_READY_BROADCAST = 304,
    GAME_BEGIN_REQ = 305,
    GAME_BEGIN_BROADCAST = 306,
    GAME_OVER_REQ = 307,
    GAME_OVER_BROADCAST = 308,

    --玩家汇报操作(按键)
    PLAYER_COMMAND_REPORT = 401,
    --向其他玩家广播操作(按键)
    PLAYER_COMMAND_BROADCAST = 402,
    --房主下发snapshot
    ROOM_MASTER_SEND_SNAPSHOT = 403,
    --404 not found
    --snapshot广播给其他玩家
    SNAPSHOT_BROADCAST = 405,
    --房主发道具放到snapshot中
    --道具（子弹+装备）仲裁
    GAME_PROPS_DECISION_REQ = 501,
    GAME_PROPS_DECISION_REQ_FORWARD = 502,
    GAME_PROPS_DECISION_RES_FORWARD = 503,
    GAME_PROPS_DECISION_RES = 504,
    GAME_PROPS_DECISION_BROADCAST = 505,

    --非主机玩家掉线
    NONMASTER_DISCONNECT_EXCEPTION = 601,
    --主机玩家掉线
    MASTER_DISCONNECT_EXCEPTION = 602,

    --UPLOAD_GAME_ACHIEVEMENT = 701,
    --UPLOAD_GAME_ACHIEVEMENT_RES = 702,
  }
}

function network:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

-- 分发网络事件
function network:update(dt)
    if self.fd then
      self:updateReceive(dt)
    end
end

function network:updateReceive(dt)
  --print("network:updateReceive")
  local msg = self:receive()
  if msg then
    for _, json_string in pairs(msg) do
      --print("receive:")
      print(json_string)
      data = json.decode(json_string)
      if data.cmdType == self.cmd_code.PLAYER_COMMAND_BROADCAST then
        local playerId = data.playerId
        if playerId ~= self.playerId then
          local playerCommands = data.playerCommands
          for _, cmd in pairs(playerCommands) do
            local pressedOrReleased = cmd.pressedOrReleased
            local isRepeat = cmd.isRepeat
            local key = cmd.key
            eventmanager:fireEvent(
              pressedOrReleased and
              events.NetKeyPressed(key, isRepeat, playerId) or
              events.NetKeyReleased(key, isRepeat, playerId)
            )
          end
        end
      elseif data.cmdType == self.cmd_code.SNAPSHOT_BROADCAST then
        --print(json_string)
        --print("data:", data)
        --print("entities:", data.entities)
        eventmanager:fireEvent(events.SnapshotReceived(data.roomId, data.entities))
      elseif data.cmdType == self.cmd_code.LOGIN_RES then
        print("got LOGIN_RES")
        eventmanager:fireEvent(events.LoginRes(data.resultCode))
      elseif data.cmdType == self.cmd_code.GET_ROOM_LIST_RES   then
        print("got GET_ROOM_LIST_RES")
        eventmanager:fireEvent(events.GetRoomListRes(data.roomNumbers, data.roomsInfo))
      elseif data.cmdType == self.cmd_code.CREATE_ROOM_RES then
        print("got CREATE_ROOM_RES")
        eventmanager:fireEvent(events.CreateRoomRes(data.roomId, data.groupId))
      elseif data.cmdType == self.cmd_code.ENTER_ROOM_RES then
        print("got ENTER_ROOM_RES")
        eventmanager:fireEvent(events.EnterRoomRes(data.responseCode, data.groupId, data.roomMasterId, data.playersInfo))
      elseif data.cmdType == self.cmd_code.ENTER_ROOM_BROADCAST then
        print("got ENTER_ROOM_BROADCAST")
        eventmanager:fireEvent(events.EnterRoomBroadcast(data.roomId, data.playerId, data.groupId))
      elseif data.cmdType == self.cmd_code.QUIT_ROOM_BROADCAST then
        print("got QUIT_ROOM_BROADCAST")
        eventmanager:fireEvent(events.QuitRoomBroadcast(data.isMaster, data.roomId, data.playerId))
      elseif data.cmdType == self.cmd_code.GAME_READY_BROADCAST then
        print("got GAME_READY_BROADCAST")
        eventmanager:fireEvent(events.GameReadyBroadcast(data.playerId, data.roomId, data.tankType))
      elseif data.cmdType == self.cmd_code.GAME_CANCEL_READY_BROADCAST then
        print("got GAME_CANCEL_READY_BROADCAST")
        eventmanager:fireEvent(events.GameCancelReadyBroadcast(data.playerId, data.roomId))
      elseif data.cmdType == self.cmd_code.GAME_BEGIN_BROADCAST then
        print("got GAME_BEGIN_BROADCAST")
        eventmanager:fireEvent(events.GameBeginBroadcast(data.roomId))
      end
    end
  end
end

function network:loginTest(id)
    self.playerId = id
    self.roomId = "test"
    --print(json.encode(data))
    local result = self:send(self.cmd_code.LOGIN_REQ, {playerId = id, password = "1234"})
end

--请求房间列表
function network:requestGetRoomList(playerId)
  local result = self:send(self.cmd_code.GET_ROOM_LIST_REQ, {playerId = playerId})
end

--请求创建房间
function network:requestCreateRoom(playerId, gameMode, mapType, lifeNumber, playersPerGroup)
  local result = self:send(self.cmd_code.CREATE_ROOM_REQ, {playerId = playerId, gameMode = gameMode, mapType = mapType, lifeNumber = lifeNumber, playersPerGroup = playersPerGroup})
end

--请求进入房间
function network:requestEnterRoom(roomId, playerId)
  local result = self:send(self.cmd_code.ENTER_ROOM_REQ, {roomId = roomId, playerId = playerId})
end

--请求退出房间
function network:requestQuitRoom(roomId, playerId)
  local result = self:send(self.cmd_code.QUIT_ROOM_REQ, {roomId = roomId, playerId = playerId})
end

--请求登录
function network:requestLogin(name, password)
  self.playerId = name
  local result = self:send(self.cmd_code.LOGIN_REQ, {playerId = name, password = password})
end

--请求进入准备状态
function network:requestGameReady(playerId, roomId, tankType)
  local result = self:send(self.cmd_code.GAME_READY_REQ, {playerId = playerId, roomId = roomId, tankType = tankType})
end

--请求退出准备状态
function network:requestGameCancelReady(playerId, roomId)
  local result = self:send(self.cmd_code.GAME_CANCEL_READY, {playerId = playerId, roomId = roomId})
end

--请求开始游戏
function network:requestGameBegin(roomId)
  local result = self:send(self.cmd_code.GAME_BEGIN_REQ, {roomId = roomId})
end


function network:connect(address, port)
    self.fd = netLib.Lua_connect(address, port)
end

function network:sendKey(playerId, pressedOrReleased, isRepeat, key)
    if self.fd == nil or self.playerId == nil then return end
    data = {playerId=self.playerId, roomId = "test",
            playerCommands = {{pressedOrReleased=pressedOrReleased, isRepeat=isRepeat, key=key},}}
    self:send(self.cmd_code.PLAYER_COMMAND_REPORT, data)
end
local i = 0
function network:sendSnapshot(snapshot_entities)
    if self.fd == nil or self.roomId == nil then return end
    data = {roomId = self.roomId, entities = snapshot_entities}
    self:send(self.cmd_code.ROOM_MASTER_SEND_SNAPSHOT, data)
    i = i + 1
    --print(("snapshot: %d"):format(i))
    --print(json.encode(data))
end

function network:send(type, data)
    local result = netLib.Lua_send(self.fd, type, json.encode(data))
    --print("send:")
    --print(json.encode(data))
    return result
end
-- 阻塞的receive
function network:blockingReceive()
    local data = {netLib.Lua_receive(self.fd)}
    return data
end
-- 非阻塞的receive，首先得运行startReceiving
function network:receive()
    local data = love.thread.getChannel("network"):pop()
    return data
end
-- 无限循环receive，另开一个线程
function network:startReceiving()
    if self.receive_thread == nil then
      self.receive_thread = love.thread.newThread("boom/network/endless_receiving_thread.lua")
      self.receive_thread:start()
      -- give network thread fd
      local c = love.thread.getChannel("network")
      c:push(self.fd)
    end
end
-- 发送关闭信息给“无限循环receive”线程
function network:stopReceiving()
    if not (self.receive_thread == nil) then
      local c = love.thread.getChannel("network")
      c:push("stop")
    end
end

function network:close()
    if self.fd then
      netLib.Lua_close(self.fd)
      self.fd = nil
    end
end

function network:instance()
    if self.inst == nil then
        self.inst = self:new()
    end
    return self.inst
end

return network
