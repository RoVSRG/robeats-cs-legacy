local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local SongInfoDisplay = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongInfoDisplay)

local SongInfoDisplayApp = Story:new()

function SongInfoDisplayApp:render()
    return Roact.createElement(SongInfoDisplay, {
        song_key = 18
    })
end

return SongInfoDisplayApp