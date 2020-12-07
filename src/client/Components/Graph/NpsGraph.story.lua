local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local NpsGraphApp = Story:new()

local NpsGraph = require(game.ReplicatedStorage.Client.Components.Graph.NpsGraph)

function NpsGraphApp:render()
    return Roact.createElement(NpsGraph, {
        song_key = 1,
        Position = UDim2.new(0,0,0,0);
        Size = UDim2.new(1,0,1,0)
    })
end


return NpsGraphApp