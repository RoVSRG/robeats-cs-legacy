local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Gameplay = require(script.Parent.GameplayMainHOC)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local GameplayApp = Story:new()

function GameplayApp:render()
    return Roact.createElement(Gameplay, {
        selectedSongKey = 1;
    })
end

return GameplayApp
