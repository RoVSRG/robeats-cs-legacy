local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ColorWheel = require(script.Parent.ColorWheel)

return function(target)
    
    local app = Roact.createElement(ColorWheel, {
        pointerPosition = UDim2.new(0.5, 0, 0.5, 0);
    })

    local fr = Roact.mount(app, target)

    return function()
        Roact.unmount(fr)
    end
end
