local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local IntSetting = require(script.Parent.IntSetting)

local IntSettingApp = Story:new()

function IntSettingApp:render()
    return Roact.createElement(IntSetting, {
        value = 0;
        changeSetting = self.changeValue;
        name = "NoteSpeed";
        title = "Notespeed"
    })    
end

return IntSettingApp
