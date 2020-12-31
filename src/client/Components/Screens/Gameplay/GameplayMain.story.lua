local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.Parent.GameplayMain)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local GameplayApp = Story:new()

function GameplayApp:render()
    return Roact.createElement(GameplayMain, {
        selectedSongKey = 89;
    })
end

return GameplayApp
