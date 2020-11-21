local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local Components = game.ReplicatedStorage.Shared.Components
local Screens = Components.Screens
local SongSelectMain = require(Screens.SongSelect)
local GameplayMain = require(Screens.Gameplay)
local Loading = require(Screens.Loading)
local State = game.ReplicatedStorage.Shared.State
local with = require(State.with)

local RoactApp = {}

function RoactApp:mount(_player_gui)
    local app = Roact.createElement(RoactRodux.StoreProvider, {
		store = require(State)
	}, {
		SongSelectMain = Roact.createElement(with(SongSelectMain));
		GameplayMain = Roact.createElement(with(GameplayMain));
		Loading = Roact.createElement(with(Loading));
		Topbar = Roact.createElement("Frame", {
			Size = UDim2.new(1,0,36,0);
			BackgroundColor3 = Color3.fromRGB(35, 35, 35);
			AnchorPoint = Vector2.new(0,1);
		})
	})

	Roact.mount(app, _player_gui)
end

return RoactApp
