local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local LeaderboardDisplay = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.LeaderboardDisplay)

return function(target)
    local testApp = Roact.createElement(LeaderboardDisplay, {
        leaderboard = {
            {
                userid = 526993347,
                playername = "kisperal",
                marvelouses = 6,
                perfects = 5,
                greats = 4,
                goods = 3,
                bads = 2,
                misses = 1,
                time = 1596444113,
                accuracy = 98.98,
                place = 1
            },
            {
                userid = 160677253,
                playername = "DetWasTaken",
                marvelouses = 6,
                perfects = 5,
                greats = 4,
                goods = 3,
                bads = 2,
                misses = 1,
                time = 1596666465,
                accuracy = 95.67,
                place = 2
            }
        }
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end
