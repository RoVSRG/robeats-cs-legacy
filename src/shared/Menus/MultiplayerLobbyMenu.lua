local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)

local MultiplayerLobbyMenu = {}

function MultiplayerLobbyMenu:new(_local_services, _header_text, _sub_text, _callback)
	local self = MenuBase:new()
	
	local _multiplayer_lobby_ui
	
	function self:cons()
		_multiplayer_lobby_ui = EnvironmentSetup:get_menu_protos_folder().MultiplayerLobbyUI:Clone()
		_multiplayer_lobby_ui.TitleDisplay.Text = _header_text
		_multiplayer_lobby_ui.SubDisplay.Text = _sub_text
		_multiplayer_lobby_ui.OkayButton.Activated:Connect(function()
			_callback()
			_local_services._menus:remove_menu(self)
		end)
		_multiplayer_lobby_ui.BackButton.Activated:Connect(function()
			_local_services._menus:remove_menu(self)
		end)
	end
	
	function self:hide_okay_button()
		_multiplayer_lobby_ui.OkayButton.Visible = false
		return self
	end
	
	function self:hide_back_button()
		_multiplayer_lobby_ui.BackButton.Visible = false
		return self
	end
	
	--[[Override--]] function self:do_remove()
		_multiplayer_lobby_ui:Destroy()
	end
	
	--[[Override--]] function self:set_is_top_element(val)
		if val then
			_multiplayer_lobby_ui.Parent = EnvironmentSetup:get_player_gui_root()
		else
			_multiplayer_lobby_ui.Parent = nil
		end
	end
	
	self:cons()
	return self
end

return MultiplayerLobbyMenu