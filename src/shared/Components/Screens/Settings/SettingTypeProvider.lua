local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SettingTypeProvider = Roact.Component:extend("SettingTypeProvider")

function SettingTypeProvider:init()
    self.changeSetting = function(setting, argument)
        if setting == nil then return end
        if type(argument) == "function" then
            self.props.changeValue(setting, argument(self.props.settings[setting]))
            return
        end
        self.props.changeValue(setting, argument)
    end
end

function SettingTypeProvider:render()
    return Roact.createFragment(self.props.render(self.props.settings, self.changeSetting))
end

SettingTypeProvider = RoactRodux.connect(function(state)
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
end)(SettingTypeProvider)

return SettingTypeProvider
