local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)

local BannerCard = Roact.Component:extend("BannerCard")

function BannerCard:render()
    return Roact.createElement("ImageLabel", {
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0,
        Size = self.props.Size or UDim2.new(1,0,1,0);
        ScaleType = Enum.ScaleType.Crop,
        SliceCenter = Rect.new(-11, 0.5, 50, 0.5),
        SliceScale = 0.5,
        Image = SongDatabase:get_image_for_key(self.props.song_key)
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        PlayerInfo = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.01, 0, 0.95, 0),
            Size = UDim2.new(0.6, 0, 0.085, 0),
            Font = Enum.Font.GothamSemibold,
            Text = string.format("Played by %s at %s", self.props.playername, "1PM"),
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
            Size = UDim2.new(0.7, 0, 0.7, 0),
        }, {
            RatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            }),
            Corner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 6),
            }),
            Grade = Roact.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Selectable = true,
                Size = UDim2.new(0.7, 0, 0.7, 0),
                Image = self.props.grade_image or "http://www.roblox.com/asset/?id=168702873",
            })
        }),
        SongName = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.01, 0, 0.05, 0),
            Size = UDim2.new(0.5, 0, 0.15, 0),
            Font = Enum.Font.GothamBold,
            Text = SongDatabase:get_title_for_key(self.props.song_key),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextStrokeTransparency = 0.5,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MinTextSize = 18;
                MaxTextSize = 40;
            })
        });
        Artist = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.01, 0, 0.05*4, 0),
            Size = UDim2.new(0.5, 0, 0.15, 0),
            Font = Enum.Font.GothamBold,
            Text = SongDatabase:get_artist_for_key(self.props.song_key),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextStrokeTransparency = 0.5,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MinTextSize = 12;
                MaxTextSize = 20;
            })
        })
    })
end

return BannerCard
