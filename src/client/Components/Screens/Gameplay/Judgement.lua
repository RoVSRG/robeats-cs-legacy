local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Judgement = Roact.Component:extend("Judgement")

local function judgement(name, color)
    return {name = name; color = color}
end

function Judgement:init()
    self.motor = Flipper.SingleMotor.new(0)
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.judgements = {
        [0] = judgement("Miss!", Color3.fromRGB(255, 0, 0));
        [1] = judgement("Bad", Color3.fromRGB(121, 35, 219));
        [2] = judgement("Good", Color3.fromRGB(20, 139, 194));
        [3] = judgement("Great", Color3.fromRGB(57, 238, 12));
        [4] = judgement("Perfect", Color3.fromRGB(238, 241, 16));
        [5] = judgement("Marvelous", Color3.fromRGB(255, 255, 255));
    }
end

function Judgement:render()
    return Roact.createElement("TextLabel", {
        Size = UDim2.new(0.4, 0, 0.15, 0);
        Position = UDim2.new(0.5, 0, 0.35, 0);
        Text = self.judgements[self.state.judgement] and self.judgements[self.state.judgement].name;
        TextColor3 = self.judgements[self.state.judgement] and self.judgements[self.state.judgement].color;
        TextScaled = true;
        Font = Enum.Font.GothamBold;
        BackgroundTransparency = 1;
        AnchorPoint = Vector2.new(0.5, 0.5);
    }, {
        UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
            MinTextSize = 14;
            MaxTextSize = 35;
        })
    })
end

return Judgement
