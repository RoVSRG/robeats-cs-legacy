local MenuBase = require(game.ReplicatedStorage.Shared.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.Engine.EnvironmentSetup)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local RobeatsGame = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.Engine)
local AudioManager = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.Engine.AudioManager)
local Network = require(game.ReplicatedStorage.Libraries.Network)
local Configuration = require(game.ReplicatedStorage.Shared.Core.Data.Configuration)
local DebugOut = require(game.ReplicatedStorage.Shared.Utils.DebugOut)

local UserInputService = game:GetService("UserInputService")

local SettingsMenu = {}

function SettingsMenu:new(_local_services)
	local self = MenuBase:new()
	
	local _do_remove = false

	local _input = _local_services._input

	local _settings_ui
	
	function self:cons()
		_settings_ui = EnvironmentSetup:get_menu_protos_folder().SettingsUI:Clone()

		local section_container = _settings_ui.SectionContainer
		local tab_container = _settings_ui.TabContainer

		local keybinds = section_container.Keybinds
		local offset = section_container.Offset
		local notespeed = section_container.Notespeed
		local timing = section_container.TimingPresets
		local back = tab_container.BackButton
		local keybind_buttons = {keybinds.Keybind1, keybinds.Keybind2, keybinds.Keybind3, keybinds.Keybind4}

		local function updateNSMULT()
			notespeed.Display.Label.Text = string.format("%d ms", Configuration.Preferences.NoteSpeed)
		end

		local function updateADOFFSET()
			offset.Display.Label.Text = string.format("%dms",Configuration.Preferences.AudioOffset)
		end
		
		local function updateTIMING()
			for i,v in pairs(timing:GetChildren()) do
				if v.ClassName == "TextButton" then
					v.BackgroundColor3 = Color3.fromRGB(15,15,15)
					v.KeybindLabel.Text = "Set"
					if v.Label.Text == Configuration.Preferences.Preset then
						v.BackgroundColor3 = Color3.fromRGB(16,212,82)
						v.KeybindLabel.Text = "Enabled"
					end
				end
			end
		end
		
		local function updateKEYBINDS()
			for itr_i, v in pairs(keybind_buttons) do
				-- SET THE TEXT TO THE PROPER KEYCODE ON INITIALIZATION
				local itr_keybinds = Configuration.Preferences.Keybinds[itr_i]
				local str = ""
				for i_key,key in pairs(itr_keybinds) do
					str = str .. key.Name
					if i_key ~= #itr_keybinds then
						str = str .. "/"
					end
				end
				v.KeybindLabel.Text = str
				SPUtil:bind_input_fire(v, function()
					v.KeybindLabel.Text = "Press Key..."
					local u = UserInputService.InputBegan:Wait()
					Configuration.Preferences.Keybinds[itr_i] = {u.KeyCode}
				end)
			end
		end
		
		--//TIMING PRESETS
		
		for i,v in pairs(timing:GetChildren()) do
			if v.ClassName == "TextButton" then
				SPUtil:bind_input_fire(v, function()
					Configuration.Preferences.Preset = v.Label.Text
					updateTIMING(v)
				end)
			end
		end

		--//NOTESPEED
		SPUtil:bind_input_fire(notespeed.Minus, function()
			Configuration.Preferences.NoteSpeed -= 10
			updateNSMULT()
		end)

		SPUtil:bind_input_fire(notespeed.Plus, function()
			Configuration.Preferences.NoteSpeed += 10
			updateNSMULT()
		end)

		--//OFFSET
		SPUtil:bind_input_fire(offset.Minus, function()
			Configuration.Preferences.AudioOffset = Configuration.Preferences.AudioOffset - 1
			updateADOFFSET()
		end)

		SPUtil:bind_input_fire(offset.Plus, function()
			Configuration.Preferences.AudioOffset = Configuration.Preferences.AudioOffset + 1
			updateADOFFSET()
		end)

		SPUtil:bind_input_fire(back, function()
			_do_remove = true
		end)

		--//KEYBINDS
		for itr_i, v in pairs(keybind_buttons) do
			SPUtil:bind_input_fire(v, function()
				v.Text = "Press Key..."
				local u = UserInputService.InputBegan:Wait()
				Configuration.Preferences.Keybinds[itr_i] = {u.KeyCode}
				updateKEYBINDS()
			end)
		end
		
		SPUtil:bind_input_fire(tab_container.Reset, function()
			Configuration.Preferences = SPUtil:copy_table(require(game.ReplicatedStorage.Shared.Core.Data.DefaultSettings))
			updateNSMULT()
			updateADOFFSET()
			updateKEYBINDS()
			updateTIMING()
		end)

		updateNSMULT()
		updateADOFFSET()
		updateKEYBINDS()
		updateTIMING()
	end

	function self:save_settings()
		spawn(function()
			DebugOut:puts("Saving settings...")
			Network.SaveSettings:Fire(Configuration.Preferences)
		end)
	end
	
	--[[Override--]] function self:update(dt_scale)
	end
	
	--[[Override--]] function self:should_remove()
		return _do_remove
	end
	
	--[[Override--]] function self:do_remove()
		self:save_settings()
		_settings_ui:Destroy()
	end

	--[[Override--]] function self:set_is_top_element(val)
		if val then
			_settings_ui.Parent = EnvironmentSetup:get_player_gui_root()
		else
			_settings_ui.Parent = nil
		end
	end
	
	self:cons()
	return self
end

return SettingsMenu
