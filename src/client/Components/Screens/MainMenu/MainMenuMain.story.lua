local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local MainMenuMain = require(game.ReplicatedStorage.Client.Components.Screens.MainMenu.MainMenuMain)

function noop() end

local Story = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared").Utils["Story"])
local MainMenuMainApp = Story:new()

function MainMenuMainApp:render()
    return Roact.createElement(MainMenuMain)
end

return MainMenuMainApp
