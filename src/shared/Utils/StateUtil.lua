local AssertType = require(game.ReplicatedStorage.Shared.Utils.AssertType)

local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local StateUtil = {}

function StateUtil:new(store)
    local self = {}

    local function runIfNotEqual(a, b, _callback)
        if a ~= b then
            _callback(a, b)
        end
    end

    function self:get_state()
        return store:getState()
    end

    function self:dispatch(actionName, actionData)
        local _to_dispatch = Llama.Dictionary.join(actionData, {
            type = actionName
        })
        store:dispatch(_to_dispatch)
    end

    function self:bind_to_change(_callback)
        AssertType:is_non_nil(_callback, "Callback must be a function")
        return store.changed:connect(function(newState, oldState)
            _callback(newState, oldState, runIfNotEqual)
        end)
    end

    return self
end

return StateUtil
