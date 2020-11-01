local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)

local Chat = {}

function Chat:new()

	local _chat_ui

	local self = MenuBase:new()

	function self:cons()
		_chat_ui = EnvironmentSetup:get_menu_protos_folder().InGameMenuStatDisplayUI:Clone()
		_chat_ui.Parent = EnvironmentSetup:get_player_gui_root()
	end

	--[[Override--]] function self:update(dt_scale)

	end

end

return Chat
