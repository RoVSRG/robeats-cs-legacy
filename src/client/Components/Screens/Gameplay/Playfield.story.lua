local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Playfield = require(script.Parent.Playfield)

local PlayfieldApp = Story:new()

function PlayfieldApp:render()
    local hitObjects = {
        {
            type = 2;
            pressAlpha = 0.7;
            lane = 4;
            releaseAlpha = 0;
        };
    }
    return Roact.createElement(Playfield, {
        hitObjects = hitObjects;
        XOffset = 0.1;
    })
end

return PlayfieldApp
