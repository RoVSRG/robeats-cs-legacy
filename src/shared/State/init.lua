local Rodux: Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local GameStateReducer = require(script.Reducers.GameStateReducer)
local GameDataReducer = require(script.Reducers.GameDataReducer)
local GameSettingsReducer = require(script.Reducers.GameSettingsReducer)

local _use_debug = false --game:GetService("RunService"):IsStudio()

return Rodux.Store.new(Rodux.combineReducers({
    gameData = GameDataReducer;
    gameState = GameStateReducer;
    gameSettings = GameSettingsReducer;
}), {}, {
    _use_debug and Rodux.loggerMiddleware or nil
})
