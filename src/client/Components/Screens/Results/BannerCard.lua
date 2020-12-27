local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local ConditionalReturn = require(game.ReplicatedStorage.Shared.Utils.ConditionalReturn)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local BannerCard = Roact.Component:extend("BannerCard")

function BannerCard:init()
    self.motor = Flipper.GroupMotor.new({
        bg = 0;
        textTitle = 0;
        textArtist = 0;
        grade = 0;
        playedat = 0;
    })
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function BannerCard:didMount()
    self.motor:setGoal({
        bg = Flipper.Spring.new(1, {
            frequency = 1.7;
            dampingRatio = 4.5;
        });
        textTitle = Flipper.Spring.new(1, {
            frequency = 10;
            dampingRatio = 4.5;
        });
        textArtist = Flipper.Spring.new(1, {
            frequency = 7;
            dampingRatio = 4.5;
        });
        grade = Flipper.Linear.new(1, {
            velocity = 0.8;
        });
    })
    delay(0.9, function()
        self.motor:setGoal({
            playedat = Flipper.Linear.new(1, {
                velocity = 2;
            })
        })
    end)
end

function BannerCard:render()
    return Roact.createElement("ImageLabel", {
        Position = self.props.Position;
        BackgroundColor3 = Color3.fromRGB(15, 15, 15);
        BorderSizePixel = 0;
        Size = self.props.Size or UDim2.new(1,0,1,0);
        ScaleType = Enum.ScaleType.Crop;
        SliceCenter = Rect.new(-11, 0.5, 50, 0.5);
        SliceScale = 0.5;
        AnchorPoint = self.props.AnchorPoint;
        ImageTransparency = self.motorBinding:map(function(a)
            return 1-a.bg
        end);
        Image = SongDatabase:get_image_for_key(self.props.song_key);
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        PlayerInfo = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = self.motorBinding:map(function(a)
                return UDim2.new(0.02, 0, 0.55, 0):Lerp(UDim2.new(0.01, 0, 0.55, 0), a.playedat)
            end);
            TextTransparency = self.motorBinding:map(function(a)
                return 1-a.playedat
            end);
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
                Size = self.motorBinding:map(function(a)
                    return UDim2.new(0.99, 0, 0.99, 0):Lerp(UDim2.new(0.7, 0, 0.7, 0), a.grade)
                end);
                Image = self.props.grade_image or "http://www.roblox.com/asset/?id=168702873",
            })
        }),
        SongName = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = self.motorBinding:map(function(a)
                return UDim2.new(0.1, 0, 0.05, 0):Lerp(UDim2.new(0.01, 0, 0.05, 0), a.textTitle)
            end);
            TextTransparency = self.motorBinding:map(function(a)
                return 1-a.textTitle
            end);
            --Size = UDim2.new(0.5, 0, 0.15, 0),
            Size = UDim2.new(0.75, 0, 0.25, 0),
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
            Position = self.motorBinding:map(function(a)
                return UDim2.new(0.1, 0, 0.25, 0):Lerp(UDim2.new(0.01, 0, 0.25, 0), a.textArtist)
            end);
            TextTransparency = self.motorBinding:map(function(a)
                return 1-a.textArtist
            end);
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
        });
        Indicator = ConditionalReturn(not SPUtil:is_mobile(), (
            Roact.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.02, 0, 0.9, 0):Lerp(UDim2.new(0.01, 0, 0.9, 0), a.playedat)
                end);
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.playedat
                end);
                Size = UDim2.new(0.6, 0, 0.085, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("Press '%s' to return to the menu", "Enter"),
                TextColor3 = Color3.fromRGB(252, 255, 166),
                TextScaled = true,
                TextStrokeTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
        ))
    })
end

return BannerCard