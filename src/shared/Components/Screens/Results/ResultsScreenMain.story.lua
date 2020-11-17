local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local ResultsScreenMain = require(script.Parent.ResultsScreenMain)

return function(target)
    local testApp = ResultsScreenMain

    local store = Rodux.Store.new(function(state, action)
        state = state or {
            stats = {
                accuracy = 0;
                maxcombo = 0;
                marvelouses = 0;
                perfects = 0;
                greats = 0;
                goods = 0;
                bads = 0;
                misses = 0;
                combo = 0;
                score = 0;
            }
        }
        return state
    end)

    testApp = RoactRodux.connect(function(state, props)
        return state
    end,
    function(dispatch)
        return {

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
