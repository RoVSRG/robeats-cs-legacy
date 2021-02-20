local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Score = Roact.Component:extend("Score")

function Score:init()
    self.motor = Flipper.SingleMotor.new(self.props.score);
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function Score:didUpdate()
    self.motor:setGoal(Flipper.Spring.new(self.props.score, {
        frequency = 20;
        dampingRatio = 2.5;
    }))
end

function Score:render()
    return Roact.createElement("TextLabel", {
        Name = "ScoreDisplay",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
        Font = Enum.Font.GothamSemibold,
        Text = self.motorBinding:map(function(a)
            return math.floor(a)
        end);
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextSize = 40,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, {
        Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 50,
            MinTextSize = 20,
        })
    })
end


return Score