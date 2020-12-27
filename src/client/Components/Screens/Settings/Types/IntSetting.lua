local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local IntSetting = Roact.Component:extend("IntSetting")

local BaseSetting = require(script.Parent.BaseSetting)

local Slider = require(script.Parent.Parent.Parent.Parent.Primitive.Slider)

local ConditionalReturn = require(game.ReplicatedStorage.Shared.Utils.ConditionalReturn)

local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)

function IntSetting:init()
    self.changeSetting = self.props.changeSetting
    self.increment = self.props.increment or 1

    self.getDerivedText = self.props.getDerivedText or function(value)
        return value >= 0 and "+"..value or value
    end;
end

function IntSetting:render()
    return Roact.createElement(BaseSetting, {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        title = self.props.title;
        value = self.props.value;
        getDerivedText = self.getDerivedText;
    }, {
        ConditionalReturn(not self.props.useSlider, Roact.createFragment({
            Minus = Roact.createElement("TextButton", {
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 58, 58),
                BorderSizePixel = 0,
                Position = UDim2.new(0.39, 0, 0.6, 0),
                Size = UDim2.new(0.05, 0, 0.35, 0),
                Font = Enum.Font.SourceSans,
                Text = "",
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextSize = 14,
                [Roact.Event.InputBegan] = SPUtil:input_callback(function()
                    self.changeSetting(self.props.name, function(o_value)
                        return o_value - self.increment
                    end)
                end)
            }, {
                Corner = Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                }),
                Label = Roact.createElement("TextLabel", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = "-",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                })
            }),
            Plus = Roact.createElement("TextButton", {
                Name = "Plus",
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Color3.fromRGB(16, 212, 82),
                BorderSizePixel = 0,
                Position = UDim2.new(0.28, 0, 0.600000024, 0),
                Size = UDim2.new(0.05, 0, 0.349999994, 0),
                Font = Enum.Font.SourceSans,
                Text = "",
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextSize = 14,
                [Roact.Event.InputBegan] = SPUtil:input_callback(function()
                    self.changeSetting(self.props.name, function(o_value)
                        return o_value + self.increment
                    end)
                end)
            }, {
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                }),
                Roact.createElement("TextLabel", {
                    Name = "Label",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Font = Enum.Font.GothamSemibold,
                    Text = "+",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    TextSize = 14,
                    TextWrapped = true,
                })
            }),
        }));
        ConditionalReturn(self.props.useSlider, Roact.createFragment({
            Slider = Roact.createElement(Slider, {
                onDrag = function(pct)
                    self.changeSetting(self.props.name, NumberUtil.Lerp(self.props.minValue, self.props.maxValue, pct))
                end;
                percent = self.props.initialPercent;
                Size = UDim2.new(0.58,0,0.5,0);
                Position = UDim2.new(0.3, 0, 0.6, 0);
                AnchorPoint = Vector2.new(0, 0.5);
                BackgroundColor3 = Color3.fromRGB(45,45,45);
            })
        }))
    })
end

return IntSetting
