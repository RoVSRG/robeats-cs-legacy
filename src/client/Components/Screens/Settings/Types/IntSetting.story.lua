local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SettingTypeProvider  =require(script.Parent.Parent.SettingTypeProvider)
local IntSetting = require(script.Parent.IntSetting)

local GameSettingsReducer = require(game.ReplicatedStorage.Client.State.Reducers.GameSettingsReducer)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local IntSettingApp = Story:new()

function IntSettingApp:init()
    self.store = Rodux.Store.new(Rodux.combineReducers({
        gameSettings = GameSettingsReducer;
    }), {
        Rodux.loggerMiddleware
    })
end

function IntSettingApp:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store;
    }, {
        SettingTypeProvider = Roact.createElement(SettingTypeProvider, {
            render = function(settings, changeValue)
                return Roact.createElement(IntSetting, {
                    value = settings.NoteSpeed;
                    changeSetting = changeValue;
                    name = "NoteSpeed";
                    title = "Notespeed"
                })
            end
        });
    })    
end

return IntSettingApp
