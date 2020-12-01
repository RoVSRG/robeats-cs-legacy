local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local GameState = require(script.Parent.Parent.GameState)

return Rodux.createReducer(GameState, {
    setIsLoading = function(state, action)
        return Llama.Dictionary.join(state, {
            isLoading = action.value;
        })
    end;
    setIsPlaying = function(state, action)
        return Llama.Dictionary.join(state, {
            isPlaying = action.value;
        })
    end;
})