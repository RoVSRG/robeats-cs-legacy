local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local GameData = require(script.GameData)

local _use_debug = true


return Rodux.Store.new(Rodux.combineReducers({
    gameData = Rodux.createReducer(GameData, {
        changeScreen = function(state, action)
            return Llama.Dictionary.join(state, {
                currentMenu = action.menu
            })
        end;
        changeSelectedSongKey = function(state, action)
            return Llama.Dictionary.join(state, {
                selectedSongKey = action.songKey
            })
        end;
    });
}), {}, {
    _use_debug and Rodux.loggerMiddleware or nil
})
