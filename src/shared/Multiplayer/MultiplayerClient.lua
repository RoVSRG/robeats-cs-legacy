local AssertType = require(game.ReplicatedStorage.Shared.AssertType)

local Network = require(game.ReplicatedStorage.Network)

local MultiplayerClient = {}

function MultiplayerClient:new(data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    local self = {}

    function self:transfer_host()

    end

    function self:upload_stats(score_data)
        Network.UploadStats:Fire({
            id = data.id;
            marvelous_count = score_data.marvelous_count;
            perfect_count = score_data.perfect_count;
            great_count = score_data.great_count;
            good_count = score_data.good_count;
            bad_count = score_data.bad_count;
            miss_count = score_data.miss_count;
            accuracy = score_data.accuracy;
            max_combo = score_data.max_combo;
            score = score_data.score;
            combo = score_data.combo;
        })
    end

    function self:are_all_players_finished()

    end

    function self:get_players()
        return Network.GetPlayersInRoom:Invoke({
            id = data.id
        })
	end
	
	function self:get_room_data()
		return Network.GetRoomData:Invoke({
			id = data.id
		})
	end

    function self:get_player_stats()
		return Network.GetAllStats:Invoke({
            id = data.id;
        })
    end

    function self:leave_room()
        Network.LeaveRoom:Fire({
            id = data.id
        })
    end

    function self:was_id_this_room(id)
        return id == data.id
    end

    function self:change_song_key(song_key)
        Network.ChangeSong:Fire({
            id = data.id;
            song_key = song_key;
        })
    end

    function self:start_game()
        Network.StartGame:Fire({
            id = data.id;
        })
    end

    --Binding functions
    
    function self:bind_to_player_joined_room(_callback)
        return Network.PlayerJoinedRoom:Connect(function(passed_data)
            if self:was_id_this_room(passed_data.id) and passed_data.userid ~= game.Players.LocalPlayer.UserId then
                _callback(passed_data)
            end
        end)
    end

    function self:bind_to_player_left_room(_callback)
        return Network.PlayerLeftRoom:Connect(function(passed_data)
            if self:was_id_this_room(passed_data.id) and passed_data.userid ~= game.Players.LocalPlayer.UserId then
                _callback(passed_data)
            end
        end)
    end

    function self:bind_to_song_changed_room(_callback)
        return Network.SongChangedRoom:Connect(_callback)
    end

    function self:bind_to_host_changed_room(_callback)
        return Network.HostChangedRoom:Connect(_callback)
    end

    function self:bind_to_game_started_room(_callback)
        return Network.GameStartedRoom:Connect(function(passed_data)
            if passed_data.id == data.id then
                _callback(passed_data)
            end
        end)
    end

    function self:is_host()
        return Network.IsHost:Invoke({
            id = data.id
        })
    end

    return self
end

function MultiplayerClient:add_room(data)
    return Network.AddRoom:Invoke(data)
end

function MultiplayerClient:join_room(data)
    Network.JoinRoom:Fire({
        id = data.id
    })
end

return MultiplayerClient
