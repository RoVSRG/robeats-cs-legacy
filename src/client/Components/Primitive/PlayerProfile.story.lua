local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local PlayerProfile = require(script.Parent.PlayerProfile)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local PlayerApp = Story:new()

function noop() end


function PlayerApp:render()
    return Roact.createElement(PlayerProfile)
end

return PlayerApp
