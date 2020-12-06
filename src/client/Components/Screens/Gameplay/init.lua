local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local with = require(game.ReplicatedStorage.Client.State.with)

local GameplayMainHOC = require(script.GameplayMainHOC)

return with(function(state, props)
    return {
        isPlaying = state.gameState.isPlaying;
        stats = state.gameData.stats;
    }
end,
function(dispatch)
    return {
        backOut = function()
            dispatch({type = "setForceQuit", value = true})
        end;
        sendStatsToGlobal = function(stats)
            dispatch(Llama.Dictionary.join({type = "changeStats"}, stats))
        end;
        sendHitDevianceToGlobal = function(hit_deviance)
            dispatch({type = "setHitDeviance", value = hit_deviance})
        end
    }
end)(GameplayMainHOC)