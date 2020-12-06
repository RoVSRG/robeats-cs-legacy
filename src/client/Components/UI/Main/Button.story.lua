local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Button = require(script.Parent.Button)

local ButtonStory, Callback = require(game.ReplicatedStorage.Shared.Utils.Story):new()

function ButtonStory:create(target)
    local app = Roact.createElement(Button)

    self.fr = Roact.mount(app, target)
end

function ButtonStory:destroy()
    Roact.unmount(self.fr)
end

return Callback
