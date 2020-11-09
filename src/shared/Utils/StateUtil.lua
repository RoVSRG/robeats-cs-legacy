local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local StateUtil = {}

function StateUtil:new(store)
    local self = {}

    function self:get_state()
        return store:getState()
    end

    function self:dispatch(actionName, actionData)
        local _to_dispatch = Llama.Dictionary.join(actionData, {
            type = actionName
        })
        store:dispatch(_to_dispatch)
    end

    return self
end

return StateUtil
