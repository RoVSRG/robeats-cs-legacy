local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SpreadBar = require(script.Parent.SpreadBar)

local SpreadDisplay = Roact.Component:extend("SpreadDisplay")

function SpreadDisplay:render()
    local total_count = self.props.marvelouses + self.props.perfects + self.props.greats + self.props.goods + self.props.bads + self.props.misses
    return Roact.createElement("Frame", {
        BackgroundColor3 = self.props.BackgroundColor3 or Color3.fromRGB(25, 25, 25),
        Position = self.props.Position,
        Size = self.props.Size or UDim2.new(1, 0, 1, 0),
        AnchorPoint = self.props.AnchorPoint
    }, {
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 6),
        }),
        SpreadDisplay = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0.985, 0, 0.97, 0),
        }, {
            ListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
            });
            Marvelouses = Roact.createElement(SpreadBar, {
                Size = UDim2.new(1, 0, 1/6, 0);
                LayoutOrder = 1;
                color = Color3.fromRGB(77, 77, 77);
                count = self.props.marvelouses;
                total = total_count;
            });
            Perfects = Roact.createElement(SpreadBar, {
                Size = UDim2.new(1, 0, 1/6, 0);
                LayoutOrder = 2;
                color = Color3.fromRGB(77, 70, 0);
                count = self.props.perfects;
                total = total_count;
            });
            Greats = Roact.createElement(SpreadBar, {
                Size = UDim2.new(1, 0, 1/6, 0);
                LayoutOrder = 3;
                color = Color3.fromRGB(25, 78, 12);
                count = self.props.greats;
                total = total_count;
            });
            Goods = Roact.createElement(SpreadBar, {
                Size = UDim2.new(1, 0, 1/6, 0);
                LayoutOrder = 4;
                color = Color3.fromRGB(2, 0, 74);
                count = self.props.goods;
                total = total_count;
            });
            Bads = Roact.createElement(SpreadBar, {
                Size = UDim2.new(1, 0, 1/6, 0);
                LayoutOrder = 5;
                color = Color3.fromRGB(59, 0, 74);
                count = self.props.bads;
                total = total_count;
            });
            Misses = Roact.createElement(SpreadBar, {
                Size = UDim2.new(1, 0, 1/6, 0);
                LayoutOrder = 6;
                color = Color3.fromRGB(74, 0, 1);
                count = self.props.misses;
                total = total_count;
            });

        })
    })
end

return SpreadDisplay
