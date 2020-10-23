local HttpService = game:GetService("HttpService")

local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local Room = require(game.ServerScriptService.Multiplayer.Room)
local AssertType = require(game.ReplicatedStorage.Shared.AssertType)

local RoomManager = {}

function RoomManager:new()
    local self = {}
    self.rooms = SPDict:new()

    function self:add_room(data)
        AssertType:is_non_nil(data, "Data table cannot be nil!")
        AssertType:is_string(data.name, "Name must be a string!")
        AssertType:is_classname(data.player, "Player")

        local room_id = HttpService:GenerateGUID()

        local _room = Room:new(room_id)
        _room:add_player(data.player)
        _room:set_host(data.player.UserId)
        self.rooms:add(room_id, _room)
        print(HttpService:JSONEncode(self:get_rooms()))
        return room_id
    end

    function self:player_exists_in_room(plr)
        AssertType:is_classname(plr, "Player")
        return false
    end

    function self:get_rooms()
        local room_tree = SPList:new()
        
        for i, room in self.rooms:key_itr() do
            room_tree:push_back(room:get_metadata())
        end

        return room_tree._table
    end

    return self
end

return RoomManager
