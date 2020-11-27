local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local IntSetting = Roact.Component:extend("IntSetting")

function IntSetting:init()
    SPUtil:initialize_settings_callbacks(self)
end

function IntSetting:didUpdate(prevProps, prevState)
    self.onChange(self.state.value, prevState.value)
end

function IntSetting:render()
    return Roact.createElement("Frame", {
        Name = "Notespeed",
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
    }, {
        Roact.createElement("TextButton", {
            Name = "Minus",
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 58, 58),
            BorderSizePixel = 0,
            Position = UDim2.new(0.05, 0, 0.6, 0),
            Size = UDim2.new(0.2, 0, 0.35, 0),
            Font = Enum.Font.SourceSans,
            Text = "",
            TextColor3 = Color3.fromRGB(0, 0, 0),
            TextSize = 14,
            [Roact.Event.InputBegan] = SPUtil:input_callback(function()
                self:setState(function(state)
                    return {
                        value = state.value - self.increment
                    }
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
                Text = "-",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
            })
        }),
        Roact.createElement("TextButton", {
            Name = "Plus",
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(16, 212, 82),
            BorderSizePixel = 0,
            Position = UDim2.new(0.747999966, 0, 0.600000024, 0),
            Size = UDim2.new(0.200000003, 0, 0.349999994, 0),
            Font = Enum.Font.SourceSans,
            Text = "",
            TextColor3 = Color3.fromRGB(0, 0, 0),
            TextSize = 14,
            [Roact.Event.InputBegan] = SPUtil:input_callback(function()
                self:setState(function(state)
                    return {
                        value = state.value + self.increment
                    }
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
        Roact.createElement("TextLabel", {
            Name = "Display",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 0.600000024, 0),
            Size = UDim2.new(0.449999988, 0, 0.349999994, 0),
            Font = Enum.Font.SourceSans,
            Text = "",
            TextColor3 = Color3.fromRGB(156, 156, 156),
            TextScaled = true,
            TextSize = 14,
            TextTransparency = 1,
            TextWrapped = true,
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
                Text = self.props.getText and self.props.getText(self.state.value) or self.state.value,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
            })
        }),
        Roact.createElement("TextLabel", {
            Name = "Label",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.0149999997, 0, 0.0500000007, 0),
            Size = UDim2.new(0.25, 0, 0.150000006, 0),
            Font = Enum.Font.GothamSemibold,
            Text = "Notespeed",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 20,
            TextStrokeTransparency = 0,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }),
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    })
end

return IntSetting
