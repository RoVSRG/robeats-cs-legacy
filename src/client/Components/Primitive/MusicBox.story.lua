local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local MusicBox = require(script.Parent.MusicBox)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local MusicBoxApp = Story:new()

function MusicBoxApp:render()
    return Roact.createElement(MusicBox,{
        Size = UDim2.fromScale(0.35, 0.15);
        Position = UDim2.fromScale(0.99, 0.02);
    })
end

return MusicBoxApp