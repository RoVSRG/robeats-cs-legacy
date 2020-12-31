local Network = require(game.ReplicatedStorage.Libraries.Network)

local Score = {}

function Score:get_map_leaderboard(id)
    return Network.GetLeaderboard:Invoke({
        mapid = id
    })
end

function Score:get_deviance_data(id, uid)
    return Network.GetDeviance:Invoke({
        mapid = id,
        userid = uid,
    })
end

return Score
