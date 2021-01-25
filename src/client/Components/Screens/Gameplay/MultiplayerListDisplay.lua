local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local MultiplayerListDisplay = Roact.PureComponent:extend("MultiplayerListDisplay")

function MultiplayerListDisplay:render()
    return Roact.createElement("Frame", {
        Name = "MultiListDisplay",
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        BackgroundTransparency = 11,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0.0110025769, 0, 0.274802506, 0),
        Size = UDim2.new(0.233033419, 0, 0.725197434, 0),
        }, {
        Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
        Roact.createElement("Frame", {
            Name = "PlayerSlotProto",
            BackgroundColor3 = Color3.fromRGB(18, 18, 18),
            Size = UDim2.new(0.998694479, 0, 0.148615986, 0),
        }, {
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("TextLabel", {
                Name = "Place",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.0284641981, 0, 0, 0),
                Size = UDim2.new(0.249309003, 0, 0.99999994, 0),
                Font = Enum.Font.SourceSansBold,
                Text = "#1",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 45,
                    MinTextSize = 20,
                }),
                Roact.createElement("UIAspectRatioConstraint", {
                    AspectRatio = 1.1232451200485,
                })
            }),
            Roact.createElement("TextLabel", {
                Name = "PlayerName",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.240364328, 0, 0, 0),
                Size = UDim2.new(0.439070314, 0, 0.517278731, 0),
                Font = Enum.Font.SourceSansBold,
                Text = "kisperal",
                TextColor3 = Color3.fromRGB(177, 177, 177),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 45,
                    MinTextSize = 20,
                }),
                Roact.createElement("UIAspectRatioConstraint", {
                    AspectRatio = 4.4673647880554,
                })
            }),
            Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 5.2631039619446,
            }),
            Roact.createElement("TextLabel", {
                Name = "Data",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.240364328, 0, 0.516012311, 0),
                Size = UDim2.new(0.752382815, 0, 0.483987421, 0),
                Font = Enum.Font.SourceSansBold,
                Text = "Score: 12000 | Accuracy: 98%",
                TextColor3 = Color3.fromRGB(100, 100, 100),
                TextScaled = true,
                TextSize = 14,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 20,
                    MinTextSize = 12,
                })
            })
        })
    })
end

return MultiplayerListDisplay
