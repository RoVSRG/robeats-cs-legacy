local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local DataDisplay = Roact.Component:extend("DataDisplay")

function DataDisplay:init()
    self.motor = Flipper.SingleMotor.new(0);

    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function DataDisplay:didMount()
    delay(0.5, function()
        self.motor:setGoal(Flipper.Spring.new(1, {
            frequency = 17;
            dampingRatio = 5;
        }))
    end)
end

function DataDisplay:render()
    local data = self.props.data or {}

    local toMountElements = {}

    for i = 1, #data do
        local v = data[i]
        local dataValue = v.Value
        toMountElements[i] = Roact.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(i/#data,0,0,0),
            Size = UDim2.new(1/#data, 0, 1, 0)
        }, {
            DataName = Roact.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0.3, 0),
                Size = UDim2.new(0.5, 0, 0.3, 0),
                Font = Enum.Font.GothamSemibold,
                Text = v.Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextStrokeTransparency = 0.5,
            }, {
                TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 12;
                    MaxTextSize = 60;
                })
            }),
            DataValue = Roact.createElement("TextLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.2, 0, 0.7, 0):Lerp(UDim2.new(0.5, 0, 0.7, 0), a)
                end),
                Size = UDim2.new(0.5, 0, 0.35, 0),
                Font = Enum.Font.GothamSemibold,
                Text = dataValue,
                TextColor3 = Color3.fromRGB(150, 150, 150),
                TextScaled = true,
                TextStrokeTransparency = 0.5,
                TextTransparency = self.motorBinding:map(function(a) return 1-a end);
            }, {
                TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 12;
                    MaxTextSize = 26;
                })
            });
        })
    end

    return Roact.createElement("Frame", {
        Name = "DataContainer",
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        Position = self.props.Position or UDim2.new(0, 0, 0, 0),
        Size = self.props.Size or UDim2.new(1, 0, 1, 0),
        AnchorPoint = self.props.AnchorPoint,
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 6),
        }),
        ListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
        DataItems = Roact.createFragment(toMountElements)
    })
end

return DataDisplay
