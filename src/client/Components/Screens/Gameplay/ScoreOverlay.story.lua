local ScoreOverlay = require(script.Parent.ScoreOverlay)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local ScoreOverlayApp = Story:new()

function ScoreOverlayApp:render()
    Roact.createElement(ScoreOverlay, {
        marvs = 0;
        perfs = 0;
        greats = 0;
        goods = 0;
        bads = 0;
        misses = 0;
        score = 0;
        accuracy = 0;
        time_left = 0;
        combo = 0;
    })
end

return ScoreOverlayApp