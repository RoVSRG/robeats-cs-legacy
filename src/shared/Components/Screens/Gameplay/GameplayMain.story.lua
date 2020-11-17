local GameplayMain = require(script.Parent.GameplayMain)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

return function(target)
    local _unmount = false
    local component = RoactRodux.connect(function(state, props)
        return state
    end, function(dispatch)
        return {
            backOut = function()
                -- TODO: add back out callback
            end
        }
    end)(GameplayMain)

    local store = Rodux.Store.new(function(state, action)
        state = state or {
            stats = {
                marvelouses = 1;
                perfects = 0;
                greats = 0;
                goods = 0;
                bads = 0;
                misses = 0;
                score = 0;
                accuracy = 0;
                time_left = 0;
                combo = 0;
            }
        }

        return state
    end)

    local fr = Roact.createElement(RoactRodux.StoreProvider, {
        store = store
    }, {
        MainComponent = Roact.createElement(component)
    })

    local tree = Roact.mount(fr, target)

    return function()
        _unmount = true
        Roact.unmount(tree)
    end
end
