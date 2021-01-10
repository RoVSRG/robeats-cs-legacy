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
end

function ScrollingFrame:render()
    local items = {}

    if self.getElementForIndex then
        for i = self.state.startIndex, self.state.endIndex do
            table.insert(items, i, self.props.getElementForIndex(i))
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
    }, items)
end

return ScrollingFrame
