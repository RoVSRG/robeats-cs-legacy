local GameplayMain = require(script.Parent.GameplayMain)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)

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
            marvs = 1;
            perfs = 0;
            greats = 0;
            goods = 0;
            bads = 0;
            misses = 0;
            score = 0;
            accuracy = 0;
            time_left = 0;
            combo = 0;
        }

        if action.type == "changeScoreData" then
            return Llama.Dictionary.join(state, {
                score = action.score
            })
        end

        return state
    end)

    local fr = Roact.createElement(RoactRodux.StoreProvider, {
        store = store
    }, {
        MainComponent = Roact.createElement(component)
    })

    local tree = Roact.mount(fr, target)

    SPUtil:spawn(function()
        local _score_ = 0
        while true do
            store:dispatch({
                type = "changeScoreData",
                score = _score_
            })
            _score_ += 1
            wait(2)
            if _unmount then break end
        end
    end)

    return function()
        _unmount = true
        Roact.unmount(tree)
    end
end
