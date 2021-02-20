local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.Parent.GameplayMain)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local GameplayApp = Story:new()

function GameplayApp:render()
    return Roact.createElement(GameplayMain, {
        selectedSongKey = 1;
        settings = {
            volume = 100;
            scrollSpeed = 29;
            FOV = 70;
            Keybind1 = Enum.KeyCode.R;
            Keybind2 = Enum.KeyCode.T;
            Keybind3 = Enum.KeyCode.KeypadSeven;
            Keybind4 = Enum.KeyCode.KeypadEight;
        };
        data = {
            songRate = 100;
        }
    })
end

return GameplayApp
