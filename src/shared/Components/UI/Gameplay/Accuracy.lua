local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Combo = Roact.Component:extend("Combo")

function Combo:render()
    return Roact.createElement("TextLabel", {
        Name = "GradeDisplay",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
        Font = Enum.Font.GothamSemibold,
        Text = string.format("%2.2f%%", self.props.accuracy),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextSize = 26,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, {
        Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 32,
            MinTextSize = 20,
        })
    })
end

return Combo
