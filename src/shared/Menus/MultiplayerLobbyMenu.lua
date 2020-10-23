local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)

local Network = require(game.ReplicatedStorage.Network)

local MultiplayerLobbyMenu = {}

function MultiplayerLobbyMenu:new(_local_services, _header_text, _sub_text, _callback)
	local self = MenuBase:new()
	
    local _multiplayer_lobby_ui
    local _multiplayer_slot_proto
	
	function self:cons()
        _multiplayer_lobby_ui = EnvironmentSetup:get_menu_protos_folder().MultiplayerLobbyUI:Clone()
        
        local section_container = _multiplayer_lobby_ui.SectionContainer
        local tab_container = _multiplayer_lobby_ui.TabContainer

        _multiplayer_slot_proto = section_container.MultiSection.MultiList.MultiListElementProto
        _multiplayer_slot_proto.Parent = nil

        SPUtil:bind_input_fire(tab_container.CreateRoomButton, function()
            local _room_id = Network.AddRoom:Invoke({
                name = "big chungus"
            })
        end)

        local _rooms = Network.GetRooms:Invoke()

        for i, room in pairs(_rooms) do
            
        end
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