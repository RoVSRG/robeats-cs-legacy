local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ResultsScreenMain = Roact.Component:extend("ResultsScreenMain")

local DotGraph = require(game.ReplicatedStorage.Shared.Components.Graph.Dot.DotGraph)
local SpreadDisplay = require(script.Parent.SpreadDisplay)
local BannerCard = require(script.Parent.BannerCard)
local DataDisplay = require(script.Parent.DataDisplay)

function ResultsScreenMain:render()
	local stats = self.props.stats

    return Roact.createElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0;
		Size = UDim2.new(1, 0, 1, 0);
	}, {
		HitGraph = Roact.createElement(DotGraph, {
			AnchorPoint = Vector2.new(1, 1),
			BackgroundColor3 = Color3.fromRGB(25, 25, 25),
			BorderSizePixel = 0,
			Position = UDim2.new(0.99, 0, 0.98, 0),
			Size = UDim2.new(0.485, 0, 0.5, 0),
			bounds = {
				min = {
					y = -350;
				};
				max = {
					y = 350;
				}
			};
			interval = {
				y = 50;
			}
		}),
		SpreadDisplay = Roact.createElement(SpreadDisplay, {
			AnchorPoint = Vector2.new(0,1),
			Position = UDim2.new(0.01,0,0.98,0),
			Size = UDim2.new(0.485,0,0.5,0),
			marvelouses = stats.marvelouses,
			perfects = stats.perfects,
			greats = stats.greats,
			goods = stats.goods,
			bads = stats.bads,
			misses = stats.misses
		}),
		BannerCard = Roact.createElement(BannerCard, {
			AnchorPoint = Vector2.new(0.5,0);
			song_key = 1;
			playername = "kisperal";
			Position = UDim2.new(0.5,0,0.01,0);
			Size = UDim2.new(0.98,0,0.3,0);
		});
		DataDisplay = Roact.createElement(DataDisplay, {
			data = {
				{
					Name = "Score";
					Value = stats.score;
				};
				{
					Name = "Accuracy";
					Value = string.format("%0.2f%%", stats.accuracy);
				};
				{
					Name = "Play Rating";
					Value = string.format("%0.2f", 85.555888888);
				};
				{
					Name = "Max Combo";
					Value = stats.maxcombo
				};
				{
					Name = "Mean";
					Value = string.format("%0d ms", 0);
				};
			};
			Position = UDim2.new(0.5,0,0.32,0);
			Size = UDim2.new(0.98,0,0.15,0);
			AnchorPoint = Vector2.new(0.5,0);
		})
	})
end

return ResultsScreenMain
