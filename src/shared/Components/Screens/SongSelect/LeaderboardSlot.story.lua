local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local LeaderboardSlot = require(game.ReplicatedStorage.Shared.Components.Screens.SongSelect.LeaderboardSlot)

return function(target)
    local userid = 526993347
    local name = SPUtil:player_name_from_id(userid)
    local testApp = Roact.createElement(LeaderboardSlot, {
        userid = userid,
        playername = name,
        marvelouses = 6,
        perfects = 5,
        greats = 4,
        goods = 3,
        bads = 2,
        misses = 1,
        time = 8596444113,
        accuracy = 82,
        place = 47
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end
