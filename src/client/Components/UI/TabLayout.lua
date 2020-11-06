local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local TabLayout = Roact.Component:extend("TabLayout")

function TabLayout:init()

end

function TabLayout:render()
    local _buttons = {}
    for i, v in pairs(self.props.buttons) do
        _buttons[i] = Roact.createElement("TextButton", {
            Size = UDim2.new((1/#self.props.buttons)*(1-(#self.props.buttons*0.01)),0,1,0);
            Text = v.Text;
            TextScaled = true;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            Font = Enum.Font.GothamBold;
            BackgroundColor3 = Color3.fromRGB(40,40,40);
            [Roact.Event.MouseButton1Click] = v.OnActivated;
        }, {
            Corner = Roact.createElement("UICorner");
            TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 40;
                MinTextSize = 12;
            })
        })
    end
    return Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,0);
        Position = UDim2.new(0,0,0,0);
        BackgroundColor3 = Color3.fromRGB(20,20,20),
        BackgroundTransparency = 0;
    }, {
        Layout = Roact.createElement("Frame", {
            Position = UDim2.new(0.5,0,0.5,0);
            Size = UDim2.new(0.99,0,0.99,0);
            BackgroundTransparency = 1;
            AnchorPoint = Vector2.new(0.5,0.5);
        }, {
            Buttons = Roact.createFragment(_buttons);
            UIListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal;
                Padding = UDim.new(0.01,0)
            })
        })
    })
end

return TabLayout
