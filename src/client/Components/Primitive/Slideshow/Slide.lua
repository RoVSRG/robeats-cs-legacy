local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Slide = Roact.Component:extend("Slide")

function Slide:init()
    self.motor = Flipper.SingleMotor.new(self.props.currentSlide);
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function Slide:didUpdate()
    self.motor:setGoal(Flipper.Spring.new(self.props.currentSlide, {
        dampingRatio = 2.5;
        frequency = 4;
    }))
end

function Slide:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0);
        Position = self.motorBinding:map(function(a)
            return UDim2.new(self.props.slide - a, 0, 0, 0)
        end);
        BackgroundTransparency = 1;
    }, self.props[Roact.Children])
end

return Slide
