local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SpreadBar = Roact.Component:extend("SpreadBar")

function SpreadBar:getAlpha()
    return self.props.total > 0 and self.props.count/self.props.total or 0
end

function SpreadBar:didMount()
    self.motor:setGoal(Flipper.Spring.new(self:getAlpha(), {
        frequency = 4;
        dampingRatio = 2.5;
    }))
end

function SpreadBar:init()
    self.motor = Flipper.SingleMotor.new(0);

    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function SpreadBar:didUpdate()
    self.motor:setGoal(Flipper.Spring.new(self:getAlpha(), {
        frequency = 4;
        dampingRatio = 2.5;
    }))
end

function SpreadBar:render()
    local h, s, v = self.props.color:ToHSV()
    local total_color = Color3.fromHSV(h, s, ((v-5)%100)/100)
    return Roact.createElement("Frame", {
        BackgroundColor3 = self.props.color,
        LayoutOrder = self.props.LayoutOrder,
        BorderSizePixel = 0,
        Size = self.props.Size or UDim2.new(1, 0, 1, 0);
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Total = Roact.createElement("Frame", {
            BackgroundColor3 = total_color,
            BorderSizePixel = 0,
            Size = self.motorBinding:map(function(a)
                return UDim2.new(a, 0, 1, 0)
            end)
        }, {
            Corner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
        }),
        TotalCount = Roact.createElement("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderColor3 = Color3.fromRGB(27, 42, 53),
            BorderSizePixel = 0,
            Position = UDim2.new(0.95, 0, 0.5, 0),
            Size = UDim2.new(0.35, 0, 1, 0),
            ZIndex = 2,
            Font = Enum.Font.GothamSemibold,
            Text = self.props.count,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            TextStrokeTransparency = 0.5,
        }, {
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 25;
                MinTextSize = 9;
            })
        }),
    })
end

return SpreadBar
