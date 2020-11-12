local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Score = Roact.Component:extend("Score")

function Score:render()
    return Roact.createElement("TextLabel", {
        Name = "ScoreDisplay",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
        Font = Enum.Font.GothamSemibold,
        Text = self.props.score,
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


return Score