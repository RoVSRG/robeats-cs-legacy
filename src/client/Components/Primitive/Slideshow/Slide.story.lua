local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Slide = require(script.Parent.Slide)

local SlideApp = Story:new()

function SlideApp:render()
    local StateC = Roact.Component:extend("StateC")

    function StateC:init()
        self:setState({
            currentSlide = 1;
        })
    end

    function StateC:didMount()
        spawn(function()
            while true do
                if self.stop == true then break end
                self:setState(function(state)
                    return {
                        currentSlide = state.currentSlide + 1
                    }
                end)
                print(self.state)
                wait(1)
            end
        end)
    end

    function StateC:willUnmount()
        self.stop = true
    end

    function StateC:render()
        return Roact.createElement(Slide, {
            slide = 2;
            currentSlide = self.state.currentSlide % 3;
        }, {
            TestLol = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0);
                BackgroundColor3 = Color3.fromRGB(255, 0, 87);
            })
        })
    end

    return Roact.createElement(StateC)
end

return SlideApp
