local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)

local Slider = Roact.Component:extend("Slider")

local function noop() end

function Slider:init()
    self.motor = Flipper.SingleMotor.new(self.props.percent)
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.held = false

    self.barRef = Roact.createRef()

    self:setState({
        percent = self.props.percent
    })

    self.onDrag = self.props.onDrag or noop
end

function Slider:didUpdate(prevProps)
    if prevProps.percent ~= self.props.percent then
        self.motor:setGoal(Flipper.Spring.new(self.props.percent, {
            frequency = 8;
            dampingRatio = 2.5;
        }))
        return 
    end
    self.motor:setGoal(Flipper.Spring.new(self.state.percent, {
        frequency = 8;
        dampingRatio = 2.5;
    }))
end

function Slider:render()
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1;
        Size = self.props.Size or UDim2.new(1, 0, 1, 0);
        Position = self.props.Position;
        AnchorPoint = self.props.AnchorPoint;
    }, {
        SliderBar = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0.4, 0);
            AnchorPoint = Vector2.new(0, 0.5);
            Position = UDim2.new(0, 0, 0.5, 0);
            BackgroundColor3 = self.props.BackgroundColor3;
            [Roact.Ref] = self.barRef;
        }, {
            Corner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 180);
            });
        });
        SliderDragger = Roact.createElement("ImageButton", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://232918622";
            ImageColor3 = self.props.sliderColor3;
            Position = self.motorBinding:map(function(a)
                return UDim2.new(a/100, 0, 0.5, 0);
            end);
            Size = UDim2.new(0.25, 0, 0.75, 0);
            AnchorPoint = self.motorBinding:map(function(a)
                return Vector2.new(0.5, 0.5)
            end);
            [Roact.Event.MouseButton1Down] = function()
                self.held = true;
            end;
            [Roact.Event.InputEnded] = function(o, i)
                if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                self.held = false;
            end
        }, {
            AspectRatioContraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1;
            })
        });
        SliderSurfaceArea = Roact.createElement("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.new(2, 0, 14, 0);
            Position = UDim2.new(0.5, 0, 0.5, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            [Roact.Event.MouseMoved] = function(o, x, y)
                if self.held == false then return end

                local bar = self.barRef:getValue()

                local a = NumberUtil.InverseLerp(bar.AbsolutePosition.X, bar.AbsolutePosition.X + bar.AbsoluteSize.X, x)
                a = math.clamp(a, 0, 1)

                self:setState({
                    percent = a*100;
                })

                self.onDrag(a)
            end;
        })
    })
end


return Slider
