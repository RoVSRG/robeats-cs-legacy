local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local DotGraph = require(script.Parent.DotGraph)

return function(target)
    local testApp = Roact.createElement(DotGraph, {
        points = {
            {
                x = 0.5;
                y = 0.8;
                color = Color3.fromRGB(255,0,87)
            }
        };
        bounds = {
            min = {
                y = -350;
            };
            max = {
                y = 350;
            }
        };
        interval = {
            y = 50;
        }
    })

    local fr = Roact.mount(testApp, target)

    return function()
        Roact.unmount(fr)
    end 
end