local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)
local SpreadDisplay = require(script.Parent.SpreadDisplay)

local SpreadDisplayApp = Story:new()

function SpreadDisplayApp:render()
    return Roact.createElement(SpreadDisplay, {
        marvelouses = 5;
        perfects = 4;
        greats = 50;
        goods = 56;
        bads = 80;
        misses = 89;
    })
end

return SpreadDisplayApp
