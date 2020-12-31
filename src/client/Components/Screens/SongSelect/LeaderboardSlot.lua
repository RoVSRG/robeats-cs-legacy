local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local LeaderboardSlot = Roact.Component:extend("LeaderboardSlot")

LeaderboardSlot.PlaceColors = {
	[1] = Color3.fromRGB(204, 204, 8);
	[2] = Color3.fromRGB(237, 162, 12);
	[3] = Color3.fromRGB(237, 106, 12);
}

function LeaderboardSlot:render()
    return Roact.createElement("Frame", {
        Name = "LeaderboardSlot",
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderMode = Enum.BorderMode.Inset,
        BorderSizePixel = 0,
        Size = UDim2.new(0.982, 0, 0.3, 25),
        LayoutOrder = self.props.place
    }, {
        UserThumbnail = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Position = UDim2.new(0.025, 0, 0.5, 0),
            Size = UDim2.new(0.07, 0, 0.75, 0),
            Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", self.props.userid)
        }, {
            Roact.createElement("UIAspectRatioConstraint", {
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Height,
            }),
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Place = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(54, 54, 54),
                BorderSizePixel = 0,
                Position = UDim2.new(0.0963930413, 0, 0.0963930413, 0),
                Size = UDim2.new(0.6, 0, 0.3, 0),
                Font = Enum.Font.GothamBold,
                Text = string.format("#%d", self.props.place),
                TextColor3 = Color3.fromRGB(204, 204, 8),
                TextScaled = true,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 13,
                    MinTextSize = 7,
                }),
                Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            }),
            Data = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(1.24999988, 0, 0.600000143, 0),
                Size = UDim2.new(12.7336206, 0, 0.349999994, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("Score: %d | %d / %d / %d / %d / %d / %d", self.props.score, self.props.marvelouses, self.props.perfects, self.props.greats, self.props.goods, self.props.bads, self.props.misses),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 18,
                    MinTextSize = 3,
                })
            }),
            Player = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(1.25, 0, 0, 0),
                Size = UDim2.new(15.3386288, 0, 0.550000012, 0),
                Font = Enum.Font.GothamSemibold,
                Text = self.props.playername,
                TextColor3 = Color3.fromRGB(145, 145, 145),
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 26,
                })
            });
            Accuracy = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(10, 0, 0.22, 0),
                Size = UDim2.new(1.5, 0, 0.550000012, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("%0.2f%%", self.props.accuracy),
                TextColor3 = Color3.fromRGB(145, 145, 145),
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 26,
                    MinTextSize = 7;
                })
            })
        }),
        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 9,
            AspectType = Enum.AspectType.ScaleWithParentSize,
        }),
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    })
end

return LeaderboardSlot