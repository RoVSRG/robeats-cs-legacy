-- Roact.createElement("UIGridLayout", {
--     
--     
--     
-- })

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

function SettingsGrid(props)
    return Roact.createElement("Frame", {
        Size = props.Size or UDim2.new(1,0,1,0);
        Position = props.Position;
        BackgroundTransparency = 1;
        AnchorPoint = props.AnchorPoint;
    }, {
        grid = Roact.createElement("UIGridLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder;
            CellPadding = UDim2.new(0.01, 0, 0.01, 0);
            CellSize = UDim2.new(0.49, 0, 0.2, 0);
        });
        children = Roact.createFragment(props[Roact.Children]);
    })
end

return SettingsGrid
