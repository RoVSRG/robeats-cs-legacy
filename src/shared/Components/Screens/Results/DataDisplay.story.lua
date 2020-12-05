local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)
local DataDisplay = require(script.Parent.DataDisplay)

local DataDisplayApp = Story:new(function()
    return Roact.createElement(DataDisplay, {
        data = {
            {
                Name = "Accuracy";
                Value = 98;
            };
            {
                Name = "Score";
                Value = 45899936;
            };
            {
                Name = "Rating";
                Value = 45.85;
            };
        }
    })
end)

return DataDisplayApp
