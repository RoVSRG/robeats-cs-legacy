-- TODO: fix glitchy look lol

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ScrollingFrame = Roact.Component:extend("ScrollingFrame")

-- TODO: FIX ASPECT RATIO SCALING

--[[
    startIndex = floor(scrollPosition / elementHeight)
    endIndex = ceil((scrollPosition + scrollSize) / elementHeight)
]]

ScrollingFrame.defaultProps = {
    CanvasSize = UDim2.fromScale(0, 0);
    items = {},
    elementPadding = 0;
    elementSize = 125;
}

function ScrollingFrame:init()
    self:setState({
        startIndex = 1;
        endIndex = 1;
    })

    self.recalcIndexes = function(songList)
        local scrollPosition = songList.CanvasPosition
        local startIndex = math.floor(scrollPosition.Y / self.props.elementSize)+1;
        local endIndex = math.ceil((scrollPosition.Y + songList.AbsoluteSize.Y + self.props.elementPadding) / self.props.elementSize);

        self:setState({
            startIndex = startIndex;
            endIndex = endIndex;
        })
    end

    self.getElementForIndex = self.props.getElementForIndex

    self.listRef = Roact.createRef()
end

function ScrollingFrame:didMount()
    local _list = self.listRef:getValue()
    _list:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        _list.ScrollStretchOffset.Size = UDim2.fromOffset(0, (self.state.startIndex-1)*self.props.elementSize);
    end)
end

function ScrollingFrame:render()
    local items = {}

    if self.getElementForIndex then
        print(math.clamp(self.state.endIndex+8, 1, self.state.endIndex))
        for i = self.state.startIndex, self.state.endIndex+20 do
            pcall(function() --smh
                table.insert(items, i, self.props.getElementForIndex(i))
            end)
        end
    end

    return Roact.createElement("ScrollingFrame", {
        Active = self.props.Active,
        BackgroundTransparency = self.props.BackgroundTransparency;
        BorderSizePixel = self.props.BorderSizePixel,
        Position = self.props.Position,
        Size = self.props.Size,
        BottomImage = self.props.BottomImage,
        ScrollBarThickness = self.props.ScrollBarThickness,
        TopImage = self.props.TopImage,
        VerticalScrollBarPosition = self.props.VerticalScrollBarPosition,
        CanvasSize = self.props.CanvasSize,
        [Roact.Ref] = self.listRef,
        [Roact.Change.CanvasPosition] = self.recalcIndexes;
        [Roact.Change.AbsoluteSize] = self.recalcIndexes;
    }, {
        items = Roact.createFragment(items);
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0, 5);
            SortOrder = Enum.SortOrder.LayoutOrder;
        });
        ScrollStretchOffset = Roact.createElement("Frame", {
            BackgroundTransparency = 1;
            LayoutOrder = -1;
        })
    })
end

return ScrollingFrame
