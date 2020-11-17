local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local GameData = require(script.GameData)

local _use_debug = game:GetService("RunService"):IsStudio()

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
        end;
        changeStats = function(state, action)
            return Llama.Dictionary.join(state, {
                stats = Llama.Dictionary.join(state.stats, {
                    accuracy = action.accuracy;
                    maxcombo = action.maxcombo;
                    marvelouses = action.marvelouses;
                    perfects = action.perfects;
                    greats = action.greats;
                    goods = action.goods;
                    bads = action.bads;
                    misses = action.misses;
                    combo = action.combo;
                    score = action.score
                })
            })
        end;
        updateTimeLeft = function(state, action)
            return Llama.Dictionary.join(state, {
                timeLeft = action.timeLeft;
            })
        end
    });
}), {}, {
    _use_debug and Rodux.loggerMiddleware or nil
})
