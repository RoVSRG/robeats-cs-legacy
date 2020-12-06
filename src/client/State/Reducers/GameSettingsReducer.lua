local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local GameSettings = require(script.Parent.Parent.GameSettings)

return Rodux.createReducer(GameSettings, {
    changeSetting = function(state, action)
        return Llama.Dictionary.join(state, {
            [action.setting] = action.value
        })
    end
})
