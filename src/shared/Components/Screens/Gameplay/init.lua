local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local with = require(game.ReplicatedStorage.Shared.State.with)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.GameplayMain)

local GameplayMainHOC = Roact.Component:extend("GameplayMainHOC")

function GameplayMainHOC:init()
    
end

function GameplayMainHOC:render()
    return Roact.createElement(GameplayMain, self.props, self.props[Roact.Children])
end

function GameplayMainHOC:willUnmount()

end

return with(function(state, props)
    return {
        stats = Llama.Dictionary.join(state.gameData.stats, {
            time_left = state.gameData.timeLeft
        });
        isPlaying = state.gameState.isPlaying;
    }
end,
function(dispatch)
    return {
        backOut = function()
            dispatch({type = "setForceQuit", value = true})
        end
    }
end)(GameplayMainHOC)