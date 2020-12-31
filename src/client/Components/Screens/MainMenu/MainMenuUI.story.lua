local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local MainMenuUI = require(game.ReplicatedStorage.Client.Components.Screens.MainMenu.MainMenuUI)

local Story = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared").Utils["Story"])
local MainMenuUIApp = Story:new()

function noop() end

function MainMenuUIApp:render()
    noop()
end

return MainMenuUIApp
