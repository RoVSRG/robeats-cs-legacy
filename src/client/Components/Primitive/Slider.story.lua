local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local FlashEvery = require(game.ReplicatedStorage.Shared.Utils.FlashEvery)
local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)

local Slider = require(script.Parent.Slider)

local SliderApp = Story:new()

function SliderApp:render()
    local HOC = Roact.Component:extend("HOC")

    function HOC:init()
        self:setState({
            percent = 0;
        })
        self.doEvery = FlashEvery:new(2)
    end

    function HOC:didMount()
        self.boundToFrame = SPUtil:bind_to_frame(function(dt)
            self.doEvery:update(CurveUtil:DeltaTimeToTimescale(dt))
            if self.doEvery:do_flash() then
                self:setState(function()
                    return {
                        percent = math.random(1, 100)
                    }
                end)
            end
        end)
    end

    function HOC:render()
        return Roact.createElement(Slider, {
            initialPercent = self.state.percent;
            onDrag = function(a)
                           
            end
        })
    end

    function HOC:willUnmount()
        self.boundToFrame:Disconnect()
    end

    return Roact.createElement(HOC)
end

return SliderApp
