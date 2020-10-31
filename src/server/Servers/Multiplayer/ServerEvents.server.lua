local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
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

    local room = RoomManager:get_room(data.id)
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

    local room = RoomManager:get_room(data.id)
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

    local room = RoomManager:get_room(data.id)
    local is_host = room:is_host(player)

    if is_host then
       room:set_playing(true)

       for _, plr in room.players:key_itr() do
            plr:set_finished(false)
            plr:set_loading(true)
       end

       Network.GameStartedRoom:FireAll({
           id = data.id;
       })
    end
end)

Network.AddEvent("AbortGame"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    local room = RoomManager:get_room(data.id)
    local is_host = room:is_host(player)

    if is_host then
       room:set_playing(false)

       for _, plr in room.players:key_itr() do
            plr:set_loading(false)
            plr:reset_stats()
       end

       --[[Network.GameStartedRoom:FireAll({
           id = data.id;
       })]]--
    end
end)

Network.AddEvent("UploadStats"):Connect(function(player, data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")
    AssertType:is_number(data.marvelous_count, "Marvelous count must be a number!")
    AssertType:is_number(data.perfect_count, "Perfect count must be a number!")
    AssertType:is_number(data.great_count, "Great count must be a number!")
    AssertType:is_number(data.good_count, "Good count must be a number!")
    AssertType:is_number(data.bad_count, "Bad count must be a number!")
    AssertType:is_number(data.miss_count, "Miss count must be a number!")
    AssertType:is_number(data.accuracy, "Accuracy must be a number!")
    AssertType:is_number(data.max_combo, "Max combo must be a number!")
    AssertType:is_number(data.score, "Score must be a number!")
    AssertType:is_number(data.combo, "Combo must be a number!")

    local room = RoomManager:get_room(data.id)
    local player = room:get_player(player)

    player:update_stats({
        marvelous_count = data.marvelous_count;
        perfect_count = data.perfect_count;
        great_count = data.great_count;
        good_count = data.good_count;
        bad_count = data.bad_count;
        miss_count = data.miss_count;
        accuracy = data.accuracy;
        max_combo = data.max_combo;
        score = data.score;
        combo = data.combo;
    })
end)
