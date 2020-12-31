local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Tab = Roact.Component:extend("Tab")

function Tab:render()
    return Roact.createElement("Frame", {
        Visible = self.props.current_tab == self.props.tab_name;
        Size = UDim2.new(1,0,1,0);
        BackgroundTransparency = 1;
    }, self.props[Roact.Children])
end

return Tab