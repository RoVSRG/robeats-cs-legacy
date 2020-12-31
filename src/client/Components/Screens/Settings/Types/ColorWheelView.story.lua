local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ColorWheelView = require(script.Parent.ColorWheelView)

return function(target)
    
    local app = Roact.createElement(ColorWheelView, {
        pointerPosition = UDim2.new(0.5, 0, 0.5, 0);
    })

    local fr = Roact.mount(app, target)

    return function()
        Roact.unmount(fr)
    end
end
