local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Bind = require(script.Parent.Bind)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local BindApp = Story:new()

function BindApp:render()
    return Roact.createElement(Bind, {
        size = 1;
        position = 0;
    })
end

return BindApp
