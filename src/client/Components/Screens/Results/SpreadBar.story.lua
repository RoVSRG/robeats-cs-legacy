local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local SpreadBar = require(script.Parent.SpreadBar)

local SpreadBarApp = Story:new()

function SpreadBarApp:render()
    local SP = Roact.Component:extend("SP")

    function SP:init()
        self:setState({
            v = 0
        })
    end

    function SP:didMount()
        spawn(function()
            while true do
                if self.stop then break end
                self:setState(function(state)
                    return {
                        v = state.v + 1
                    }
                end)
                wait(0.05)
            end
        end)
    end

    function SP:render()
        return Roact.createElement(SpreadBar, {
            count = self.state.v;
            total = 300;
            color = Color3.fromRGB(25, 20, 25)
        })
    end

    function SP:willUnmount()
        self.stop = true
    end

    return Roact.createElement(SP)
end

return SpreadBarApp
