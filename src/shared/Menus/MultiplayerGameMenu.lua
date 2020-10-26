local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local MenuBase = require(game.ReplicatedStorage.Menus.System.MenuBase)
local FlashEvery = require(game.ReplicatedStorage.Shared.FlashEvery)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)

local Network = require(game.ReplicatedStorage.Network)

local MultiplayerLobbyMenu = {}

MultiplayerLobbyMenu.ButtonColors = { --smh my head
    transfer_host = Color3.fromRGB(50, 188, 0);
    change_song = Color3.fromRGB(20, 20, 20)
}

function MultiplayerLobbyMenu:new(_local_services, _game_client)
	local self = MenuBase:new()
	
    local _multiplayer_game_ui
    local _multiplayer_player_slot_proto

    local section_container
    local tab_container

    local _should_remove = false

    local _test_toggle = false

    local test_toggle_flash = FlashEvery:new(1)
	
	function self:cons()
        _multiplayer_game_ui = EnvironmentSetup:get_menu_protos_folder().MultiplayerGameUI:Clone()
        
        section_container = _multiplayer_game_ui.SectionContainer
        tab_container = _multiplayer_game_ui.TabContainer

        _multiplayer_player_slot_proto = section_container.PlayerSection.PlayerList.PlayerListElementProto
        _multiplayer_player_slot_proto.Parent = nil

        for i, player_id in pairs(_game_client:get_players()) do
            local itr_player_slot = _multiplayer_player_slot_proto:Clone()
            local itr_player_slot_cover = itr_player_slot.PlayerCover
            itr_player_slot_cover.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", player_id)
            itr_player_slot_cover.NameDisplay.Text = SPUtil:player_name_from_id(player_id)
            itr_player_slot.Parent = section_container.PlayerSection.PlayerList
        end

        SPUtil:bind_input_fire(tab_container.LeaveRoomButton, function()
            _should_remove = true
            _game_client:leave_room()
        end)
    end
    
    --[[Override--]] function self:should_remove()
        return _should_remove
    end
	
	--[[Override--]] function self:do_remove()
		_multiplayer_game_ui:Destroy()
	end
	
	--[[Override--]] function self:set_is_top_element(val)
		if val then
			_multiplayer_game_ui.Parent = EnvironmentSetup:get_player_gui_root()
		else
			_multiplayer_game_ui.Parent = nil
		end
    end

    --[[Override--]] function self:update(dt_scale)
        test_toggle_flash:update(dt_scale)
        if test_toggle_flash:do_flash() then
            
        end
    end
    
    function self:toggle_host_perms(val)
        --BEFORE YOU ASK, THIS IS A CLIENT SIDED METHOD THAT CHANGES THE APPEARANCE OF THE GUI IF THE USER IS A HOST OR NOT, IT DOES NOT GIVE HOST PERMISSIONS IN AND OF ITSELF
        local grey_out_color_3 = Color3.fromRGB(59, 59, 59)
        tab_container.TransferHostButton.BackgroundColor3 = val and MultiplayerLobbyMenu.ButtonColors.transfer_host or grey_out_color_3
        tab_container.ChangeSongButton.BackgroundColor3 = val and MultiplayerLobbyMenu.ButtonColors.change_song or grey_out_color_3
    end

    self:cons()
	return self
end

return MultiplayerLobbyMenu