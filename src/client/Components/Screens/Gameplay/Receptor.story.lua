local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Receptor = require(script.Parent.Receptor)

local ReceptorStory = Story:new()

function ReceptorStory:render()
    return Roact.createElement(Receptor, {
        Image = "rbxassetid://5571834044";
        lane = 4;
        YOffset = 0.01;
        numberOfLanes = 4;
        upscroll = false;
        keyToDarken = Enum.KeyCode.G;
    })
end
    
return ReceptorStory
