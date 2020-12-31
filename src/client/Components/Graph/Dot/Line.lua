local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)

local Line = Roact.Component:extend("Line")

function Line:render()
    return Roact.createFragment({
        Line = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(1,0);
            Size = UDim2.new(0.98,0,0,1);
            BorderSizePixel = 0;
            BackgroundTransparency = 0;
            BackgroundColor3 = Color3.fromRGB(40,40,40);
            Position = UDim2.new(1,0,self.props.position,0)
        });
        ValueText = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(1,0.5);
            BackgroundTransparency = 1;
            Position = UDim2.new(0.02,0,self.props.position,0);
            Size = UDim2.new(0.017,0,0.03,0);
            TextScaled = true;
            Text = self.props.value;
            Font = Enum.Font.GothamSemibold;
            TextColor3 = Color3.fromRGB(35, 35, 35);
        }, {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 14;
                MinTextSize = 3;
            })
        })
    })
end

return Line
