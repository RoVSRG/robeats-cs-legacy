local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local LeaderboardDisplay = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.LeaderboardDisplay)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local LeaderboardDisplayApp = Story:new()

function LeaderboardDisplayApp:render()
    return Roact.createElement(LeaderboardDisplay, {
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
                place = 1,
                score = 0
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
                place = 2,
                score = 0
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
                place = 3,
                score = 0
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
                place = 4,
                score = 0
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
                place = 5,
                score = 0
            },
        };
        Size = UDim2.new(1, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
    })
end

return LeaderboardDisplayApp
