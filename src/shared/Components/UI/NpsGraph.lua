local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactAnimate = require(game.ReplicatedStorage.Libraries.RoactAnimate)

local NpsGraph = Roact.Component:extend("NpsGraph")

function NpsGraph:didUpdate()
    self:doAnimate()
end

function NpsGraph:didMount()
    self:doAnimate()    
end

function NpsGraph:getNpsGraph()
    return SongDatabase:get_nps_graph_for_key(self.props.song_key)
end

function NpsGraph:doAnimate()
    for _, animation in pairs(self._animations) do
        RoactAnimate(animation.Animation, TweenInfo.new(animation.Time, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), animation.Size):Start()
    end
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
        self._animations[i] = {
            Animation = RoactAnimate.Value.new(UDim2.new(1/#nps_graph, 0, 0, 0));
            Size = UDim2.new(1/#nps_graph, 0, nps/(max_nps+5), 0);
            Time = (i/#nps_graph)*1.7;
        }
        elements[i] = Roact.createElement(RoactAnimate.Frame, {
            Size = self._animations[i].Animation; --nps/(max_nps+5)UDim2.new(1/#nps_graph, 0, 0, 0);--
            BackgroundColor3 = Color3.fromHSV(_h/360, 88/100, 100/100);
            BorderSizePixel = 0;
        })
    end

    return Roact.createElement("Frame", {
        Name = "NpsGraph",
        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
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
            Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
            Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
            }),
            Roact.createFragment(elements or {})
        })
    })
end

return NpsGraph