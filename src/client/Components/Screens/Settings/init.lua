local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SettingsMainHOC = Roact.Component:extend("SettingsMainHOC")

local SettingsMain = require(script.SettingsMain)

function SettingsMainHOC:init()
    self.changeSetting = function(setting, argument)
        if setting == nil then return end
        if type(argument) == "function" then
            self.props.changeValue(setting, argument(self.props.settings[setting]))
            return
        end
        self.props.changeValue(setting, argument)
    end
end

function SettingsMainHOC:render()
    return Roact.createElement(SettingsMain, {
        settings = self.props.settings;
        changeValue = self.changeSetting;
        history = self.props.history;
    })
end

return RoactRodux.connect(function(state)
    return {
        settings = state.gameSettings
    }
end,
function(dispatch)
    return {
        changeValue = function(setting, value)
            dispatch({type = "changeSetting", setting = setting, value = value})
        end
    }
end)(SettingsMainHOC)
