local MenuBase = require(game.ReplicatedStorage.Shared.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local SPDict = require(game.ReplicatedStorage.Shared.Utils.SPDict)
local FlashEvery = require(game.ReplicatedStorage.Shared.Utils.FlashEvery)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local RobeatsGame = require(game.ReplicatedStorage.RobeatsGameCore.RobeatsGame)
local AudioManager = require(game.ReplicatedStorage.RobeatsGameCore.AudioManager)
local DebugOut = require(game.ReplicatedStorage.Shared.Utils.DebugOut)
local Network = require(game.ReplicatedStorage.Libraries.Network)
local Configuration = require(game.ReplicatedStorage.Shared.Data.Configuration)

local InGameMenu = {}

function InGameMenu:new(_local_services, _game, _song_key, _multiplayer_client)

	local ResultsMenu = require(game.ReplicatedStorage.Shared.Menus.ResultsMenu)

	local self = MenuBase:new()

	-- local _force_quit = false

	-- local is_first_frame = true

	-- local _player_slot_proto

	-- local _multi_send_retrieve_data = FlashEvery:new(2)
	-- local _multiplayer_protos = SPDict:new()
	
	function self:cons()
		_local_services._state:dispatch("setForceQuit", {
			value = false
		})
	end
	
	--[[Override--]] function self:update(dt_scale)
		_game:update(dt_scale)
		--_multi_send_retrieve_data:update(dt_scale)
		
		if _game._audio_manager:get_mode() == AudioManager.Mode.PreStart then
			_game._audio_manager:raise_pre_start_trigger()
		end
		
		if _game._audio_manager:is_finished() then
			_game:set_mode(RobeatsGame.Mode.GameEnded)
		end

		if _local_services._state:get_state().gameData.forceQuit then
			if _game._audio_manager:get_mode() == AudioManager.Mode.Playing then
				_force_quit = true
				_game:set_mode(RobeatsGame.Mode.GameEnded)
			end
		end

		-- _stat_display_ui.GradeDisplay.Text = string.format("%.2f",_game._score_manager:get_accuracy()) .. "%"
		-- _stat_display_ui.ScoreDisplay.Text = math.floor(_game._score_manager:get_score() + 0.5)

		local marv_count, perf_count, great_count, good_count, bad_count, miss_count, max_combo, score = _game._score_manager:get_end_records()
		local combo = _game._score_manager:get_chain()
		local accuracy = _game._score_manager:get_accuracy()

		--if total_count == 0 and not is_first_frame then return end

		local song_length = _game._audio_manager:get_song_length_ms()
		local song_time = _game._audio_manager:get_current_time_ms()

		local ms_remaining = song_length - song_time

		_local_services._state:dispatch("changeStats", {
			score = score;
			marvelouses = marv_count;
			perfects = perf_count;
			greats = great_count;
			goods = good_count;
			bads = bad_count;
			misses = miss_count;
			combo = combo;
			accuracy = accuracy;
			time_left = ms_remaining;
		})
	end
	
	--[[Override--]] function self:should_remove()
		return _game:get_mode() == RobeatsGame.Mode.GameEnded
	end
	
	--[[Override--]] function self:do_remove()
		
		local marv_count, perf_count, great_count, good_count, bad_count, miss_count, max_combo, score = _game._score_manager:get_end_records()
		local accuracy = _game._score_manager:get_accuracy()


		local data = {
			mapid = _song_key;
			accuracy = accuracy;
			maxcombo = max_combo;
			marvelouses = marv_count;
			perfects = perf_count;
			greats = great_count;
			goods = good_count;
			bads = bad_count;
			misses = miss_count;
			score = score;
			rate = 1;
		}

		data.hitdeviance = _game._score_manager:get_hit_deviance()

		local average_offset = 0

		for i, v in pairs(data.hitdeviance) do
			average_offset += v.time_to_end
		end

		average_offset /= (#data.hitdeviance == 0 and 1 or #data.hitdeviance)

		data.mean = average_offset
	--[[
		spawn(function()
			if not _force_quit then
				DebugOut:puts("Writing score...")
				local _to_send = SPUtil:copy_table(data)
				Network.SubmitScore:Fire(_to_send)
				DebugOut:puts("Score has been written!")
			else
				print("Score not submitted because you force quitted!")
			end
		end)
		]]

		_local_services._state:dispatch("setIsPlaying", {
			value = false
		})

		_game:teardown()

		_local_services._menus:push_menu(ResultsMenu:new(_local_services, data))
	end
	
	self:cons()
	return self
end

return InGameMenu