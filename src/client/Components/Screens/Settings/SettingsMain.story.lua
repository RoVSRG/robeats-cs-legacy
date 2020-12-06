local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SettingsMain = require(script.Parent.SettingsMain)

return function(target)
    local app = Roact.createElement(SettingsMain)

    local fr = Roact.mount(app, target)

    return function()
        Roact.unmount(fr)
    end
end
