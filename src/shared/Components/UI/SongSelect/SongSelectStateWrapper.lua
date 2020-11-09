local Roact: Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SongSelect = require(game.ReplicatedStorage.Shared.Components.UI.SongSelect.SongSelectMain)

local SongSelectStateWrapper: RoactComponent = Roact.Component:extend("SongSelectStateWrapper")

function SongSelectStateWrapper:render()
    local wrappedComponent = RoactRodux.connect(function(state, props)
        return {
            selectedSongKey = state.gameData.selectedSongKey
        }
    end,
    function(dispatch)
        return {
            selectSongKey = function(key)
                dispatch({type = "changeSelectedSongKey", songKey = key})
            end,
        }
    end)(SongSelect)
    return Roact.createElement(wrappedComponent)
end

return SongSelectStateWrapper
