local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Button = Roact.Component:extend("Button")

function Button:init()
    self.motor = Flipper.SingleMotor.new(0)
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.onDown = function()
        self.motor:setGoal(Flipper.Spring.new(1, {
            frequency = 5,
            dampingRatio = 1
        }))
    end

    self.onUp = function()
        self.motor:setGoal(Flipper.Spring.new(0, {
            frequency = 0.1,
            dampingRatio = 2
        }))
    end
end

function Button:render()
    return Roact.createElement("TextButton", {
        Size = self.motorBinding:map(function(alphaDAN) -- DARK SAMBALAND / ODURU / MAKIBA / LAZORBEAMZ
            return UDim2.new(0.5,0, 0.2,0):Lerp(UDim2.new(0.4,0, 0.15,0), alphaDAN)
        end);
        Position = self.props.Position or UDim2.new(0.5,0,0.5,0);
        AnchorPoint = self.props.AnchorPoint or Vector2.new(0,0);
        [Roact.Event.MouseButton1Down] = self.onDown;
        [Roact.Event.MouseButton1Up] = self.onUp;
    })
end

function Button:willUnmount()
    self.motor:stop()
end

return Button
