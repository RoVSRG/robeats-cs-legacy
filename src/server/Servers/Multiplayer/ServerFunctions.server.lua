local AssertType = require(game.ReplicatedStorage.Shared.AssertType)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)

local Network = require(game.ReplicatedStorage.Network)
local Multiplayer = game.ServerScriptService.Multiplayer
local RoomManager = require(Multiplayer.RoomManager)

Network.AddFunction("AddRoom"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.name, "Name must be a string!")
    AssertType:is_classname(player, "Player")

    data.player = player

    local _id = RoomManager:add_room(data)

    if _id == false then player:Kick("Cheating detected!") end

    Network.RoomCreated:FireAll(RoomManager.rooms:get(_id):get_metadata())

    return _id
end)

Network.AddFunction("GetRooms"):Set(function()
    return RoomManager:get_rooms()
end)

Network.AddFunction("GetPlayersInRoom"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    return RoomManager.rooms:get(data.id).players:key_list()._table
end)

Network.AddFunction("GetRoomData"):Set(function(player, data)
	AssertType:is_non_nil(data, "Data table cannot be nil!")
	AssertType:is_string(data.id, "ID must be a string GUID!")
	return RoomManager.rooms:get(data.id)
end)

Network.AddFunction("IsHost"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    
    return RoomManager.rooms:get(data.id):is_host(player)
end)

Network.AddFunction("AllPlayersLoaded"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    for _, plr in RoomManager:get_room(data.id).players:key_itr() do
        print(DebugOut:puts_table(plr))
        if plr.loading then return false end
    end

    return true
end)

Network.AddFunction("AllPlayersFinished"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    for _, plr in RoomManager:get_room(data.id).players:key_itr() do
        print(DebugOut:puts_table(plr))
        if plr.finished then return false end
    end

    return true
end)

Network.AddFunction("GetStats"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    AssertType:is_number(data.userid, "User ID must be a number!")
    
    return RoomManager:get_room(data.id):get_player(player):get_stats() --broken
end)

Network.AddFunction("GetAllStats"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    return RoomManager:get_room(data.id):get_player_stats()
end)
