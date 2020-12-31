local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SettingsGroupToggle = Roact.Component:extend("SettingsGroupToggle")

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

function SettingsGroupToggle:init()
    self.onActivated = self.props.onActivated
end

function SettingsGroupToggle:render()
    return Roact.createElement(Button, {
        Position = self.props.Position;
        AnchorPoint = self.props.AnchorPoint;
        Size = self.props.Size;
        BackgroundColor3 = self.props.selected and Color3.fromRGB(38, 181, 224) or Color3.fromRGB(20, 20, 20);
        TextScaled = true;
        Text = self.props.Text;
        TextColor3 = Color3.fromRGB(255, 255, 255);
        darkenBy = self.props.selected and nil or 10;
        onActivated = self.onActivated;
        suppressXAxis = true;
        shrinkBy = -0.025;
        LayoutOrder = self.props.LayoutOrder;
    }, {
        UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 20;
            MinTextSize = 12;
        })
    })
end

return SettingsGroupToggle
