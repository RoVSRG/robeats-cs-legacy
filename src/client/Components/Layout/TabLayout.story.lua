local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local TabLayout = require(script.Parent.TabLayout)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local TabLayoutApp = Story:new()

local buttons = {
    {
        Text = "a",
        OnActivated = function()
            print("a")
        end
    },
    {
        Text = "b",
        OnActivated = function()
            print("b")
        end
    },
    {
        Text = "c",
        OnActivated = function()
            print("c")
        end
    },
    {
        Text = "d",
        OnActivated = function()
            print("d")
        end
    }
}

function TabLayoutApp:render()
    return Roact.createElement(TabLayout, {
        Size = UDim2.new(1, 0, 1, 0);
        buttons = buttons;
    })
end

return TabLayoutApp
