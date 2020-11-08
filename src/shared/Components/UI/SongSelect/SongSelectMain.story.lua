local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SongSelectUI = require(game.ReplicatedStorage.Components.UI.SongSelect.SongSelectMain)

return function(target)
    local testApp = Roact.createElement(SongSelectUI)

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end
