local with = require(game.ReplicatedStorage.Client.State.with)

local MultiplayerLobby = require(script.MultiplayerLobby)

return with(function(state)
    return {
        isLoaded = state.gameState.isLoading == false
    }
end)(MultiplayerLobby)
