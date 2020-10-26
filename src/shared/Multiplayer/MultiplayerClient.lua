local AssertType = require(game.ReplicatedStorage.Shared.AssertType)

local Network = require(game.ReplicatedStorage.Network)

local MultiplayerClient = {}

function MultiplayerClient:new(data)
    AssertType:is_non_nil(data, "Data table cannot be nil!")
    AssertType:is_string(data.id, "ID must be a string GUID!")

    local self = {}

    function self:transfer_host()

    end

    function self:upload_stats(data)

    end

    function self:are_all_players_loaded()

    end

    function self:are_all_players_finished()

    end

    function self:get_players()
        return Network.GetPlayersInRoom:Invoke({
            id = data.id
        })
    end

    function self:get_player_data()

    end

    function self:leave_room()
        Network.LeaveRoom:Fire({
            id = data.id
        })
    end

    return self
end

function MultiplayerClient:add_room(data)
    return Network.AddRoom:Invoke(data)
end

return MultiplayerClient
