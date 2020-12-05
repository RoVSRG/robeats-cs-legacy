local Story = require(game.ReplicatedStorage.Shared.Utils.Story)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local PicardiaApp = Story:new(function()
    return Roact.createElement("ImageLabel", {
        BackgroundColor3 = Color3.fromRGB(235, 222, 52);
        Image = "rbxassetid://2944248331";
        Size = UDim2.new(1, 0, 1, 0);
    })
end)

return PicardiaApp
