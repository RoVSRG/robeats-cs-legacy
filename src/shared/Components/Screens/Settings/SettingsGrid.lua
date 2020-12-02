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
    }, {
        grid = Roact.createElement("UIGridLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder;
            CellPadding = UDim2.new(0.00999999978, 0, 0.00999999978, 0);
            CellSize = UDim2.new(0.49000001, 0, 0.200000003, 0);
        });
        children = Roact.createFragment(props[Roact.Children]);
    })
end

return SettingsGrid
