local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local ConditionalReturn = require(game.ReplicatedStorage.Shared.Utils.ConditionalReturn)

local ResultsScreenMain = Roact.Component:extend("ResultsScreenMain")

local DotGraph = require(game.ReplicatedStorage.Client.Components.Graph.Dot.DotGraph)
local SpreadDisplay = require(script.Parent.SpreadDisplay)
local BannerCard = require(script.Parent.BannerCard)
local DataDisplay = require(script.Parent.DataDisplay)

local Button = require(script.Parent.Parent.Parent.Primitive.Button)

function ResultsScreenMain:init()
	self.grade_images = {
		"http://www.roblox.com/asset/?id=5702584062",
		"http://www.roblox.com/asset/?id=5702584273",
		"http://www.roblox.com/asset/?id=5702584488",
		"http://www.roblox.com/asset/?id=5702584846",
		"http://www.roblox.com/asset/?id=5702585057",
		"http://www.roblox.com/asset/?id=5702585272"
	}

	self.goBack = function()
		self.props.history:push("/select")
	end

	self.backOutConnection = SPUtil:bind_to_key(Enum.KeyCode.Return, function()
		self.goBack()
	end)
end

function ResultsScreenMain:willUnmount()
	self.backOutConnection:Disconnect()
end

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
			};
			points = self.props.stats.hit_deviance;
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
			song_key = self.props.selectedSongKey or 1;
			playername = "kisperal";
			Position = UDim2.new(0.5,0,0.01,0);
			Size = UDim2.new(0.98,0,0.3,0);
			grade_image = self.grade_images[2];
		});
		DataDisplay = Roact.createElement(DataDisplay, {
			data = {
				{
					Name = "Score";
					Value = string.format("%d", stats.score);
				};
				{
					Name = "Accuracy";
					Value = string.format("%0.2f%%", stats.accuracy);
				};
				{
					Name = "Play Rating";
					Value = string.format("%0.2f", stats.rating or 0);
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
		});
		BackButton = ConditionalReturn(SPUtil:is_mobile(), (
			Roact.createElement(Button, {
				Size = UDim2.new(0.11,0,0.09,0);
				shrinkBy = 0.009;
				BackgroundColor3 = Color3.fromRGB(236, 33, 33);
				TextColor3 = Color3.fromRGB(255, 255, 255);
				TextScaled = true;
				AnchorPoint = Vector2.new(0, 0.5);
				Position = UDim2.new(0.015,0,0.25,0);
				Text = "Go Back";
				onActivated = function()
					self.goBack()
				end
			}, {
				tsc = Roact.createElement("UITextSizeConstraint", {
					MinTextSize = 7;
					MaxTextSize = 18;
				})
			})
		))
	})
end

return ResultsScreenMain
