local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local NpsGraph = require(game.ReplicatedStorage.Shared.Components.UI.NpsGraph)

return function(target)
    local testApp = Roact.createElement(NpsGraph, {
        song_key = 1,
        Position = UDim2.new(0,0,0,0);
        Size = UDim2.new(1,0,1,0)
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end