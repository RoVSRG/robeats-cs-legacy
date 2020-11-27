local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local IntSetting = require(script.Parent.IntSetting)

return function(target)
    local app = Roact.createElement(IntSetting, {
        onChange = function(value, oldValue)
            print("Whoa, there was a change! Here is the old value:", oldValue, ", and the new value:", value)
        end
    })

    local fr = Roact.mount(app, target)

    return function()
        Roact.unmount(fr)
    end
end
