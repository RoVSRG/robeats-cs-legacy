local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local MusicBox = require(script.Parent.MusicBox)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local MusicBoxApp = Story:new()

function MusicBoxApp:render()
    return Roact.createElement(MusicBox, {
        Size = UDim2.fromScale(1, 1);
        songKey = 1;
    })
end

return MusicBoxApp