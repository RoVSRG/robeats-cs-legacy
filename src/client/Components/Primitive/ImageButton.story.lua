local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ImageButton = require(script.Parent.ImageButton)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local ImageButtonApp = Story:new()

function ImageButtonApp:render()
    return Roact.createElement(ImageButton, {
        Size = UDim2.new(1,0,1,0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
        Image = "rbxassetid://2944248331";
        BackgroundColor3 = Color3.fromRGB(14,14,14);
    })
end

return ImageButtonApp