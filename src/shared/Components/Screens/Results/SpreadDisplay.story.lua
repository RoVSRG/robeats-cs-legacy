local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SpreadDisplay = require(script.Parent.SpreadDisplay)

return function(target)
    local fr = Roact.createElement(SpreadDisplay, {
        marvelouses = 5;
        perfects = 4;
        greats = 50;
        goods = 56;
        bads = 80;
        misses = 89;
    })

    local fr = Roact.mount(fr, target)

    return function()
        Roact.unmount(fr)
    end
end
