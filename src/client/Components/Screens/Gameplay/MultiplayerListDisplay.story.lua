local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)
local MultiplayerListDisplay = require(game:GetService("ReplicatedStorage"):WaitForChild("Client").Components.Screens.Gameplay["MultiplayerListDisplay"])

local MultiListApp = Story:new()

function MultiListApp:render()
    return Roact.createElement(MultiplayerListDisplay)
end

return MultiListApp