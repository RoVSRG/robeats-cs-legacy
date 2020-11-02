local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local FlashEvery = require(game.ReplicatedStorage.Shared.FlashEvery)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local RobeatsGame = require(game.ReplicatedStorage.RobeatsGameCore.RobeatsGame)
local AudioManager = require(game.ReplicatedStorage.RobeatsGameCore.AudioManager)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
local Network = require(game.ReplicatedStorage.Network)
local Configuration = require(game.ReplicatedStorage.Configuration)

local InGameMenu = {}

function InGameMenu:new(_local_services, _game, _song_key, _multiplayer_client)

	local ResultsMenu = require(game.ReplicatedStorage.Menus.ResultsMenu)

	local self = MenuBase:new()
	
	local _stat_display_ui

	local _force_quit = false

	local is_first_frame = true

	local _player_slot_proto

	local _multi_send_retrieve_data = FlashEvery:new(2)
	local _multiplayer_protos = SPDict:new()
	
	function self:cons()
		_stat_display_ui = EnvironmentSetup:get_menu_protos_folder().InGameMenuStatDisplayUI:Clone()
		_stat_display_ui.Parent = EnvironmentSetup:get_player_gui_root()

		_player_slot_proto = _stat_display_ui.MultiListDisplay.PlayerSlotProto
		_player_slot_proto.Parent = nil
		
		_stat_display_ui.ExitButton.Activated:Connect(function()
			if _game._audio_manager:get_mode() == AudioManager.Mode.Playing then
				_force_quit = true
				_game:set_mode(RobeatsGame.Mode.GameEnded)
			end
		end)
	end
	
	--[[Override--]] function self:update(dt_scale)
		_game:update(dt_scale)
		_multi_send_retrieve_data:update(dt_scale)
		
		if _game._audio_manager:get_mode() == AudioManager.Mode.PreStart then
			local did_raise_pre_start_trigger, raise_pre_start_trigger_val, raise_pre_start_trigger_duration = _game._audio_manager:raise_pre_start_trigger()
			if did_raise_pre_start_trigger == true then
				_stat_display_ui.ExitButton.Text = string.format("Starting in %d...", raise_pre_start_trigger_val)
			end
		elseif _game._audio_manager:get_mode() == AudioManager.Mode.Playing then
			_stat_display_ui.ExitButton.Text = "Exit"
		end
		
		if _game._audio_manager:is_finished() then
			_game:set_mode(RobeatsGame.Mode.GameEnded)
		end
		
		_stat_display_ui.ChainDisplay.Text = tostring(_game._score_manager:get_chain())
		_stat_display_ui.GradeDisplay.Text = string.format("%.2f",_game._score_manager:get_accuracy()) .. "%"
		_stat_display_ui.ScoreDisplay.Text = math.floor(_game._score_manager:get_score() + 0.5)

		local marv_count, perf_count, great_count, good_count, bad_count, miss_count, max_combo, score = _game._score_manager:get_end_records()
		local total_count = marv_count + perf_count + great_count + good_count + bad_count + miss_count

		if total_count == 0 and not is_first_frame then return end

		_stat_display_ui.SpreadDisplay.Marvs.Total:TweenSize(UDim2.new(marv_count/total_count, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		_stat_display_ui.SpreadDisplay.Marvs.Count.Text = marv_count

		_stat_display_ui.SpreadDisplay.Perfs.Total:TweenSize(UDim2.new(perf_count/total_count, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		_stat_display_ui.SpreadDisplay.Perfs.Count.Text = perf_count

		_stat_display_ui.SpreadDisplay.Greats.Total:TweenSize(UDim2.new(great_count/total_count, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		_stat_display_ui.SpreadDisplay.Greats.Count.Text = great_count

		_stat_display_ui.SpreadDisplay.Goods.Total:TweenSize(UDim2.new(good_count/total_count, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		_stat_display_ui.SpreadDisplay.Goods.Count.Text = good_count

		_stat_display_ui.SpreadDisplay.Bads.Total:TweenSize(UDim2.new(bad_count/total_count, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		_stat_display_ui.SpreadDisplay.Bads.Count.Text = bad_count

		_stat_display_ui.SpreadDisplay.Misses.Total:TweenSize(UDim2.new(miss_count/total_count, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		_stat_display_ui.SpreadDisplay.Misses.Count.Text = miss_count

		local song_length = _game._audio_manager:get_song_length_ms()
		local song_time = _game._audio_manager:get_current_time_ms()

		local ms_remaining = song_length - song_time
		_stat_display_ui.TimeLeftDisplay.Text = SPUtil:format_ms_time(ms_remaining/(Configuration.SessionSettings.Rate/100))

		--Handle multiplayer data

		if _multiplayer_client then
			if _multi_send_retrieve_data:do_flash() then
				--Upload stats to server
				_multiplayer_client:upload_stats({
					marvelous_count = marv_count;
					perfect_count = perf_count;
					great_count = great_count;
					good_count = good_count;
					bad_count = bad_count;
					miss_count = miss_count;
					accuracy = _game._score_manager:get_accuracy();
					max_combo = max_combo;
					score = score;
					combo = _game._score_manager:get_chain();
				})

				--Retrieve others' stats

				local _player_stats = _multiplayer_client:get_player_stats()

				table.sort(_player_stats, function(a, b)
					return a.score > b.score
				end)

				for i, plr in pairs(_player_stats) do
					if not _multiplayer_protos:contains(plr.userid) then
						local itr_proto = _player_slot_proto:Clone()
						itr_proto.Place.Text = string.format("#%d", i)
						itr_proto.PlayerName.Text = SPUtil:player_name_from_id(tonumber(plr.userid))
						itr_proto.Data.Text = string.format("Score: %0.0f | Accuracy = %0.2f", plr.score, plr.accuracy)
						itr_proto.Parent = _stat_display_ui.MultiListDisplay
						itr_proto.LayoutOrder = i
						_multiplayer_protos:add(plr.userid, itr_proto)
						return
					else
						local itr_proto = _multiplayer_protos:get(plr.userid)
						itr_proto.Place.Text = string.format("#%d", i)
						itr_proto.PlayerName.Text = SPUtil:player_name_from_id(tonumber(plr.userid))
						itr_proto.LayoutOrder = i
						itr_proto.Data.Text = string.format("Score: %0.0f | Accuracy = %0.2f", plr.score, plr.accuracy)
					end
				end
			end
		end

		is_first_frame = false
	end
	
	--[[Override--]] function self:should_remove()
		return _game:get_mode() == RobeatsGame.Mode.GameEnded
	end
	
	--[[Override--]] function self:do_remove()
		_stat_display_ui:Destroy()
		
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
			scores = score;
		}

		spawn(function()
			if not _force_quit then
				DebugOut:puts("Writing score...")
				Network.SubmitScore:Fire(data)
				DebugOut:puts("Score has been written!")
			else
				print("Score not submitted because you force quitted!")
			end
		end)

		data.hitdeviance = _game._score_manager:get_hit_deviance()

		_game:teardown()

		_local_services._menus:push_menu(ResultsMenu:new(_local_services, data))
	end
	
	self:cons()
	return self
end

return InGameMenu