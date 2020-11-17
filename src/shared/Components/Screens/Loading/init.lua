local Roact: Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local LoadingScreen = require(script.LoadingScreen)

return RoactRodux.connect(function(state, props)
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
end)(LoadingScreen)
