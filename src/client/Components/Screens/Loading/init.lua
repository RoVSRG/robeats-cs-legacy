local with = require(game.ReplicatedStorage.Client.State.with)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local LoadingScreen = require(script.LoadingScreen)

return with(function(state)
    return {
        isLoaded = state.gameState.isLoading == false
    }
end)(LoadingScreen)
