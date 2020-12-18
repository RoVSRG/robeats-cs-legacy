local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Playfield = require(script.Parent.Playfield)

local PlayfieldApp = Story:new()

function PlayfieldApp:render()
    local hitObjects = {
        {
            type = 1;
            pressAlpha = 0.4;
            lane = 1
        };
        {
            type = 1;
            pressAlpha = 0.4;
            lane = 2
        };
        {
            type = 1;
            pressAlpha = 0.4;
            lane = 3
        };
        {
            type = 1;
            pressAlpha = 0.5;
            lane = 3
        };
        {
            type = 1;
            pressAlpha = 0.65;
            lane = 4
        };
        {
            type = 1;
            pressAlpha = 0.4;
            lane = 4
        };
        {
            type = 1;
            pressAlpha = 0.65;
            lane = 2
        };
        {
            type = 1;
            pressAlpha = 0.65;
            lane = 1;
        };
        {
            type = 1;
            pressAlpha = 0.65;
            lane = 3
        };
    }
    return Roact.createElement(Playfield, {
        hitObjects = hitObjects;
        XOffset = 0.1;
    })
end

return PlayfieldApp
