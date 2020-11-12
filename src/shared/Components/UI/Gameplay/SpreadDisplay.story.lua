local SpreadDisplay = require(script.Parent.SpreadDisplay)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

return function(target)
    local fr = Roact.createElement(SpreadDisplay, {
        marvs = 2336;
        perfs = 255;
        greats = 54;
        goods = 5;
        bads = 10;
        misses = 233;
    })

    local tree = Roact.mount(fr, target)

    return function()
        Roact.unmount(tree)
    end
end