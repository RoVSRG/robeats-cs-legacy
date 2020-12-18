local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Gameplay = require(script.Parent.GameplayMainHOC)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local GameplayApp = Story:new()

function GameplayApp:render()
    return Roact.createElement(Gameplay, {
        stats = {
            accuracy = 0;
            maxcombo = 0;
            marvelouses = 0;
            perfects = 0;
            greats = 0;
            goods = 0;
            bads = 0;
            misses = 0;
            combo = 0;
            score = 0;
        }
    })
end

return GameplayApp
