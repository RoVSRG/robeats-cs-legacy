local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local MusicBox = require(script.Parent.MusicBox)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local MusicBoxApp = Story:new()

-- MusicBoxApp.mountTo = workspace

function MusicBoxApp:render()
    return Roact.createElement(MusicBox, {
        Position = UDim2.new(0, 0, 0, 0);
        Size = UDim2.fromScale(1, 1);
        AnchorPoint = Vector2.new(0,0);
    })
end

return MusicBoxApp