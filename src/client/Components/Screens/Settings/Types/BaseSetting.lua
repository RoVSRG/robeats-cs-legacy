local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local BaseSetting = Roact.Component:extend("BaseSetting")

function BaseSetting:init()
    self.getDerivedText = self.props.getDerivedText or function(value)
        return value
    end
end

function BaseSetting:render()
    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = self.props.Size or UDim2.new(0.98, 0, 0.15, 0),
    }, {
        Labl = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.0149999997, 0, 0.0500000007, 0),
            Size = UDim2.new(0.25, 0, 0.150000006, 0),
            Font = Enum.Font.GothamSemibold,
            Text = self.props.title,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 20,
            TextStrokeTransparency = 0,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }),
        Crnr = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        });
        Aspt = Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 11;
            AspectType = "ScaleWithParentSize",
            DominantAxis = "Width";
        });
        Display = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0,
            Position = UDim2.new(0.05, 0, 0.600000024, 0),
            Size = UDim2.new(0.22, 0, 0.349999994, 0),
            Font = Enum.Font.SourceSans,
            TextColor3 = Color3.fromRGB(156, 156, 156),
            TextScaled = true,
            TextSize = 14,
            TextTransparency = 1,
            TextWrapped = true,
        }, {
            c = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            l = Roact.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0.5, 0, 0.5, 0),
                Font = Enum.Font.GothamSemibold,
                Text = self.getDerivedText(self.props.value),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
            })
        }),
        Chrn = Roact.createFragment(self.props[Roact.Children]);
    })
end

return BaseSetting
