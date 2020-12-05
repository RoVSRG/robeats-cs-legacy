local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = {}

function Story:new(render)
    local story = {}

    function story:render() return nil end
    function story:init(target) return nil end
    function story:willUnmount() return nil end
    function story:didUnmount() return nil end

    return setmetatable(story, {
        __call = function(t, target)
            t:init(target)
            local destroyWasCalled = false
            local app = t:render()
            local fr = Roact.mount(app, target)
            return function()
                if destroyWasCalled then return end
                destroyWasCalled = true
                t:willUnmount()
                Roact.unmount(fr)
                t:didUnmount()
            end
        end
    })
end

return Story
