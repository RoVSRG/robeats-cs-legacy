local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local State = require(script.Parent)

return function(component)
    return RoactRodux.connect(function(state, props)
        return {
            currentScreen = state.gameData.currentScreen;
            songRate = state.gameData.songRate
        }
    end, function(dispatch)
        return {
            changeScreen = function(screen)
                dispatch({type = "changeScreen", screen = screen})
            end
        }
    end)(component)
end
