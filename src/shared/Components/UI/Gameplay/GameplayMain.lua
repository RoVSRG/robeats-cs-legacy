local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ScoreOverlay = require(script.Parent.ScoreOverlay)

local GameplayMain = Roact.PureComponent:extend("GameplayMain")

function GameplayMain:init()
end

function GameplayMain:render()
	return Roact.createElement("Frame", {
		Name = "GameplayMain",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
	}, {
        StatsOverlay = Roact.createElement(ScoreOverlay, {
            marvs = self.props.marvs;
            perfs = self.props.perfs;
            greats = self.props.greats;
            goods = self.props.goods;
            bads = self.props.bads;
            misses = self.props.misses;
            score = self.props.score;
            accuracy = self.props.accuracy;
            time_left = self.props.time_left;
            combo = self.props.combo;
        });
		ExitButton = Roact.createElement("TextButton", {
			BackgroundColor3 = Color3.fromRGB(255, 53, 53),
			Position = UDim2.new(0.02, 0, 0.05, 0),
			Size = UDim2.new(0.1, 0, 0.05, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "Exit",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 22,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			})
		})
	})
end

return GameplayMain
