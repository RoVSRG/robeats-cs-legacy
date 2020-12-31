local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Combo = Roact.Component:extend("Combo")

function Combo:render()
    return Roact.createElement("TextLabel", {
        Name = "ChainDisplay",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
        Font = Enum.Font.GothamSemibold,
        Text = string.format("%dx", self.props.combo),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextSize = 26,
        TextWrapped = true,
    }, {
        Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 50,
            MinTextSize = 20,
        }),
        Roact.createElement("UIAspectRatioConstraint", {
        })
    })
end

return Combo
