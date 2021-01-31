local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local ImageButton = Roact.Component:extend("ImageButton")

local function noop() end

function ImageButton:init()
    self.motor = Flipper.GroupMotor.new({
        tap = 0;
        colorR = self.props.BackgroundColor3 and self.props.BackgroundColor3.R or 1;
        colorG = self.props.BackgroundColor3 and self.props.BackgroundColor3.G or 1;
        colorB = self.props.BackgroundColor3 and self.props.BackgroundColor3.B or 1;
    });
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.onActivated = self.props.onActivated or noop
    self.onPress = self.props.onPress or noop
    self.onRelease = self.props.onRelease or noop
end

function ImageButton:didUpdate()
    self.motor:setGoal({
        colorR = Flipper.Spring.new(self.props.BackgroundColor3.R, {
            frequency = 8;
            dampingRatio = 2.5;
        });
        colorG = Flipper.Spring.new(self.props.BackgroundColor3.G, {
            frequency = 8;
            dampingRatio = 2.5;
        });
        colorB = Flipper.Spring.new(self.props.BackgroundColor3.B, {
            frequency = 8;
            dampingRatio = 2.5;
        });
    })
end

function ImageButton:render()
    return Roact.createElement("ImageButton", {
        Size = self.motorBinding:map(function(a)
            local sb = self.props.shrinkBy or 0.1
            return (self.props.Size or UDim2.new(1,0,1,0))-UDim2.new(self.props.suppressXAxis and 0 or sb*a.tap, 0, self.props.suppressYAxis and 0 or sb*a.tap, 0)
        end);
        Position = self.props.Position;
        AnchorPoint = self.props.AnchorPoint;
        Image = self.props.Image;
        ImageColor3 = self.props.ImageColor3;
        ImageRectOffset = self.props.ImageRectOffset;
        ImageRectSize = self.props.ImageRectSize;
        ImageTransparency = self.props.ImageTransparency;
        PressedImage = self.props.PressedImage;
        HoverImage = self.props.HoverImage;
        ScaleType = self.props.ScaleType;
        SliceScale = self.props.SliceScale;
        BackgroundTransparency = self.props.BackgroundTransparency;
        Rotation = self.props.Rotation;
        BackgroundColor3 = self.motorBinding:map(function(a)
            local c = Color3.new(a.colorR, a.colorG, a.colorB);
            local db = self.props.darkenBy or 40
            local cTo = Color3.fromRGB((c.R*255)-db, (c.G*255)-db, (c.B*255)-db);
            return c:Lerp(cTo, a.tap)
        end);
        [Roact.Event.MouseEnter] = function()
            self.motor:setGoal({
                tap = Flipper.Spring.new(0.7, {
                    frequency = 5;
                    dampingRatio = 1.5;
                })
            })
        end;
        [Roact.Event.MouseLeave] = function()
            self.motor:setGoal({
                tap = Flipper.Spring.new(0, {
                    frequency = 8;
                    dampingRatio = 2.5;
                })
            })
        end;
        [Roact.Event.MouseButton1Down] = function()
            self.motor:setGoal({
                tap = Flipper.Spring.new(0.9, {
                    frequency = 8;
                    dampingRatio = 2.5;
                })
            })
        end;
        [Roact.Event.MouseButton1Up] = function()
            self.motor:setGoal({
                tap = Flipper.Spring.new(0.7, {
                    frequency = 8;
                    dampingRatio = 2.5;
                })
            })
        end;
        [Roact.Event.MouseButton1Click] = self.onActivated;
        AutoButtonColor = false;
        Visible = self.props.Visible;
        LayoutOrder = self.props.LayoutOrder;
        [Roact.Event.MouseButton1Up] = self.onRelease;
        [Roact.Event.MouseButton1Down] = self.onPress
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0,4);
        });
        Cdrn = Roact.createFragment(self.props[Roact.Children]);
    })
end

return ImageButton
