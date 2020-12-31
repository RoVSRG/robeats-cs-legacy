local with = require(game.ReplicatedStorage.Client.State.with)

local Metrics = require(game.ReplicatedStorage.Libraries.RobeatsData.Metrics)

local ResultsScreenMain = require(script.ResultsScreenMain)

local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

return with(function(state)
    local accuracy = state.gameData.stats.accuracy
    local difficulty = SongDatabase:get_difficulty_for_key(state.gameData.selectedSongKey)
    local rate = state.gameData.songRate/100

    return {
        stats = Llama.Dictionary.join(state.gameData.stats, {
            rating = Metrics.calculate_rating(rate, accuracy, difficulty)
        })
    }
end)(ResultsScreenMain)
