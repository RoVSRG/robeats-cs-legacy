local BannerCard = require(script.Parent.BannerCard)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

return function(target)
    local fr = Roact.createElement(BannerCard, {
        playername = "kisperal";
        song_key = 15;
        rate = 100;
    })

    local tree = Roact.mount(fr, target)

    return function()
        Roact.unmount(tree)
    end
end