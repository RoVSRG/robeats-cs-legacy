local Roact = require(script.Parent.Parent.Parent.ReplicatedStorage.Roact)
local ConfirmationPopupUI = Roact.PureComponent:extend("ConfirmationPopupUI")

function ConfirmationPopupUI:init()
end

function ConfirmationPopupUI:render()
	return Roact.createElement("Frame", {
		Name = "ConfirmationPopupUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.346020758, 0, 0.424929172, 0),
	}, {
		Roact.createElement("TextLabel", {
			Name = "TitleDisplay",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.0524999984, 0, 0.0466666669, 0),
			Size = UDim2.new(0.894999981, 0, 0.113333337, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "Loading (0)...",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 26,
		}),
		Roact.createElement("TextButton", {
			Name = "OkayButton",
			BackgroundColor3 = Color3.fromRGB(24, 255, 89),
			Position = UDim2.new(0.107500002, 0, 0.693333328, 0),
			Size = UDim2.new(0.785000026, 0, 0.140000001, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "Okay",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 32,
			TextStrokeTransparency = 0.75,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			})
		}),
		Roact.createElement("TextLabel", {
			Name = "SubDisplay",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.0524999984, 0, 0.186666667, 0),
			Size = UDim2.new(0.894999981, 0, 0.443333328, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "Loading (0)...",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			TextWrapped = true,
		}),
		Roact.createElement("TextButton", {
			Name = "BackButton",
			BackgroundColor3 = Color3.fromRGB(255, 34, 34),
			Position = UDim2.new(0.245000005, 0, 0.870000005, 0),
			Size = UDim2.new(0.507499993, 0, 0.0966666639, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "Back",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 20,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			})
		}),
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		})
	})
end

return ConfirmationPopupUI
