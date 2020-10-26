local AssertType = require(game.ReplicatedStorage.Shared.AssertType)

local Network = require(game.ReplicatedStorage.Network)
local Multiplayer = game.ServerScriptService.Multiplayer
local RoomManager = require(Multiplayer.RoomManager):new()

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

Network.AddEvent("JoinRoom"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    data.player = player

    RoomManager:join_room(data)
    Network.PlayerJoinedRoom:FireAll(data)
end)

Network.AddEvent("LeaveRoom"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    data.player = player

    RoomManager:leave_room(data)
    Network.PlayerLeftRoom:FireAll(data)
end)

Network.AddFunction("GetRooms"):Set(function()
    return RoomManager:get_rooms()
end)

Network.AddFunction("GetPlayersInRoom"):Set(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    return RoomManager.rooms:get(data.id).players:key_list()._table
end)
