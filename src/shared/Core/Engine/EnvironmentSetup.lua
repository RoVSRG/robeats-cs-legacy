local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local AssertType = require(game.ReplicatedStorage.Shared.Utils.AssertType)

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

local DEFAULT_HORIZ_DISTANCE = 36.5
local DEFAULT_UP_DISTANCE = 14
local DEFAULT_LOOKAT_HORIZ_DISTANCE = 17.5

function EnvironmentSetup:initial_setup()
	local RoactApp = require(game.ReplicatedStorage.Client.App)

	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

	_game_environment = workspace.Models.GameEnvironment
	_game_environment.Parent = nil
	
	_element_protos_folder = workspace.Models.ElementProtos
	_element_protos_folder.Parent = game.ReplicatedStorage
	
	_local_elements_folder = Instance.new("Folder",workspace)
	_local_elements_folder.Name = "LocalElements"
	
	_player_gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	_player_gui.IgnoreGuiInset = false

	--game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0)

	--LOAD SETTINGS
	--Configuration:load_from_save()

	--Mount Roact tree wrapped in StoreProvider

	local camCFrame = CFrame.new(
		Vector3.new(-DEFAULT_HORIZ_DISTANCE, DEFAULT_UP_DISTANCE, DEFAULT_HORIZ_DISTANCE),
		Vector3.new(-DEFAULT_LOOKAT_HORIZ_DISTANCE, 0, DEFAULT_LOOKAT_HORIZ_DISTANCE)
	)

	workspace.CurrentCamera.CFrame = camCFrame + self:get_game_environment_center_position()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	workspace.CurrentCamera.CameraSubject = nil

	RoactApp:mount(_player_gui)
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

function EnvironmentSetup:setup_three_dimensional_world()
	local _element_protos_folder = self:get_element_protos_folder()
	local _obj = _element_protos_folder.NoteTrackSystemProto:Clone()
	_obj:SetPrimaryPartCFrame(SPUtil:look_at(
		self:get_game_environment_center_position(),
		self:get_game_environment_center_position() + Vector3.new(-50,0,50)
	))
	_obj.Parent = self:get_local_elements_folder()

	for i = 1, 4 do
		local itr_proto = _element_protos_folder.TriggerButtonProto:Clone()

		itr_proto.Parent = _obj["Track"..i]
		itr_proto.PrimaryPart.Position = _obj["Track"..i].EndPosition.Position + Vector3.new(0,2,0)
	end


	return _obj
end

return EnvironmentSetup
