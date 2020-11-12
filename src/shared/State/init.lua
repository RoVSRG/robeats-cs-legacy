local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local GameData = require(script.GameData)

local _use_debug = true


return Rodux.Store.new(Rodux.combineReducers({
    gameData = Rodux.createReducer(GameData, {
        changeScreen = function(state, action)
            return Llama.Dictionary.join(state, {
                currentScreen = action.screen
            })
        end;
        changeSelectedSongKey = function(state, action)
            return Llama.Dictionary.join(state, {
                selectedSongKey = action.songKey
            })
        end;
        changeRate = function(state, action)
            return Llama.Dictionary.join(state, {
                songRate = action.delta and state.songRate + action.delta or action.rate
            })
        end
    });
}), {}, {
    _use_debug and Rodux.loggerMiddleware or nil
})
