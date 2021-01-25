local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local GameData = require(script.Parent.Parent.GameData)

return Rodux.createReducer(GameData, {
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
    setHitDeviance = function(state, action)
        return Llama.Dictionary.join(state, {
            stats = Llama.Dictionary.join(state.stats, {
                hit_deviance = action.value;
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
})