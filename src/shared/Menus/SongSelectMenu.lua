local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local GameSlot = require(game.ReplicatedStorage.RobeatsGameCore.Enums.GameSlot)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SFXManager = require(game.ReplicatedStorage.RobeatsGameCore.SFXManager)
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local LeaderboardDisplay = require(game.ReplicatedStorage.Menus.Utils.LeaderboardDisplay)
local SongStartMenu = require(game.ReplicatedStorage.Menus.SongStartMenu)
local SettingsMenu = require(game.ReplicatedStorage.Menus.SettingsMenu)
local MultiplayerLobbyMenu = require(game.ReplicatedStorage.Menus.MultiplayerLobbyMenu)
local Configuration	= require(game.ReplicatedStorage.Configuration)
local CustomServerSettings = require(game.Workspace.CustomServerSettings)

local Tabs = require(game.ReplicatedStorage.Menus.Utils.Tabs)

local NumberUtil = require(game.ReplicatedStorage.Libraries.NumberUtil)

local SongSelectMenu = {}

function SongSelectMenu:new(_local_services, _multiplayer_client)
	local self = MenuBase:new()

	local _song_select_ui
	local _selected_songkey = SongDatabase:invalid_songkey()
	local _is_supporter = false

	local section_container
	local tab_container
	local should_remove = false

	local song_list_element_proto

	local _input = _local_services._input

	local _leaderboard_display

	local ResultsMenu = require(game.ReplicatedStorage.Menus.ResultsMenu)

	local _tabs
	local _current_sfx

	local tabs_base
	
	function self:cons()
		local tab_button_expand = UDim2.new(0,10,0,2)
		_song_select_ui = EnvironmentSetup:get_menu_protos_folder().SongSelectUI:Clone()

		section_container = _song_select_ui.SectionContainer
		tab_container = _song_select_ui.TabContainer

		tabs_base = section_container.TabsSection.Tabs

		_tabs = Tabs:new({
			tabs_base.SongSection;
			tabs_base.LeaderboardSection;
		}, "SongSection")
	

		local song_list = tabs_base.SongSection.SongList
		
		--Expand the scrolling list to fit contents
		song_list.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			song_list.CanvasSize = UDim2.new(0, 0, 0, song_list.UIListLayout.AbsoluteContentSize.Y)
		end)
		
		song_list_element_proto = song_list.SongListElementProto
		song_list_element_proto.Parent = nil
		for itr_songkey, itr_songdata in SongDatabase:key_itr() do
			self:add_song_button(itr_songkey)
		end
		
		_leaderboard_display = LeaderboardDisplay:new(_local_services, tabs_base.LeaderboardSection, tabs_base.LeaderboardSection.LeaderboardList.LeaderboardListElementProto, function(_slot_data)
			_local_services._menus:push_menu(ResultsMenu:new(_local_services, _slot_data))
		end)
		
		section_container.SongInfoSection.NoSongSelectedDisplay.Visible = true
		section_container.SongInfoSection.SongInfoDisplay.Visible = false
		section_container.PlayButton.Visible = false

		SPUtil:button(section_container.PlayButton, UDim2.new(-0.005,0,0,0), _local_services, function()
			self:play_button_pressed()
		end)

		SPUtil:bind_input_fire(tab_container.SettingsButton, function()
			_local_services._menus:push_menu(SettingsMenu:new(_local_services))
		end)

		SPUtil:bind_input_fire(tab_container.MultiplayerButton, function()
			_local_services._menus:push_menu(MultiplayerLobbyMenu:new(_local_services))
		end)

		SPUtil:button(section_container.SongInfoSection.SongInfoDisplay.NpsGraph.Items, UDim2.new(0,-2,0,-2), _local_services, function()
			local mouse = game.Players.LocalPlayer:GetMouse()
			local _a = NumberUtil.InverseLerp(
				section_container.SongInfoSection.SongInfoDisplay.NpsGraph.Items.AbsolutePosition.X,
				section_container.SongInfoSection.SongInfoDisplay.NpsGraph.Items.AbsolutePosition.X+section_container.SongInfoSection.SongInfoDisplay.NpsGraph.Items.AbsoluteSize.X,
				mouse.X
			)
			
			if _current_sfx and _current_sfx.IsLoaded then
				_current_sfx.TimePosition = _current_sfx.TimeLength*_a
			end
		end)

		section_container.SongInfoSection.NoSongSelectedDisplay.Visible = true

		tabs_base.SongSection.SearchBar.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			self:search_songs(tabs_base.SongSection.SearchBar.SearchBox.Text)
		end)

		MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, asset_id, is_purchased)
			if asset_id == CustomServerSettings.SupporterGamepassID and is_purchased == true then
				_is_supporter = true
				self:select_songkey(_selected_songkey)
				self:show_gamepass_menu()
			end
		end)

		SPUtil:bind_input_fire(section_container.TabsSection.TabsList.TabsLayout.Songs, function()
			_tabs:switch_tab("SongSection")
		end)

		SPUtil:bind_input_fire(section_container.TabsSection.TabsList.TabsLayout.Leaderboard, function()
			_tabs:switch_tab("LeaderboardSection")
		end)
		
		spawn(function()
			_is_supporter = MarketplaceService:UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, CustomServerSettings.SupporterGamepassID)
			self:select_songkey(_selected_songkey)
		end)
	end
	
	function self:select_songkey(songkey)
		if SongDatabase:contains_key(songkey) ~= true then return end
		section_container.SongInfoSection.NoSongSelectedDisplay.Visible = false
		_selected_songkey = songkey

		local total_notes, total_holds = SongDatabase:get_note_metrics_for_key(_selected_songkey)
		
		--SongDatabase:render_coverimage_for_key(section_container.SongInfoSection.SongInfoDisplay.SongCover, section_container.SongInfoSection.SongInfoDisplay.SongCover.SongCoverOverlay, _selected_songkey)
		section_container.SongInfoSection.SongInfoDisplay.Metadata.NameDisplay.Text = SongDatabase:get_title_for_key(_selected_songkey)
		section_container.SongInfoSection.SongInfoDisplay.Metadata.DifficultyDisplay.Text = string.format("Difficulty: %d",SongDatabase:get_difficulty_for_key(_selected_songkey))
		section_container.SongInfoSection.SongInfoDisplay.Metadata.ArtistDisplay.Text = SongDatabase:get_artist_for_key(_selected_songkey)
		section_container.SongInfoSection.SongInfoDisplay.Metadata.TotalNotesDisplay.Text = string.format("Total Notes: %d", total_notes)
		section_container.SongInfoSection.SongInfoDisplay.Metadata.TotalHoldsDisplay.Text = string.format("Total Holds: %d", total_holds)
		section_container.SongInfoSection.SongInfoDisplay.DescriptionDisplay.Text = SongDatabase:get_description_for_key(_selected_songkey)
		section_container.SongInfoSection.SongInfoDisplay.SongCover.Image = SongDatabase:get_image_for_key(_selected_songkey)

		section_container.SongInfoSection.SongInfoDisplay.Visible = true
		section_container.PlayButton.Visible = true
		
		_leaderboard_display:refresh_leaderboard(songkey)
		
		self:play_preview()
		self:update_nps_graph()
		self:update_length()
	end

	function self:update(dt_scale)
		if _local_services._input:control_just_pressed(InputUtil.KEYCODE_UPRATE) then
			Configuration.SessionSettings.Rate += 5
			self:on_rate_change()
		elseif _local_services._input:control_just_pressed(InputUtil.KEYCODE_DOWNRATE) then
			Configuration.SessionSettings.Rate -= 5
			self:on_rate_change()
		end

		section_container.SongInfoSection.SongInfoDisplay.Rate.Text = string.format("RATE: %0.2fx", Configuration.SessionSettings.Rate/100)
		if _current_sfx and _current_sfx.IsLoaded then
			section_container.SongInfoSection.SongInfoDisplay.NpsGraph.SongPosition:TweenPosition(UDim2.new(_current_sfx.TimePosition/_current_sfx.TimeLength,0,0,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.04, true)
		end
	end

	function self:on_rate_change()
		--Configuration.SessionSettings.Rate
		self:update_nps_graph()
		self:update_length()

		if _current_sfx then
			_current_sfx.PlaybackSpeed = Configuration.SessionSettings.Rate/100
		end
	end

	function self:update_nps_graph()
		for _, itr_nps_ob in pairs(section_container.SongInfoSection.SongInfoDisplay.NpsGraph.Items:GetChildren()) do
			if itr_nps_ob:IsA("Frame") then
				itr_nps_ob:Destroy()
			end
		end

		local nps_graph = SongDatabase:get_nps_graph_for_key(_selected_songkey)
		local max_nps = 0
		for _, nps in pairs(nps_graph) do
			max_nps = math.max(nps, max_nps)
		end

		local _rate = Configuration.SessionSettings.Rate/100

		for i, nps in pairs(nps_graph) do
			nps *= _rate
			local nps_point = Instance.new("Frame")
			nps_point.Parent = section_container.SongInfoSection.SongInfoDisplay.NpsGraph.Items
			nps_point.BorderSizePixel = 0
			nps_point.Size = UDim2.new(1/#nps_graph,0,0,0)
			nps_point:TweenSize(UDim2.new(1/#nps_graph, 0, nps/(max_nps+5), 0), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, (i/#nps_graph)*1.222, true)

			local _h = 242*(SPUtil:tra(math.clamp(nps/38, 0, 1)))
			nps_point.BackgroundColor3 = Color3.fromHSV(_h/360, 88/100, 100/100)
		end

		section_container.SongInfoSection.SongInfoDisplay.NpsGraph.MaxNps.Text = string.format("MAX NPS: %d", max_nps*_rate)
	end

	function self:update_length()
		section_container.SongInfoSection.SongInfoDisplay.Metadata.TotalLengthDisplay.Text = string.format("Total Length: %s",
			SPUtil:format_ms_time(SongDatabase:get_song_length_for_key(_selected_songkey)/(Configuration.SessionSettings.Rate/100))
		)
	end

	function self:add_song_button(songkey)
		local itr_list_element = song_list_element_proto:Clone()
		itr_list_element.Parent = tabs_base.SongSection.SongList
		itr_list_element.LayoutOrder = songkey

		--SongDatabase:render_coverimage_for_key(song_cover, song_cover.SongCoverOverlay, itr_songkey)
		itr_list_element.SongCover.Image = SongDatabase:get_image_for_key(songkey)
		itr_list_element.NameDisplay.Text = SongDatabase:get_title_for_key(songkey)
		itr_list_element.DifficultyDisplay.Text = string.format("Difficulty: %d",SongDatabase:get_difficulty_for_key(songkey))
		if SongDatabase:key_get_audiomod(songkey) == SongDatabase.SongMode.SupporterOnly then
			itr_list_element.DifficultyDisplay.Text = itr_list_element.DifficultyDisplay.Text .. " (Supporter Only)"
		end
		
		SPUtil:button(itr_list_element, UDim2.new(0,4,0,20), _local_services, function(input)
			_local_services._sfx_manager:play_sfx(SFXManager.SFX_BUTTONPRESS)
			self:select_songkey(songkey)
		end)
	end

	function self:search_songs(search)
		search = search or ""
		search = string.split(search, " ")
		for _, itr_songbutton in pairs(tabs_base.SongSection.SongList:GetChildren()) do
			if itr_songbutton:IsA("Frame") then
				itr_songbutton:Destroy()
			end
		end

		for itr_songkey, itr_songdata in SongDatabase:key_itr() do
			local _to_search = SongDatabase:get_searchable_string_for_key(itr_songkey)
			local found = 0
			for i = 1, #search do
				local search_term = search[i]
				if string.find(_to_search:lower(), search_term:lower()) ~= nil then
					found += 1
				end
			end
			if found == #search then
				self:add_song_button(itr_songkey)
			end
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
			_current_sfx.PlaybackSpeed = Configuration.SessionSettings.Rate/100
			local volume_tween_info = TweenInfo.new(3)
			local volume_tween = TweenService:Create(_current_sfx, volume_tween_info, {
				Volume = 0.5
			})
			volume_tween:Play()
		end)
		_current_sfx.Looped = true
	end
	
	--[[Override--]] function self:do_remove()
		if _current_sfx then
			_current_sfx:Stop()
		end
		_song_select_ui:Destroy()
	end
	
	--[[Override--]] function self:set_is_top_element(val)
		if val then
			self:play_preview()
			EnvironmentSetup:set_mode(EnvironmentSetup.Mode.Menu)
			_song_select_ui.Parent = EnvironmentSetup:get_player_gui_root()
			self:select_songkey(_selected_songkey)
		else
			if _current_sfx then
				_current_sfx:Stop()
			end
			_song_select_ui.Parent = nil
		end
	end
	
	self:cons()
	
	return self
end

return SongSelectMenu