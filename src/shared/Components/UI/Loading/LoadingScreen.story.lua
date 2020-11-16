local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local LoadingScreen = require(game.ReplicatedStorage.Shared.Components.UI.Loading.LoadingScreen)

return function(target)
    local testApp = LoadingScreen

    local store = Rodux.Store.new(function(state, action)
        state = state or {
            backedOut = false;
            currentScreen = "LoadingScreen";
            selectedSongKey = 1;
        }
        if action.type == "backOut" then
            return Llama.Dictionary.join(state, {
                backedOut = true
            })
        end
        return state
    end)

    testApp = RoactRodux.connect(function(state, props)
        return {
            currentScreen = state.currentScreen;
            selectedSongKey = state.selectedSongKey;
        }
    end,
    function(dispatch)
        return {
            backOut = function()
                dispatch({type = "backOut"})
            end,
        }
    end)(testApp)

    local toMount = Roact.createElement(RoactRodux.StoreProvider, {
        store = store
    }, Roact.createFragment({
        app = Roact.createElement(testApp)
    }))

    local fr = Roact.mount(toMount, target)

    return function()
        Roact.unmount(fr)
    end 
end
