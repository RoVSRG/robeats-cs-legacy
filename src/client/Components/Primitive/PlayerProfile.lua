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
    tier = "Rofast";
    rating = 42.69;
    totalMapsPlayed = 1
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
            ScaleType = Enum.ScaleType.Crop;
            SliceScale = 1;
        },{
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1;
                AspectType = Enum.AspectType.FitWithinMaxSize;
                DominantAxis = Enum.DominantAxis.Width;
            });

            Cornr = Roact.createElement("UICorner",{
                CornerRadius = UDim.new(0,4);
            });
            Username = Roact.createElement("TextLabel",{
                TextXAlignment = Enum.TextXAlignment.Left;
                Text = self.props.playerName;
                TextColor3 = Color3.fromRGB(255,255,255);
                TextScaled = true;
                Position = UDim2.fromScale(1.1, .06);
                Size = UDim2.fromScale(2.24,.3);
                AnchorPoint = Vector2.new(0,0);
                BackgroundTransparency = 1;
                Font = Enum.Font.GothamSemibold;
                LineHeight = 1;
                TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                TextStrokeTransparency = .5;
            });
            Tier = Roact.createElement("TextLabel",{
                AutomaticSize = Enum.AutomaticSize.None;
                BackgroundTransparency = 1;
                Position = UDim2.fromScale(1.113, 0.4);
                Size = UDim2.fromScale(1.5,0.14);
                Font = Enum.Font.GothamSemibold;
                LineHeight = 1;
                Text = string.format("Tier: %s", self.props.tier);
                TextColor3 = Color3.fromRGB(182, 173, 173);
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextStrokeColor3 = Color3.fromRGB(0,0,0);
                TextStrokeTransparency = 0.5;
            });
            Rating = Roact.createElement("TextLabel",{
                AutomaticSize = Enum.AutomaticSize.None;
                BackgroundTransparency = 1;
                Position = UDim2.fromScale(1.113, 0.57);
                Size = UDim2.fromScale(1.77,0.14);
                Font = Enum.Font.GothamSemibold;
                LineHeight = 1;
                Text = string.format("Skill Rating: %0.2f", self.props.rating);
                TextColor3 = Color3.fromRGB(182, 173, 173);
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextStrokeColor3 = Color3.fromRGB(0,0,0);
                TextStrokeTransparency = 0.5;
            });
            TotalMapsPlayed = Roact.createElement("TextLabel",{
                AutomaticSize = Enum.AutomaticSize.None;
                BackgroundTransparency = 1;
                Position = UDim2.fromScale(1.113, 0.74);
                Size = UDim2.fromScale(1.77,0.14);
                Font = Enum.Font.GothamSemibold;
                LineHeight = 1;
                Text = string.format("Number of Maps Played: %d", self.props.totalMapsPlayed);
                TextColor3 = Color3.fromRGB(182, 173, 173);
                TextScaled = true;
                TextXAlignment = Enum.TextXAlignment.Left;
                TextStrokeColor3 = Color3.fromRGB(0,0,0);
                TextStrokeTransparency = 0.5;
            });
        });
        Rank = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1;
            TextXAlignment = Enum.TextXAlignment.Right;
            TextYAlignment = Enum.TextYAlignment.Bottom;
            Position = UDim2.fromScale(0.975, 0.975);
            AnchorPoint = Vector2.new(1, 1);
            Size = UDim2.fromScale(0.4, 0.567);
            Font = Enum.Font.Gotham;
            LineHeight = 1;
            TextColor3 = Color3.fromRGB(63, 62, 62);
            TextScaled = true;
            Text = string.format("#%d", self.props.rank, self.props.rating);
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextStrokeTransparency = 0.5;
        });
    });
end

return PlayerProfile