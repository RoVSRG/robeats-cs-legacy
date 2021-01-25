local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local MusicBox = Roact.Component:extend("ComponentName")

function noop()
    
end

function MusicBox:render()
    return Roact.createElement("Frame", {
        Name = "Profile";
        Size = UDim2.fromScale(0.35, 0.15);
        Position = UDim2.fromScale(0.99, 0.02);
        BackgroundColor3 = Color3.fromRGB(17,17,17);
        ZIndex = 1;
        AnchorPoint = Vector2.new(1,0);
        --time to win
    }, {
        Corner = Roact.createElement("UICorner",{
            CornerRadius = UDim.new(0,4);
        });

        SongName = Roact.createElement("TextLabel",{
            Name = "SongName";
            Text = "bobux man - bobux dance";
            TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
            Position = UDim2.fromScale(.25, .06);
            Size = UDim2.fromScale(.5,.25);
            AnchorPoint = Vector2.new(0,0);
            BackgroundTransparency = 1;
            Font = Enum.Font.GothamSemibold;
            LineHeight = 1;
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            TextStrokeTransparency = .5;
        })
    });
end

return MusicBox