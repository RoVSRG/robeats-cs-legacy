local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Button = Roact.Component:extend("Button")

function Button:init()
    self.motor = Flipper.SingleMotor.new(0);
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function Button:render()
    return Roact.createElement("TextButton", {
        Size = self.motorBinding:map(function(a)
            return self.props.Size-UDim2.new(0.1*a, 0, 0.1*a, 0)
        end);
        Position = self.props.Position;
        AnchorPoint = self.props.AnchorPoint;
        Font = Enum.Font.GothamSemibold;
        Text = self.props.Text;
        [Roact.Event.MouseEnter] = function()
            self.motor:setGoal(Flipper.Spring.new(0.7, {
                frequency = 8;
                dampingRatio = 2.5;
            }))
        end;
        [Roact.Event.MouseLeave] = function()
            self.motor:setGoal(Flipper.Spring.new(0, {
                frequency = 8;
                dampingRatio = 2.5;
            }))
        end;
        [Roact.Event.MouseButton1Down] = function()
            self.motor:setGoal(Flipper.Spring.new(0.9, {
                frequency = 8;
                dampingRatio = 2.5;
            }))
        end;
        [Roact.Event.MouseButton1Up] = function()
            self.motor:setGoal(Flipper.Spring.new(0.7, {
                frequency = 8;
                dampingRatio = 2.5;
            }))
        end;
        AutoButtonColor = false;
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0,4);
        })
    })
end

return Button
