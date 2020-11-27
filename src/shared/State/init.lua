local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local GameState = require(script.GameState)
local GameData = require(script.GameData)

local _use_debug = false --game:GetService("RunService"):IsStudio()

return Rodux.Store.new(Rodux.combineReducers({
    gameData = Rodux.createReducer(GameData, {
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
                    accuracy = action.accuracy or state.stats.accuracy;
                    maxcombo = action.maxcombo or state.stats.maxcombo;
                    marvelouses = action.marvelouses or state.stats.marvelouses;
                    perfects = action.perfects or state.stats.perfects;
                    greats = action.greats or state.stats.greats;
                    goods = action.goods or state.stats.goods;
                    bads = action.bads or state.stats.bads;
                    misses = action.misses or state.stats.misses;
                    combo = action.combo or state.stats.combo;
                    score = action.score or state.stats.score
                })
            })
        end;
        updateTimeLeft = function(state, action)
            return Llama.Dictionary.join(state, {
                timeLeft = action.timeLeft;
            })
        end;
        setForceQuit = function(state, action)
            return Llama.Dictionary.join(state, {
                forceQuit = action.value
            })
        end
    });
    gameState = Rodux.createReducer(GameState, {
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
}), {}, {
    _use_debug and Rodux.loggerMiddleware or nil
})
