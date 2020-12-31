local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Judgement = require(script.Parent.Judgement)

local JudgementApp = Story:new()

function JudgementApp:render()
    return Roact.createElement(Judgement, {
        judgement = 5;
    })
end

return JudgementApp
