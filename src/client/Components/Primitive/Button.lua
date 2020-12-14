local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Button = Roact.Component:extend("Button")

local function noop() end

function Button:init()
    self.motor = Flipper.SingleMotor.new(0);
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.onActivated = self.props.onActivated or noop
end

function Button:render()
    return Roact.createElement("TextButton", {
        Size = self.motorBinding:map(function(a)
            local sb = self.props.shrinkBy or 0.1
            return (self.props.Size or UDim2.new(1,0,1,0))-UDim2.new(sb*a, 0, sb*a, 0)
        end);
        Position = self.props.Position;
        AnchorPoint = self.props.AnchorPoint;
        Font = Enum.Font.GothamSemibold;
        Text = self.props.Text;
        TextSize = self.props.TextSize;
        BackgroundColor3 = self.motorBinding:map(function(a)
            local c = self.props.BackgroundColor3 or Color3.fromRGB(255, 255, 255);
            local db = self.props.darkenBy or 40
            local cTo = Color3.fromRGB((c.R*255)-db, (c.G*255)-db, (c.B*255)-db);
            return c:Lerp(cTo, a);
        end);
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
        [Roact.Event.MouseButton1Click] = self.onActivated;
        AutoButtonColor = false;
        TextColor3 = self.props.TextColor3;
        Visible = self.props.Visible;
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0,4);
        });
        Cdrn = Roact.createFragment(self.props[Roact.Children]);
    })
end

return Button
