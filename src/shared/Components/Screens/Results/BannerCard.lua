local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local BannerCard = require(game.ReplicatedStorage.Libraries.BannerCard)

function BannerCard:render()
    return Roact.createElement("ImageLabel", {
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0.300000012, 0),
        ScaleType = Enum.ScaleType.Crop,
        SliceCenter = Rect.new(-11, 0.5, 50, 0.5),
        SliceScale = 0.5,
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        PlayerInfo = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.00999999978, 0, 0.949999988, 0),
            Size = UDim2.new(0.25, 0, 0.0850000009, 0),
            Font = Enum.Font.GothamSemibold,
            Text = "Played by kisperal at 5:07PM at 10/15/2020",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 18,
            TextStrokeTransparency = 0.5,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        }),
        GradeContainer = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Position = UDim2.new(0.975000024, 0, 0.5, 0),
            Size = UDim2.new(0.699999988, 0, 0.699999988, 0),
        }, {
            RatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            }),
            Corner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 6),
            }),
            Grade = Roact.createElement("ImageLabel", {
                Name = "Grade",
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Selectable = true,
                Size = UDim2.new(0.699999988, 0, 0.699999988, 0),
                Image = "http://www.roblox.com/asset/?id=168702873",
            })
        }),
        Roact.createElement("TextLabel", {
            Name = "MapInfo",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.00999999978, 0, 0.0500000007, 0),
            Size = UDim2.new(0.5, 0, 0.150000006, 0),
            Font = Enum.Font.GothamBold,
            Text = "Monday Night Monsters",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextSize = 40,
            TextStrokeTransparency = 0.5,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    }),    
end

return BannerCard
