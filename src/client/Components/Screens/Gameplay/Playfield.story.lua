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
            poolId = 1;
        };
        {
            type = 1;
            pressAlpha = 0.7;
            lane = 1;
            releaseAlpha = 0;
            poolId = 2;
        };
        {
            type = 1;
            pressAlpha = 0.7;
            lane = 2;
            poolId = 3;
        };
        {
            type = 1;
            pressAlpha = 0.7;
            lane = 3;
            poolId = 4;
        };
    }
    return Roact.createElement(Playfield, {
        hitObjects = hitObjects;
        XOffset = 0.1;
    })
end

return PlayfieldApp
