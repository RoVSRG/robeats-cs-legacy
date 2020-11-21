local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)

local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

local Line = require(script.Parent.Line)

local DotGraph = Roact.Component:extend("DotGraph")

function DotGraph:render()
    local dots = SPList:new()
    local lines = SPList:new()

    local data_points = self.props.points or {}

    local max_x = 0
    local max_y = 0

    for _, point in ipairs(data_points) do
        max_x = math.abs(math.max(math.abs(point.x), max_x))
        max_y = math.abs(math.max(math.abs(point.y), max_y))
    end

    for _, point in ipairs(data_points) do
        local _element = Roact.createElement("Frame", {
            Size = UDim2.new(0,3,0,3);
            Position = UDim2.new(point.x, 0, point.y, 0);
            BorderSizePixel = 0;
            BackgroundColor3 = point.color;
        })
        dots:push_back(_element)
    end

    local bounds = self.props.bounds

    if bounds and bounds.min and bounds.max then
        if bounds.min.y and bounds.max.y then
            local y_int = self.props.interval and self.props.interval.y or 10
            for y = bounds.min.y, bounds.max.y, y_int do
                if y ~= bounds.min.y and y ~= bounds.max.y then
                    local _element = Roact.createElement(Line, {
                        value = y;
                        position = NumberUtil.InverseLerp(bounds.min.y, bounds.max.y, y);
                    })
                    lines:push_back(_element)
                end
            end
        end
    end

    return Roact.createElement("Frame", {
        Size = self.props.Size or UDim2.new(1,0,1,0);
        Position = self.props.Position;
        BackgroundColor3 = self.props.BackgroundColor3 or Color3.fromRGB(35, 35, 35);
        BorderSizePixel = self.props.BorderSizePixel or 0
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0,4)
        });
        DotElements = Roact.createFragment(dots._table);
        LineElements = Roact.createFragment(lines._table)
    })
end

return DotGraph
