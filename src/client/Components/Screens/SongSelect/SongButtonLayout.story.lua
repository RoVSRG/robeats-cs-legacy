local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SongButtonLayout = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButtonLayout)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local SongButtonLayoutApp = Story:new()

function SongButtonLayoutApp:init()
    self.songs = {}

    for itr_key, itr_data in SongDatabase:key_itr() do
        self.songs[itr_key] = itr_data
    end
end

function SongButtonLayoutApp:render()
    return Roact.createElement(SongButtonLayout, {
        songs = self.songs;
        Size = UDim2.new(1,0,1,0)
    })
end

return SongButtonLayoutApp
