local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local NpsGraph = require(game.ReplicatedStorage.Client.Components.UI.NpsGraph)

local SongButton = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButton)

return function(target)
    local testApp = Roact.createElement(SongButton, {
        song_key = 1,
        artist = "hello",
        title = "it's me",
        difficulty = 1,
        image = "",
        on_click = function(song_key)
            print(song_key)
        end
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end