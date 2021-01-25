local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SettingsReducer = require(game.ReplicatedStorage.Client.State.Reducers.GameSettingsReducer)

local BindSetting = require(script.Parent.BindSetting)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local BindSettingApp = Story:new()

function BindSettingApp:init()
    self.store = Rodux.Store.new(SettingsReducer)
end

function BindSettingApp:render()
    local bindSettingComponent = RoactRodux.connect(function(state)
        return {
            bindingProps = {
                {
                    title = "Track 1",
                    value = state.Keybind1;
                    name = "Keybind1"
                },
                {
                    title = "Track 2",
                    value = state.Keybind2;
                    name = "Keybind2"
                },
                {
                    title = "Track 3",
                    value = state.Keybind3;
                    name = "Keybind3"
                },
                {
                    title = "Track 4",
                    value = state.Keybind4;
                    name = "Keybind4"
                }
            }
        }
    end, function(dispatch)
        return {
            changeSetting = function(setting, value)
                dispatch({type = "changeSetting", setting = setting, value = value})
            end
        }
    end)(BindSetting)

    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        bindSettingComponent = Roact.createElement(bindSettingComponent, {
            title = "Keybinds"
        });
    })
end

return BindSettingApp
