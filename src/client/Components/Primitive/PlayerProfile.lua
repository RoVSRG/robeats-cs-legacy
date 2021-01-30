local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local PlayerProfile = Roact.Component:extend("PlayerProfile")

PlayerProfile.defaultProps = {
    Size = UDim2.fromScale(1, 1);
    BackgroundColor3 = Color3.fromRGB(17,17,17);
    playerName = "testPlayer";
    rank = 1;
}

local function noop() end

function PlayerProfile:render()
    return Roact.createElement("Frame", {
        Name = "Profile";
        Size = self.props.Size;
        Position = self.props.Position;
        BackgroundColor3 = self.props.BackgroundColor3;
        ZIndex = 1;
        AnchorPoint = self.props.AnchorPoint;

    }, {
        Username = Roact.createElement("TextLabel",{
            TextXAlignment = Enum.TextXAlignment.Left;
            Text = self.props.playerName;
            TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
            Position = UDim2.fromScale(.3, .06);
            Size = UDim2.fromScale(.5,.25);
            AnchorPoint = Vector2.new(0,0);
            BackgroundTransparency = 1;
            Font = Enum.Font.GothamSemibold;
            LineHeight = 1;
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextStrokeTransparency = .5;
        });

        crnr = Roact.createElement("UICorner",{
            CornerRadius = UDim.new(0,4);
        });

        ProfileImage = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0, .5);
            AutomaticSize = Enum.AutomaticSize.None;
            BackgroundColor3 = Color3.fromRGB(11,11,11);
            BackgroundTransparency = 0;
            Position = UDim2.fromScale(.015, .5);
            Size = UDim2.fromScale(0.6, 0.9);
            Image = "rbxassetid://2944248331";
            ImageColor3 = Color3.fromRGB(255,255,255);
            --ScaleType = Enum.ScaleType.Crop;
            SliceScale = 1;
        },{
            -- UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            --     AspectRatio = 1;
            --     AspectType = Enum.AspectType.FitWithinMaxSize;
            --     DominantAxis = Enum.DominantAxis.Width;
            -- });

            Cornr = Roact.createElement("UICorner",{
                CornerRadius = UDim.new(0,4);
            });
        });

        Tier = Roact.createElement("TextLabel",{
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
            Name = "Rating";
            BackgroundTransparency = 1;
            Position = UDim2.fromScale(0.28, 0.495);
            Size = UDim2.fromScale(0.4, 0.2);
            Font = Enum.Font.GothamBold;
            LineHeight = 1;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextScaled = true;
            Text = "#1 [42.69]";
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextXAlignment = Enum.TextXAlignment.Right;
            TextYAlignment = Enum.TextYAlignment.Bottom;
            TextStrokeTransparency = 0.5;
            TextTransparency = 0.75;
            AnchorPoint = Vector2.new(1, 1);
        });
    });
end

return PlayerProfile