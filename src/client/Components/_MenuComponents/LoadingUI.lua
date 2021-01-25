local Roact = require(script.Parent.Parent.Parent.ReplicatedStorage.Roact)
local LoadingUI = Roact.PureComponent:extend("LoadingUI")

function LoadingUI:init()
end

function LoadingUI:render()
	return Roact.createElement("Frame", {
		Name = "LoadingUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.179468244, 0, 0.158640221, 0),
	}, {
		Roact.createElement("TextLabel", {
			Name = "TimeDisplay",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.0823045298, 0, 0.142857149, 0),
			Size = UDim2.new(0.835390925, 0, 0.303571463, 0),
			Font = Enum.Font.GothamBold,
			Text = "Loading (0)...",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 26,
			TextWrapped = true,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 26,
				MinTextSize = 10,
			})
		}),
		Roact.createElement("TextLabel", {
			Name = "AssetDisplay",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.0823045298, 0, 0.428571433, 0),
			Size = UDim2.new(0.835390925, 0, 0.223214284, 0),
			Font = Enum.Font.GothamBold,
			Text = "Loading (0)...",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 14,
			TextWrapped = true,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 14,
				MinTextSize = 8,
			})
		}),
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		Roact.createElement("TextButton", {
			Name = "BackButton",
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			Position = UDim2.new(0.0823046342, 0, 0.670000017, 0),
			Size = UDim2.new(0.835391045, 0, 0.300000012, 0),
			Font = Enum.Font.SourceSansBold,
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 22,
			TextWrapped = true,
		}, {
			Roact.createElement("TextLabel", {
				Name = "Label",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.75, 0, 0.5, 0),
				Font = Enum.Font.GothamSemibold,
				Text = "Back",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
			}),
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			})
		})
	})
end

return LoadingUI
