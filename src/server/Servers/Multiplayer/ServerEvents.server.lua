local AssertType = require(game.ReplicatedStorage.Shared.AssertType)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)

local Network = require(game.ReplicatedStorage.Network)
local Multiplayer = game.ServerScriptService.Multiplayer
local RoomManager = require(Multiplayer.RoomManager)

Network.AddEvent("JoinRoom"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    data.player = player

    RoomManager:join_room(data)

    data.userid = player.UserId

    Network.PlayerJoinedRoom:FireAll(data)
end)

Network.AddEvent("LeaveRoom"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    data.player = player

    local should_remove = RoomManager:leave_room(data)

    if should_remove then
        data.player = nil
        RoomManager:remove_room(data)
        Network.RoomDeleted:FireAll(data)
        return
    end

    data.player = nil
    data.userid = player.UserId

    Network.PlayerLeftRoom:FireAll(data)
end)

Network.AddEvent("ChangeSong"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    AssertType:is_number(data.song_key, "Song key must be passed!")

    local room = RoomManager.rooms:get(data.id)
    local is_host = room:is_host(player)

    if is_host and SongDatabase:contains_key(data.song_key) then
       room:change_song_key(data.song_key)
       Network.SongChangedRoom:FireAll({
            id = data.id;
            song_key = data.song_key;
        })
    end
end)

Network.AddEvent("ChangeHost"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    AssertType:is_number(data.userid, "UserID must be a number!")

    local room = RoomManager.rooms:get(data.id)
    local is_host = room:is_host(player)

    if is_host then
        room:set_host(data.userid)
        Network.HostChangedRoom:FireAll({
            id = data.id;
            userid = data.userid;
        })
    end
end)

Network.AddEvent("StartGame"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
end)
