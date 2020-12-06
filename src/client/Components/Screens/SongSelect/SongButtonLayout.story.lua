local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SongButtonLayout = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButtonLayout)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

return function(target)
    local songs = {}

    for itr_key, itr_data in SongDatabase:key_itr() do
        songs[itr_key] = itr_data
    end

    local testApp = Roact.createElement(SongButtonLayout, {
        songs = songs
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end