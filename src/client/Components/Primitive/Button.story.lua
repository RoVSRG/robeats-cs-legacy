local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Button = require(script.Parent.Button)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local ButtonApp = Story:new()

function ButtonApp:render()
    return Roact.createElement(Button, {
        Size = UDim2.new(1,0,1,0);
        Position = UDim2.new(0.5, 0, 0.5, 0);
        AnchorPoint = Vector2.new(0.5, 0.5);
    })
end

return ButtonApp
