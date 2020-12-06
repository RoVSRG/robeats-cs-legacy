--5678793823

local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRouter = require(game.ReplicatedStorage.Libraries.RoactRouter)

local TheFeesh = Roact.Component:extend("TheFeesh")

function TheFeesh:render()
    return Roact.createElement(RoactRouter.Route, {
        path = "/thefeesh";
        exact = true;
        render = function()
            return Roact.createElement("ImageLabel", {
                Size = UDim2.new(1, 0, 1, 0);
                Image = "rbxassetid://5678793823"
            })
        end
    })
end

return TheFeesh
