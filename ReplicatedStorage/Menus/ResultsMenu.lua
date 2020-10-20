local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)

local Graph = require(game.ReplicatedStorage.Libraries.Graph)
local Metrics = require(game.ReplicatedStorage.Libraries.Data.Metrics)

local ResultsMenu = {}

ResultsMenu.HitColor = {
	[0] = Color3.fromRGB(255, 0, 0);
	[1] = Color3.fromRGB(190, 10, 240);
	[2] = Color3.fromRGB(56, 10, 240);
	[3] = Color3.fromRGB(7, 232, 74);
	[4] = Color3.fromRGB(252, 244, 5);
	[5] = Color3.fromRGB(255, 255, 255);
}

function ResultsMenu:new(_local_services, _score_data)
	local self = MenuBase:new()
	local _results_menu_ui
	local _input = _local_services._input

	local _should_remove = false

	local _grade_images = {
		"http://www.roblox.com/asset/?id=5702584062",
		"http://www.roblox.com/asset/?id=5702584273",
		"http://www.roblox.com/asset/?id=5702584488",
		"http://www.roblox.com/asset/?id=5702584846",
		"http://www.roblox.com/asset/?id=5702585057",
		"http://www.roblox.com/asset/?id=5702585272"
	}

	local _accuracy_marks = {100,95,90,80,70,60,50}
	
	function self:cons()
		_results_menu_ui = EnvironmentSetup:get_menu_protos_folder().ResultsMenuUI:Clone()

		local _song_length_ms = SongDatabase:get_song_length_for_key(_score_data.mapid)+2000


		local section_container = _results_menu_ui.SectionContainer
		local tab_container = _results_menu_ui.TabContainer

		SPUtil:bind_input_fire(tab_container.BackButton, function()
			_should_remove = true
		end)
		
		local _song_key = _score_data.mapid
		local _key_data = SongDatabase:get_data_for_key(_song_key)

		local img = ""
		for i = 1, #_accuracy_marks do
			local accuracyGrade = _accuracy_marks[i]
			if _score_data.accuracy >= accuracyGrade then
				img = _grade_images[i]
				break
			else
				img = _grade_images[#_grade_images]
			end
		end

		section_container.Banner.GradeContainer.Grade.Image = img or ""
		section_container.DataContainer.Accuracy.Data.Text = string.format("%0.2f%%", _score_data.accuracy)
		section_container.DataContainer.Score.Data.Text = math.floor(_score_data.scores) + 0.5

		local average_offset = 0

		for i, v in pairs(_score_data.hitdeviance) do
			average_offset += (v.hit_time_ms - v.expected_hit_time_ms)
		end

		average_offset /= (#_score_data.hitdeviance == 0 and 1 or #_score_data.hitdeviance)

		section_container.DataContainer.Rating.Data.Text = string.format("%0.2f", Metrics.calculate_rating(1, _score_data.accuracy, SongDatabase:get_difficulty_for_key(_song_key)))

		section_container.DataContainer.Mean.Data.Text = math.round(average_offset).."ms"
		
		section_container.DataContainer.MaxCombo.Data.Text = _score_data.maxcombo.."x"

		--HANDLE SPREAD RENDERING
		local _spread_display = section_container.SpreadContainer.SpreadDisplay

		local total_judges = #_key_data.HitObjects

		_spread_display.Marvelous.Total.Size = UDim2.new(_score_data.marvelouses/total_judges,0,1,0)
		_spread_display.Marvelous.TotalNumber.Text = _score_data.marvelouses

		_spread_display.Perfect.Total.Size = UDim2.new(_score_data.perfects/total_judges,0,1,0)
		_spread_display.Perfect.TotalNumber.Text = _score_data.perfects

		_spread_display.Great.Total.Size = UDim2.new(_score_data.greats/total_judges,0,1,0)
		_spread_display.Great.TotalNumber.Text = _score_data.greats

		_spread_display.Good.Total.Size = UDim2.new(_score_data.goods/total_judges,0,1,0)
		_spread_display.Good.TotalNumber.Text = _score_data.goods

		_spread_display.Bad.Total.Size = UDim2.new(_score_data.bads/total_judges,0,1,0)
		_spread_display.Bad.TotalNumber.Text = _score_data.bads

		_spread_display.Miss.Total.Size = UDim2.new(_score_data.misses/total_judges,0,1,0)
		_spread_display.Miss.TotalNumber.Text = _score_data.misses

		section_container.Banner.PlayerInfo.Text = string.format("Played by %s at %s",
			game.Players.LocalPlayer.Name,
			SPUtil:time_to_str(os.time())
		);

		section_container.Banner.MapInfo.Text = string.format("%s - %s [%0d]",
			SongDatabase:get_title_for_key(_song_key),
			SongDatabase:get_artist_for_key(_song_key),
			SongDatabase:get_difficulty_for_key(_song_key)
		)

		local hit_graph = Graph.Dot:new()

		hit_graph:attach_to_instance(section_container.HitContainer.Hits)
		hit_graph:set_bounds(_song_length_ms, -300, 0, 300)
		--hit_graph:add_markers(15000, -20) -- ADD LATER!!!!!

		for _, hit_data in pairs(_score_data.hitdeviance) do
			hit_graph:add_data_point({
				x = hit_data.hit_time_ms;
				y = hit_data.hit_time_ms - hit_data.expected_hit_time_ms;
				color = ResultsMenu.HitColor[hit_data.note_result];
			})
		end
	end

	function self:get_formatted_data(data)
		local str = "%.2f%% | %0d / %0d / %0d / %0d"
		return string.format(str, data.accuracy*100, data.perfects, data.greats, data.okays, data.misses)
	end
	
	--[[Override--]] function self:should_remove()
		return _should_remove
	end
	
	--[[Override--]] function self:do_remove()
		_results_menu_ui:Destroy()
	end
	
	--[[Override--]] function self:set_is_top_element(val)
		if val then
			EnvironmentSetup:set_mode(EnvironmentSetup.Mode.Menu)
			_results_menu_ui.Parent = EnvironmentSetup:get_player_gui_root()
		else
			_results_menu_ui.Parent = nil
		end
	end
	
	self:cons()
	
	return self
end

return ResultsMenu