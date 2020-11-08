local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local TabStack = Roact.Component:extend("TabStack")

function TabStack:render()
    return Roact.createElement("Frame", {
        Visible = self.props.current_tab == self.props.tab_name;
        Size = UDim2.new(1,0,1,0);
        BackgroundTransparency = 1;
    }, self.props[Roact.Children])
end

return TabStack
