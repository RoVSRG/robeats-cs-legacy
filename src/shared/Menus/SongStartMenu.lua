local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local RobeatsGame = require(game.ReplicatedStorage.RobeatsGameCore.RobeatsGame)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local FlashEvery = require(game.ReplicatedStorage.Shared.FlashEvery)

local InGameMenu = require(game.ReplicatedStorage.Menus.InGameMenu)

local SongStartMenu = {}

function SongStartMenu:new(_local_services, _start_song_key, _local_player_slot, _multiplayer_client)
	local self = MenuBase:new()
	
	local _game
	local _loading_ui
	local _loading_time_sec = 0
	local _back_button_pressed = false

	local did_send_ready = false
	local all_players_loaded = _multiplayer_client == nil

	local _server_poll_flash_every = FlashEvery:new(1)
	
	function self:cons()
		_loading_ui = EnvironmentSetup:get_menu_protos_folder().LoadingUI:Clone()
		_loading_ui.BackButton.Activated:Connect(function()
			_back_button_pressed = true
		end)
		
		EnvironmentSetup:set_mode(EnvironmentSetup.Mode.Game)
		
		_game = RobeatsGame:new(_local_services, EnvironmentSetup:get_game_environment_center_position(), self)
		_game._audio_manager:load_song(_start_song_key)
		_game:setup_world(_local_player_slot)
	end
	
	--[[Override--]] function self:update(dt_scale)
		_game:update(dt_scale)
		_loading_time_sec = _loading_time_sec + CurveUtil:TimescaleToDeltaTime(dt_scale)
		_loading_ui.TimeDisplay.Text = string.format("Loading (%d)...", math.floor(_loading_time_sec))
		_loading_ui.AssetDisplay.Text = string.format("SoundId(%s)", _game._audio_manager:get_bgm().SoundId)

		if _multiplayer_client then
			_server_poll_flash_every:update(dt_scale)
			if _server_poll_flash_every:do_flash() then
				--Send status to server if we haven't already
				if not did_send_ready and _game._audio_manager:is_ready_to_play() == true then
					_multiplayer_client:loaded()
				end

				--Check to see if all players loaded in
				all_players_loaded = _multiplayer_client:are_all_players_loaded()
				print(all_players_loaded)
			end
		end
	end
	
	--[[Override--]] function self:should_remove()
		return (_game._audio_manager:is_ready_to_play() == true or _back_button_pressed) and all_players_loaded
	end
	
	--[[Override--]] function self:do_remove()
		_loading_ui:Destroy()
		if _back_button_pressed == true then
			_game:teardown()
		else
			_game:start_game()
			_local_services._menus:push_menu(InGameMenu:new(_local_services, _game, _start_song_key))
		end
	end
	
	--[[Override--]] function self:set_is_top_element(val)
		if val then
			_loading_ui.Parent = EnvironmentSetup:get_player_gui_root()
		else
			_loading_ui.Parent = nil
		end
	end
	
	self:cons()
	return self
end

return SongStartMenu