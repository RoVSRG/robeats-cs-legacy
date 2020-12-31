local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local BaseSetting = require(script.Parent.BaseSetting)

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)
local Slider = require(game.ReplicatedStorage.Client.Components.Primitive.Slider)

local BindSetting = Roact.Component:extend("BindSetting")

function BindSetting:init()
    self.changeSetting = self.props.changeSetting
    self.increment = self.props.increment or 1

    self.getDerivedText = self.props.getDerivedText or function(value)
        return "kimi is GAE"
    end;
end

function BindSetting:render()
    return Roact.createElement(BaseSetting, {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        title = self.props.title;
        value = self.props.value;
        getDerivedText = self.getDerivedText;
    }, {
        ChangeButton = Roact.createElement(Button, {
            Position = UDim2.new(0.28, 0, 0.600000024, 0),
            Size = UDim2.new(0.05, 0, 0.349999994, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            shrinkBy = 0.007;
        })
    })
end

return BindSetting
