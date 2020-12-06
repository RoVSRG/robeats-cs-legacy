local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local LoadingUI = Roact.PureComponent:extend("LoadingUI")
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local NpsGraph = require(game.ReplicatedStorage.Client.Components.UI.NpsGraph)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

function LoadingUI:init()
	self.startTime = tick()
	self:setState({
		increment = 0
	})
end

function LoadingUI:didMount()
	self.bound_to_frame = SPUtil:bind_to_frame(function()
		self:setState(function(state)
			return Llama.Dictionary.join(state, {
				increment = math.floor(tick()-self.startTime)
			})
		end)

		--Check if we need to unmount from state

		if self.props.isLoaded then
			self.props.history:push("/gameplay")
		end
	end)
end

function LoadingUI:willUnmount()
	self.bound_to_frame:Disconnect()
end

function LoadingUI:render()
	return Roact.createElement("Frame", {
		Name = "LoadingUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.7, 0, 0.5, 0),
	}, {
		TimeDisplay = Roact.createElement("TextLabel", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.01, 0, 0.05, 0),
			Size = UDim2.new(0.357, 0, 0.15, 0),
			Font = Enum.Font.GothamBold,
			Text = string.format("Loading (%d)...", self.state.increment),
			TextColor3 = Color3.fromRGB(10,10,10),
			TextScaled = true,
			TextSize = 26,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 26,
				MinTextSize = 10,
			})
		}),
		SongNameAndArtist = Roact.createElement("TextLabel", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.01, 0, 0.17, 0),
			Size = UDim2.new(0.357, 0, 0.15, 0),
			Font = Enum.Font.GothamBold,
			Text = string.format("%s - %s", SongDatabase:get_artist_for_key(self.props.selectedSongKey), SongDatabase:get_title_for_key(self.props.selectedSongKey)),
			TextScaled = true,
			TextSize = 17,
			TextColor3 = Color3.fromRGB(25,25,25),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 17,
				MinTextSize = 12,
			})
		}),
		NpsGraph = Roact.createElement(NpsGraph, {
			song_key = 1;
			Position = UDim2.new(0.5,0,0.97,0);
			Size = UDim2.new(0.98,0,0.65,0);
			AnchorPoint = Vector2.new(0.5,1)
		});
		Corner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		BackButton = Roact.createElement("TextButton", {
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			Position = UDim2.new(1-0.0037, 0, 0.01, 0),
			Size = UDim2.new(0.2, 0, 0.1, 0),
			Font = Enum.Font.SourceSansBold,
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 22,
			TextWrapped = true,
			[Roact.Event.InputBegan] = SPUtil:input_callback(function()
				self.props.backOut()
			end)
		}, {
			Text = Roact.createElement("TextLabel", {
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
			Corner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			})
		})
	})
end

return LoadingUI