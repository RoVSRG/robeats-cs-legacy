local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local ColorSetting = require(script.Parent.ColorSetting)

local ColorSettingApp = Story:new()

function ColorSettingApp:render()
    return Roact.createElement(ColorSetting, {
        title = "Note Color";
        R = 0.4;
        G = 0.5;
        B = 0.7;
    })
end

return ColorSettingApp
