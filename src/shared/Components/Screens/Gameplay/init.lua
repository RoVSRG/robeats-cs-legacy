local Roact: Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local Gameplay = require(script.GameplayMain)

return RoactRodux.connect(function(state, props)
    return {
        selectedSongKey = state.gameData.selectedSongKey;
        stats = Llama.Dictionary.join(state.gameData.stats, {
            time_left = state.gameData.timeLeft
        })
    }
end,
function(dispatch)
    return {
        backOut = function()
            dispatch({type = "setForceQuit", value = true})
        end
    }
end)(Gameplay)