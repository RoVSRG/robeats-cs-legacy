-- Roact.createElement("UIGridLayout", {
--     
--     
--     
-- })

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SettingsList = Roact.Component:extend("SettingsList")

function SettingsList:render()
    return Roact.createElement("ScrollingFrame", {
        Size = self.props.Size or UDim2.new(0.8,0,0.1,0);
        Position = self.props.Position;
        BackgroundTransparency = 1;
        AnchorPoint = self.props.AnchorPoint;
        CanvasSize = UDim2.new(0, 0, 0, 0);
    }, {
        list = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder;
        });
        children = Roact.createFragment(self.props[Roact.Children]);
    })
end

return SettingsList
