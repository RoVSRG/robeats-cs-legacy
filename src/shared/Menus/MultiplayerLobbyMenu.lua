local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local RBXScriptSignalManager = require(game.ReplicatedStorage.Shared.RBXScriptSignalManager)

local MultiplayerClient = require(game.ReplicatedStorage.Multiplayer.MultiplayerClient)

local Network = require(game.ReplicatedStorage.Network)

local MultiplayerLobbyMenu = {}

function MultiplayerLobbyMenu:new(_local_services)
    local self = MenuBase:new()
    
    local MultiplayerGameMenu = require(game.ReplicatedStorage.Menus.MultiplayerGameMenu)
	
    local _multiplayer_lobby_ui
    local _multiplayer_slot_proto
    local _should_remove = false

    local section_container
    local tab_container

    local _signals = RBXScriptSignalManager:new()

    local _currently_selected_lobby
	
    function self:cons()
        _multiplayer_lobby_ui = EnvironmentSetup:get_menu_protos_folder().MultiplayerLobbyUI:Clone()

        section_container = _multiplayer_lobby_ui.SectionContainer
        tab_container = _multiplayer_lobby_ui.TabContainer

        _multiplayer_slot_proto = section_container.MultiSection.MultiList.MultiListElementProto
        _multiplayer_slot_proto.Parent = nil

        SPUtil:bind_input_fire(section_container.JoinButton, function()
            if _currently_selected_lobby then
                MultiplayerClient:join_room({
                    id = _currently_selected_lobby
                })
                local _game_client = MultiplayerClient:new({
                    id = _currently_selected_lobby
                })
                _local_services._menus:push_menu(MultiplayerGameMenu:new(_local_services, _game_client))
            end
        end)

        SPUtil:bind_input_fire(tab_container.CreateRoomButton, function()
            local _room_id = MultiplayerClient:add_room({
                name = "big chungus"
            })

            local _game_client = MultiplayerClient:new({
                id = _room_id
            })

            _local_services._menus:push_menu(MultiplayerGameMenu:new(_local_services, _game_client))
        end)

        for _, room in pairs(Network.GetRooms:Invoke() or {}) do
            self:add_lobby(room)
        end

        _signals:add_signal("RoomCreatedSignal", Network.RoomCreated:Connect(function(data)
            self:add_lobby(data)
        end))

        _signals:add_signal("RoomDeletedSignal", Network.RoomDeleted:Connect(function(data)
            self:remove_lobby(data)
        end))
	end
	
    --[[Override--]] function self:do_remove()
        _signals:disconnect_all()
		_multiplayer_lobby_ui:Destroy()
	end
	
	--[[Override--]] function self:set_is_top_element(val)
		if val then
			_multiplayer_lobby_ui.Parent = EnvironmentSetup:get_player_gui_root()
        else
			_multiplayer_lobby_ui.Parent = nil
		end
    end

    function self:add_lobby(data)
        if not section_container.MultiSection.MultiList:FindFirstChild(data.id) then
            local itr_multiplayer_slot = _multiplayer_slot_proto:Clone()
            itr_multiplayer_slot.MultiNameDisplay.Text = data.name
            itr_multiplayer_slot.MultiInfoDisplay.Text = string.format("%0d players", #data.players)
            itr_multiplayer_slot.Parent = section_container.MultiSection.MultiList
            itr_multiplayer_slot.Name = data.id or ""
            SPUtil:bind_input_fire(itr_multiplayer_slot, function()
                _currently_selected_lobby = data.id
            end)
        end
    end

    function self:remove_lobby(data)
        local room_proto = section_container.MultiSection.MultiList:FindFirstChild(data.id)
        if room_proto then
            room_proto:Destroy()
        end
    end
    
    function self:should_remove()
        return _should_remove
    end
	
	self:cons()
	return self
end

return MultiplayerLobbyMenu