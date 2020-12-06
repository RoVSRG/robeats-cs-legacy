local Gameplay = require(script.Parent.Gameplay)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local GameDataReducer = require(game.ReplicatedStorage.Client.State.Reducers.GameDataReducer)
local GameStateReducer = require(game.ReplicatedStorage.Client.State.Reducers.GameStateReducer)

return function(target)
    local store = Rodux.Store.new(Rodux.combineReducers({
        gameData = GameDataReducer;
        gameState = GameStateReducer;
    }))

    local fr = Roact.createElement(RoactRodux.StoreProvider, {
        store = store;
    }, {
        GameplayMain = Roact.createElement(Gameplay);
    })

    local tree = Roact.mount(fr, target)

    return function()
        Roact.unmount(tree)
    end
end
