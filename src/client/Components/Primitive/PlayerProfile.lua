local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local PlayerProfile = Roact.Component:extend("PlayerProfile")

local function noop() end

function PlayerProfile:render()
    PlayerProfile = Roact.createElement("Frame", {
        Name = "Profile";
        Size = UDim2.fromScale(0.3, 0.15);
        Position = UDim2.fromScale(0.315, 0.02);
        BackgroundColor3 = Color3.fromRGB(17,17,17);
        ZIndex = 1;
        AnchorPoint = Vector2.new(1,0);

    }, {
        Roact.createElement("TextLabel",{
            Name = "Username";
            Text = "OnlyTwentyCharacters";
            TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
            Position = UDim2.fromScale(.31, .06);
            Size = UDim2.fromScale(.5,.25);
            AnchorPoint = Vector2.new(0,0);
            BackgroundTransparency = 1;
            Font = Enum.Font.GothamSemibold;
            LineHeight = 1;
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextStrokeTransparency = .5;
        });

        Roact.createElement("UICorner",{
            CornerRadius = UDim.new(0,4);
        });

        Roact.createElement("ImageLabel", {
            Name = "ProfileImage";
            AnchorPoint = Vector2.new(0, .5);
            AutomaticSize = Enum.AutomaticSize.None;
            BackgroundColor3 = Color3.fromRGB(11,11,11);
            BackgroundTransparency = 0;
            Position = UDim2.fromScale(.015, .5);
            Size = UDim2.fromScale(0.6, 0.9);
            Image = "rbxassetid://2944248331";
            ImageColor3 = Color3.fromRGB(255,255,255);
            ScaleType = Enum.ScaleType.Crop;
            SliceScale = 1;
        },{
            Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1;
                AspectType = Enum.AspectType.FitWithinMaxSize;
                DominantAxis = Enum.DominantAxis.Width;
            });

            Roact.createElement("UICorner",{
                CornerRadius = UDim.new(0,4);
            })
        });

        Roact.createElement("TextLabel",{
            Name = "Tier";
            AutomaticSize = Enum.AutomaticSize.None;
            BackgroundTransparency = 1;
            Position = UDim2.fromScale(0.24, 0.32);
            Size = UDim2.fromScale(0.5,0.15);
            Font = Enum.Font.GothamSemibold;
            LineHeight = 1;
            Text = "Tier 99 - Rofast";
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextScaled = true;
            TextStrokeColor3 = Color3.fromRGB(0,0,0);
            TextStrokeTransparency = 0.5;
        });

        Roact.createElement("TextLabel", {
            Name = "Rank";
            BackgroundTransparency = 1;
            Position = UDim2.fromScale(0.825,0.06);
            Size = UDim2.fromScale(0.15, 0.25);
            Font = Enum.Font.GothamBold;
            LineHeight = 1;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextScaled = true;
            Text = "#1";
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextStrokeTransparency = 0.5;
        });
    });
end

return PlayerProfile