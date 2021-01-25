-- TODO: fix glitchy look lol

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ScrollingFrame = Roact.Component:extend("ScrollingFrame")

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

-- TODO: FIX ASPECT RATIO SCALING

--[[
    startIndex = floor(scrollPosition / elementHeight)
    endIndex = ceil((scrollPosition + scrollSize) / elementHeight)
]]

ScrollingFrame.defaultProps = {
    CanvasSize = UDim2.fromScale(0, 0);
    items = {},
    elementPadding = 150;
    numberOfItems = 0
}

function ScrollingFrame:init()
    self:setState({
        startIndex = 1;
        endIndex = 1;
    })

    self.objectSize = 120

    self.recalcIndexes = function(songList)
        local scrollPosition = songList.CanvasPosition
        local startIndex = math.floor(scrollPosition.Y / self.objectSize)+1;
        local endIndex = math.ceil((scrollPosition.Y + songList.AbsoluteSize.Y + self.props.elementPadding) / self.objectSize);

        if (startIndex ~= self.state.startIndex) or (endIndex ~= self.state.endIndex) then
            self:setState({
                startIndex = startIndex;
                endIndex = endIndex;
            })
        end
    end

    self.getElementForIndex = self.props.getElementForIndex

    self.listRef = Roact.createRef()
end

function ScrollingFrame:didMount()
    local _list = self.listRef:getValue()
    self.bound = SPUtil:bind_to_frame(function()
        for _, object in pairs(_list:GetChildren()) do
            self.objectSize = object.AbsoluteSize.Y
            object.Position = UDim2.fromOffset(0, (object.LayoutOrder-1)*(self.objectSize))
        end

        self.recalcIndexes(_list)
    end)
end

function ScrollingFrame:render()
    local items = {}

    if self.getElementForIndex then
        for i = self.state.startIndex, self.state.endIndex do
            pcall(function() --smh
                items["Song" .. i] = self.props.getElementForIndex(i)
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
        CanvasSize = UDim2.fromOffset(0, self.objectSize*self.props.numberOfItems),
        [Roact.Ref] = self.listRef,
        -- [Roact.Change.CanvasPosition] = self.recalcIndexes;
        -- [Roact.Change.AbsoluteSize] = self.recalcIndexes;
    }, {
        items = Roact.createFragment(items);
    })
end

function ScrollingFrame:willUnmount()
    self.bound:Disconnect()
end

return ScrollingFrame
