local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local BannerCard = require(game.ReplicatedStorage.Client.Components.Screens.Results.BannerCard)

local BannerCardApp = Story:new()

function BannerCardApp:render()
    return Roact.createElement(BannerCard, {
        playername = "kisperal";
        song_key = 15;
        rate = 100;
        grade_image = "http://www.roblox.com/asset/?id=5702584062";
    })
end

return BannerCardApp
