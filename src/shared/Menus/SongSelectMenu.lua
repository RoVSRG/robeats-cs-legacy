local MenuBase = require(game.ReplicatedStorage.Shared.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local DebugOut = require(game.ReplicatedStorage.Shared.Utils.DebugOut)
local InputUtil = require(game.ReplicatedStorage.Shared.Utils.InputUtil)
local GameSlot = require(game.ReplicatedStorage.RobeatsGameCore.Enums.GameSlot)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local SFXManager = require(game.ReplicatedStorage.RobeatsGameCore.SFXManager)
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

-- local LeaderboardDisplay = require(game.ReplicatedStorage.Shared.Menus.Utils.LeaderboardDisplay)
local SongStartMenu = require(game.ReplicatedStorage.Shared.Menus.SongStartMenu)
-- local SettingsMenu = require(game.ReplicatedStorage.Shared.Menus.SettingsMenu)
-- local MultiplayerLobbyMenu = require(game.ReplicatedStorage.Shared.Menus.MultiplayerLobbyMenu)
local Configuration	= require(game.ReplicatedStorage.Shared.Data.Configuration)

local Tabs = require(game.ReplicatedStorage.Shared.Menus.Utils.Tabs)

local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

local SongSelectMenu = {}

function SongSelectMenu:new(_local_services, _multiplayer_client)
	local self = MenuBase:new()

	local _selected_songkey = SongDatabase:invalid_songkey()

	local _current_sfx

	local rate = 100

	local _state = _local_services._state

	local section_container
	local should_remove = false

	--local ResultsMenu = require(game.ReplicatedStorage.Shared.Menus.ResultsMenu)

	local function getState()
		return _local_services._state:get_state()
	end
	
	function self:cons()
		_state:bind_to_change(function(new_state, old_state, didChange)
			didChange(new_state.gameData.songRate, old_state.gameData.songRate, function()
				rate = new_state.gameData.songRate
				self:on_rate_change()
			end)
			didChange(new_state.gameData.selectedSongKey, old_state.gameData.selectedSongKey, function()
				_selected_songkey = new_state.gameData.selectedSongKey
				self:play_preview()
			end)
		end)
	end

	function self:update(dt_scale)
		if _local_services._input:control_just_pressed(InputUtil.KEYCODE_UPRATE) then
			_state:dispatch("changeRate", {
				delta = 5
			})
		elseif _local_services._input:control_just_pressed(InputUtil.KEYCODE_DOWNRATE) then
			_state:dispatch("changeRate", {
				delta = -5
			})
		end
	end

	function self:on_rate_change()
		if _current_sfx then
			_current_sfx.PlaybackSpeed = rate/100
		end
	end

	function self:should_remove()
		return should_remove
	end

	function self:play_button_pressed()
		_local_services._sfx_manager:play_sfx(SFXManager.SFX_BUTTONPRESS)
		if SongDatabase:contains_key(_selected_songkey) then
			if _multiplayer_client then
				_multiplayer_client:change_song_key(_selected_songkey)
				should_remove = true
			else
				_local_services._menus:push_menu(SongStartMenu:new(_local_services, _selected_songkey, GameSlot.SLOT_1))
			end
		end
	end

	function self:play_preview()
		if _selected_songkey == SongDatabase:invalid_songkey() then return end

		if _current_sfx then
			_current_sfx:Stop()
		end

		local audio_id = SongDatabase:get_data_for_key(_selected_songkey).AudioAssetId

		_current_sfx = _local_services._sfx_manager:play_sfx(audio_id, 0)
		_current_sfx.Loaded:Connect(function()
			_current_sfx.TimePosition = NumberUtil.Lerp(0,_current_sfx.TimeLength,0.35)
			_current_sfx.PlaybackSpeed = rate/100
			local volume_tween_info = TweenInfo.new(3)
			local volume_tween = TweenService:Create(_current_sfx, volume_tween_info, {
				Volume = 0.5
			})
			volume_tween:Play()
		end)
		_current_sfx.Looped = true
	end
	
	self:cons()
	
	return self
end

return SongSelectMenu