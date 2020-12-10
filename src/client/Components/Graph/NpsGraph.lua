local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)

local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local NpsGraph = Roact.Component:extend("NpsGraph")

function NpsGraph:init()
    self.motor = Flipper.SingleMotor.new(0);
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function NpsGraph:didMount()
    self.motor:setGoal(Flipper.Spring.new(1, {
        frequency = 2;
        dampingRatio = 1;
    }))
end

function NpsGraph:didUpdate()
    SPUtil:spawn(function()
        self.motor:setGoal(Flipper.Instant.new(0))
        wait()
        self.motor:setGoal(Flipper.Spring.new(1, {
            frequency = 3.5;
            dampingRatio = 1.8;
        }))
    end)
end

function NpsGraph:shouldUpdate(nextProps, nextState)
    return nextProps.song_key ~= self.props.song_key
end

function NpsGraph:render()
    local elements = {}
    self._animations = {}
    local nps_graph = SongDatabase:get_nps_graph_for_key(self.props.song_key)

    local max_nps = 0
    for _, nps in pairs(nps_graph) do
        max_nps = math.max(nps, max_nps)
    end

    for i, nps in pairs(nps_graph) do
        local _h = 242*(SPUtil:tra(math.clamp(nps/38, 0, 1)))
        elements[i] = Roact.createElement("Frame", {
            Size = UDim2.new(1/#nps_graph, 0, nps/(max_nps+5));
            BackgroundColor3 = self.motorBinding:map(function(a)
                return Color3.fromHSV(_h/360, 0.88, a)
            end);
            BorderSizePixel = 0;
            ZIndex = 1;
            Position = self.motorBinding:map(function(a)
                local y = NumberUtil.Lerp(1-(i/#nps_graph), 1, 1-(a-1))
                return UDim2.new(i/#nps_graph, 0, y, 0);
            end);
            AnchorPoint = Vector2.new(0,  1)
        })
    end

    return Roact.createElement("Frame", {
        Name = "NpsGraph",
        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
        AnchorPoint = self.props.AnchorPoint
    }, {
        Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Roact.createElement("Frame", {
            Name = "Items",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 2,
        }, {
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            GraphSection = Roact.createElement("Frame", {
                Position = UDim2.new(0,0,0,0);
                Size = UDim2.new(1,0,1,0);
                BackgroundTransparency = 1;
            }, {
                Elements = Roact.createFragment(elements or {});
            }),
            MaxNpsReadout = Roact.createElement("TextLabel", {
                Text = string.format("MAX NPS: %d", max_nps);
                BackgroundColor3 = Color3.fromRGB(20,20,20);
                TextColor3 = Color3.fromRGB(255, 255, 255);
                Font = Enum.Font.GothamBold;
                TextSize = 18;
                TextScaled = true;
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a
                end);
                BackgroundTransparency = self.motorBinding:map(function(a)
                    return 1-a
                end);
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.01*a,0,0.05,0)
                end);
                Size = UDim2.new(0.3,0,0.2,0);
                AnchorPoint = Vector2.new(0, 0);
                ZIndex = 3;
            }, {
                Corner = Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                });
                TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 18;
                    MinTextSize = 8;
                })
            })
        })
    })
end

return NpsGraph