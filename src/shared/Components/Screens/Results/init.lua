local with = require(game.ReplicatedStorage.Shared.State.with)

local ResultsScreenMain = require(script.ResultsScreenMain)

return with(function(state)
    return {
        stats = state.gameData.stats;
    }
end)(ResultsScreenMain)
