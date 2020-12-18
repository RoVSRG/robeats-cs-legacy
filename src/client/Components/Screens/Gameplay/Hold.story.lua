local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Hold = require(script.Parent.Hold)

local HoldApp = Story:new()

function HoldApp:render()
    return Roact.createElement(Hold, {
        Image = "rbxassetid://5571834044";
        lane = 1;
        alpha = 0.6;
        releaseAlpha = 0.8;
        numberOfLanes = 4;
        upscroll = false;
        keyToDarken = Enum.KeyCode.G;
    })
end
    
return HoldApp
