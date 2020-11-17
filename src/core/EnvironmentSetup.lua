local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local Comppnents = game.ReplicatedStorage.Shared.Components
local UI = Comppnents.UI

local SongSelectMain = require(UI.SongSelect)
local GameplayMain = require(UI.Gameplay)
local Loading = require(UI.Loading)

local DebugOut = require(game.ReplicatedStorage.Shared.Utils.DebugOut)
local SPDict = require(game.ReplicatedStorage.Shared.Utils.SPDict)
local AssertType = require(game.ReplicatedStorage.Shared.Utils.AssertType)

local Configuration = require(game.ReplicatedStorage.Shared.Data.Configuration)
local State = game.ReplicatedStorage.Shared.State
local with = require(State.with)

local EnvironmentSetup = {}
EnvironmentSetup.Mode = {
	Menu = 0;
	Game = 1;
}

local _game_environment
local _element_protos_folder
local _local_elements_folder
local _menu_protos_folder
local _player_gui

function EnvironmentSetup:initial_setup(Store)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

	_game_environment = workspace.Models.GameEnvironment
	_game_environment.Parent = nil
	
	_element_protos_folder = workspace.Models.ElementProtos
	_element_protos_folder.Parent = game.ReplicatedStorage
	
	_local_elements_folder = Instance.new("Folder",workspace)
	_local_elements_folder.Name = "LocalElements"
	
	_player_gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	_player_gui.IgnoreGuiInset = false

	game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0)

	--LOAD SETTINGS
	--Configuration:load_from_save()

	--Mount Roact tree wrapped in StoreProvider

	local app = Roact.createElement(RoactRodux.StoreProvider, {
		store = Store
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

function EnvironmentSetup:set_mode(mode)
	AssertType:is_enum_member(mode, EnvironmentSetup.Mode)
	if mode == EnvironmentSetup.Mode.Game then
		_game_environment.Parent = workspace
	else
		_game_environment.Parent = nil
	end
end

function EnvironmentSetup:get_game_environment_center_position()
	return _game_environment.GameEnvironmentCenter.Position
end

function EnvironmentSetup:get_game_environment()
	return _game_environment
end

function EnvironmentSetup:get_element_protos_folder()
	return _element_protos_folder
end

function EnvironmentSetup:get_local_elements_folder()
	return _local_elements_folder
end

function EnvironmentSetup:get_menu_protos_folder()
	return _menu_protos_folder
end

function EnvironmentSetup:get_player_gui_root()
	return _player_gui
end

return EnvironmentSetup
