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
    return _id
end)

Network.AddEvent("JoinRoom"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

end)

Network.AddFunction("GetRooms"):Get(function()
    return RoomManager:get_rooms()
end)
