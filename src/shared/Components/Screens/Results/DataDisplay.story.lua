local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local DataDisplay = require(script.Parent.DataDisplay)

return function(target)
    local fr = Roact.createElement(DataDisplay, {
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

    local fr = Roact.mount(fr, target)

    return function()
        Roact.unmount(fr)
    end
end
