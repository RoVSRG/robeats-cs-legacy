local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local SettingsGroupToggle = require(script.Parent.SettingsGroupToggle)

local SettingsGroupToggleApp = Story:new()

function SettingsGroupToggleApp:render()
    return Roact.createElement(SettingsGroupToggle, {
        selected = false;
        Size = UDim2.new(1, 0, 1, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        Text = "⚙ General";
        onActivated = function()
            print("dfgoidkl ghjfrkdfghj ")
        end
    })
end

return SettingsGroupToggleApp
