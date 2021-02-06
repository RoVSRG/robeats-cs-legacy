local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local TimeLeft = Roact.Component:extend("TimeLeft")
--hey when will this be fix xd lol
function TimeLeft:render()
    return Roact.createElement("TextLabel", {
        Name = "TimeLeftDisplay",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = self.props.Position,
        Size = self.props.Size,
        Font = Enum.Font.GothamSemibold,
        Text = SPUtil:format_ms_time(self.props.time_left or 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextSize = 26,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, {
        Roact.createElement("UITextSizeConstraint", {
            MaxTextSize = 26,
            MinTextSize = 20,
        })
    })
end

return TimeLeft