local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Line = require(script.Parent.Line)

return function(target)
    local testApp = Roact.createElement(Line, {
        value = 5;
        axis = "y";
        position = 0.2558;
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end