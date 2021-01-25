local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local GameSettingsReducer = require(game.ReplicatedStorage.Client.State.Reducers.GameSettingsReducer)

local Settings = require(script.Parent.Settings)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local SettingsApp = Story:new()

function SettingsApp:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        App = Roact.createElement(Settings)
    })
end

function SettingsApp:init()
    self.store = Rodux.Store.new(Rodux.combineReducers({
        gameSettings = GameSettingsReducer;
    }))
end

return SettingsApp