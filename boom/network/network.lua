local netLib = require "library"
--local netLib = require "libtcp"
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
  },
  is_connected = false
}

function network:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

-- 分发网络事件
function network:update(dt)
    if self.is_connected then
      self:updateReceive(dt)
    end
end

function network:updateReceive(dt)
  local msg = self:receive()
  if msg then
    for _, json_string in pairs(msg) do
      --print("receive:")
      --print(json_string)
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

function network:connect(address, port)
    self.is_connected = netLib.Lua_connect(address, port)
end

function network:sendKey(playerId, pressedOrReleased, isRepeat, key)
    if not self.is_connected or self.playerId == nil then return end
    data = {playerId=self.playerId, roomId = "test",
            playerCommands = {{pressedOrReleased=pressedOrReleased, isRepeat=isRepeat, key=key},}}
    self:send(self.cmd_code.PLAYER_COMMAND_REPORT, data)
end

local i = 0
function network:sendSnapshot(snapshot_entities)
    if not self.is_connected or self.roomId == nil then return end
    data = {roomId = self.roomId, entities = snapshot_entities}
    self:send(self.cmd_code.ROOM_MASTER_SEND_SNAPSHOT, data)
    i = i + 1
    --print(("snapshot: %d"):format(i))
    --print(json.encode(data))
end

function network:send(type, data)
    assert(self.is_connected==true)
    if self.is_connected then
        local result = netLib.Lua_send(type, json.encode(data))
        --print("send:")
        --print(json.encode(data))
        return result
    end
    return nil
end
-- 阻塞的receive
function network:blockingReceive()
    assert(self.is_connected==true)
    if self.is_connected then
        local data = {netLib.Lua_receive()}
        return data
    end
    return nil
end
-- 非阻塞的receive，首先得运行startReceiving
function network:receive()
    assert(self.is_connected==true)
    if self.is_connected then
        if self.receive_thread == nil then
            self:startReceiving()
        end
        local data = love.thread.getChannel("network"):pop()
        return data
    end
    return nil
end
-- 无限循环receive，另开一个线程
function network:startReceiving()
    assert(self.is_connected==true)
    if self.is_connected then
        if self.receive_thread == nil then
          self.receive_thread = love.thread.newThread("boom/network/endless_receiving_thread.lua")
          self.receive_thread:start()
          -- give network thread fd
          self.network_channel = love.thread.getChannel("network")
        end
    end
end
-- 发送关闭信息给“无限循环receive”线程
function network:stopReceiving()
    assert(self.is_connected==true)
    if self.receive_thread ~= nil then
      local c = love.thread.getChannel("network")
      c:push("stop")
    end
end

function network:close()
    assert(self.is_connected==true)
    if self.is_connected then
      netLib.Lua_close()
      self.is_connected = false
    end
end

function network:instance()
    if self.inst == nil then
        self.inst = self:new()
    end
    return self.inst
end

return network
