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

        if self:player_exists_in_room(data.player) then return false end

        local room_id = HttpService:GenerateGUID()

        local _room = Room:new(room_id)
        _room:add_player(data.player)
		_room:set_host(data.player.UserId)
		_room:set_name(data.player.Name .. "'s Room")
        self.rooms:add(room_id, _room)
        return room_id
    end

    function self:player_exists_in_room(plr)
        AssertType:is_classname(plr, "Player")
        for i, room in self.rooms:key_itr() do
            if room.host == plr.UserId then return true end
        end
        return false
    end

    function self:get_rooms()
        local room_tree = SPList:new()
        
        for i, room in self.rooms:key_itr() do
            room_tree:push_back(room:get_metadata())
        end

        return room_tree._table
    end

    function self:get_room(id)
        return self.rooms:get(id)
    end

    function self:join_room(data)
        AssertType:is_non_nil(data, "Data table cannot be nil!")
        AssertType:is_string(data.id, "ID must be a string GUID!")
        AssertType:is_classname(data.player, "Player")

        self.rooms:get(data.id):add_player(data.player)
    end

    function self:leave_room(data)
        AssertType:is_non_nil(data, "Data table cannot be nil!")
        AssertType:is_string(data.id, "ID must be a string GUID!")
        AssertType:is_classname(data.player, "Player")

        self.rooms:get(data.id):remove_player(data.player)
        return #self.rooms:get(data.id):get_metadata().players == 0
    end

    function self:remove_room(data)
        AssertType:is_non_nil(data, "Data table cannot be nil!")
        AssertType:is_string(data.id, "ID must be a string GUID!")

        self.rooms:remove(data.id)
    end

    return self
end

return RoomManager:new()
