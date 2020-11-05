local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local AssertType = require(game.ReplicatedStorage.Shared.AssertType)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local GameSlot = require(game.ReplicatedStorage.RobeatsGameCore.Enums.GameSlot)

local SongStartMenu = require(game.ReplicatedStorage.Menus.SongStartMenu)

local RBXScriptSignalManager = require(game.ReplicatedStorage.Shared.RBXScriptSignalManager)

local Network = require(game.ReplicatedStorage.Network)

local MultiplayerGameMenu = {}

MultiplayerGameMenu.ButtonColors = { --smh my head
	transfer_host = Color3.fromRGB(50, 188, 0);
	change_song = Color3.fromRGB(20, 20, 20)
}

function MultiplayerGameMenu:new(_local_services, _multiplayer_client)
	local self = MenuBase:new()

	local SongSelectMenu = require(game.ReplicatedStorage.Menus.SongSelectMenu)

	local _multiplayer_game_ui
	local _multiplayer_player_slot_proto

	local section_container
	local tab_container

	local _selected_songkey = SongDatabase:invalid_songkey()

	local _should_remove = false

	local is_host = false

	local _signals = RBXScriptSignalManager:new()

	function self:cons()
		_multiplayer_game_ui = EnvironmentSetup:get_menu_protos_folder().MultiplayerGameUI:Clone()

		section_container = _multiplayer_game_ui.SectionContainer
		tab_container = _multiplayer_game_ui.TabContainer

		_multiplayer_player_slot_proto = section_container.PlayerSection.PlayerList.PlayerListElementProto
		_multiplayer_player_slot_proto.Parent = nil

		for i, player_id in pairs(_multiplayer_client:get_players()) do
			self:add_player({
				userid = player_id
			})
		end

		SPUtil:bind_input_fire(tab_container.LeaveRoomButton, function()
			_should_remove = true
			_multiplayer_client:leave_room()
		end)

		SPUtil:bind_input_fire(tab_container.ChangeSongButton, function()
			if is_host then
				_local_services._menus:push_menu(SongSelectMenu:new(_local_services, _multiplayer_client))
			end
		end)

		SPUtil:bind_input_fire(section_container.PlayButton, function()
			_multiplayer_client:start_game()
		end)

		_signals:add_signal("PlayerJoinedRoomSignal", _multiplayer_client:bind_to_player_joined_room(function(data)
			DebugOut:puts(string.format("Player(%d) added!", data.userid))
			self:add_player(data)
		end))

		_signals:add_signal("PlayerLeftRoomSignal", _multiplayer_client:bind_to_player_left_room(function(data)
			DebugOut:puts(string.format("Player(%d) left!", data.userid))
			self:remove_player(data)
		end))

		_signals:add_signal("SongChangedRoomSignal", _multiplayer_client:bind_to_song_changed_room(function(data)
			DebugOut:puts(string.format("Song changed(%d)", data.song_key))
			self:change_song(data.song_key)
		end))

		_signals:add_signal("HostChangedRoomSignal", _multiplayer_client:bind_to_host_changed_room(function(data)
			DebugOut:puts(string.format("Host changed(%d)", data.userid))
			self:change_song(data.song_key)
		end))

		_signals:add_signal("GameStartedSignal", _multiplayer_client:bind_to_game_started_room(function(data)
			_local_services._menus:push_menu(SongStartMenu:new(_local_services, _selected_songkey, GameSlot.SLOT_1, _multiplayer_client))
		end))

		self:update_player_count(#_multiplayer_client:get_players())

		is_host = _multiplayer_client:is_host()
		self:toggle_host_perms(is_host)
	end

	function self:add_player(data)
		if not section_container.PlayerSection.PlayerList:FindFirstChild(data.userid) then
			local room_data = _multiplayer_client:get_room_data()
			AssertType:is_non_nil(data, "Data table cannot be nil!")
			AssertType:is_number(data.userid, "UserId must be a valid UserId number!")
			local itr_player_slot = _multiplayer_player_slot_proto:Clone()
			local itr_player_slot_cover = itr_player_slot.PlayerCover
			itr_player_slot_cover.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png",  data.userid)
			itr_player_slot_cover.NameDisplay.Text = SPUtil:player_name_from_id(data.userid)
			itr_player_slot.Name = data.userid
			itr_player_slot.Parent = section_container.PlayerSection.PlayerList
		end
	end

	function self:remove_player(data)
		local _player_slot = section_container.PlayerSection.PlayerList:FindFirstChild(tostring(data.userid))

		if _player_slot then
			_player_slot:Destroy()
		end
	end

	function self:change_song(song_key)
		_selected_songkey = song_key

		section_container.InfoSection.InfoDisplay.DifficultyDisplay.Text = string.format("Difficulty: %d",SongDatabase:get_difficulty_for_key(song_key))
		section_container.InfoSection.InfoDisplay.SongCover.Image = SongDatabase:get_image_for_key(song_key)
		section_container.InfoSection.InfoDisplay.SongDisplay.Text = SongDatabase:get_title_for_key(song_key)
	end

	function self:change_multi_name(name)
		section_container.InfoSection.InfoDisplay.MultiNameDisplay.Text = name
	end

	function self:update_player_count(count)
		section_container.InfoSection.InfoDisplay.DescriptionDisplay.Text = string.format("%0d players", count)
	end

	--[[Override--]] function self:should_remove()
		return _should_remove
	end

	--[[Override--]] function self:do_remove()
		_signals:disconnect_all()
		_multiplayer_game_ui:Destroy()
	end

	--[[Override--]] function self:set_is_top_element(val)
		if val then
			_multiplayer_game_ui.Parent = EnvironmentSetup:get_player_gui_root()
		else
			_multiplayer_game_ui.Parent = nil
		end
	end

	--[[Override--]] function self:update(dt_scale)

	end

	function self:toggle_host_perms(val)
		local grey_out_color_3 = Color3.fromRGB(59, 59, 59)
		tab_container.TransferHostButton.BackgroundColor3 = val and MultiplayerGameMenu.ButtonColors.transfer_host or grey_out_color_3
		tab_container.ChangeSongButton.BackgroundColor3 = val and MultiplayerGameMenu.ButtonColors.change_song or grey_out_color_3
	end

	self:cons()
	return self
end

return MultiplayerGameMenu