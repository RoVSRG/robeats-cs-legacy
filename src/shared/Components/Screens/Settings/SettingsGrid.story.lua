local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SettingTypeProvider  =require(script.Parent.SettingTypeProvider)
local IntSetting = require(script.Parent.Types.IntSetting)

local SettingsGrid = require(script.Parent.SettingsGrid)

local GameSettingsReducer = require(game.ReplicatedStorage.Shared.State.Reducers.GameSettingsReducer)

return function(target)
    local store = Rodux.Store.new(Rodux.combineReducers({
        gameSettings = GameSettingsReducer;
    }), {
        Rodux.loggerMiddleware
        
    })

    Roact.setGlobalConfig({
        elementTracing = true
    })

    

    local element = Roact.createElement(SettingTypeProvider, {
        render = function(settings, changeValue)
            return Roact.createElement(SettingsGrid, nil, {
                NoteSpeed = Roact.createElement(IntSetting, {
                    value = settings.NoteSpeed;
                    changeSetting = changeValue;
                    name = "NoteSpeed"
                });
                FOV = Roact.createElement(IntSetting, {
                    value = settings.FOV;
                    changeSetting = changeValue;
                    name = "What"
                })
            })
        end
    })

    local app = Roact.createElement(RoactRodux.StoreProvider, {
        store = store;
    }, {
        SettingTypeProvider = element;
    })

    local fr = Roact.mount(app, target)

    return function()
        Roact.unmount(fr)
    end
end
