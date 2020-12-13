local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Slide = require(script.Parent.Slideshow.Slide)


local Slideshow = require(script.Parent.Slideshow)

local SlideshowApp = Story:new()

function SlideshowApp:init()

end

function SlideshowApp:render()
    local StateComponent = Roact.Component:extend("StateComponent")

    function StateComponent:init()
        self:setState({
            currentSlide = 1;
        })
    end

    function StateComponent:didMount()
        spawn(function()
            while true do
                if self.stop then break end
                self:setState(function(state)
                    return {
                        currentSlide = state.currentSlide + 1
                    }
                end)
                print(self.state.currentSlide % 3)
                wait(3)
            end
        end)
    end

    function StateComponent:render()
        return Roact.createElement(Slideshow, {
            Size = UDim2.new(1, 0, 0.5, 0);
            slide = math.clamp(self.state.currentSlide % 3, 1, 2);
            render = function(slide)
                return Roact.createFragment({
                    Slide1 = Roact.createElement(Slide, {
                        currentSlide = slide;
                        slide = 1;
                    }, {
                        TestF = Roact.createElement("Frame", {
                            Size = UDim2.new(1, 0, 1, 0);
                            BackgroundColor3 = Color3.fromRGB(255, 0, 87);
                        })
                    });
                    Slide2 = Roact.createElement(Slide, {
                        currentSlide = slide;
                        slide = 2;
                    }, {
                        TestF = Roact.createElement("Frame", {
                            Size = UDim2.new(1, 0, 1, 0);
                            BackgroundColor3 = Color3.fromRGB(0, 0, 87);
                        })
                    })
                })
            end
        })
    end

    function StateComponent:willUnmount()
        self.stop = true
    end

    return Roact.createElement(StateComponent)
end

return SlideshowApp
