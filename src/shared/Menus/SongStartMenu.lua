local MenuBase = require(game.ReplicatedStorage.Shared.Menus.System.MenuBase)
local FlashEvery = require(game.ReplicatedStorage.Shared.Utils.FlashEvery)

local InGameMenu = require(game.ReplicatedStorage.Shared.Menus.InGameMenu)

local SongStartMenu = {}

function SongStartMenu:new(_local_services, _start_song_key, _local_player_slot, _multiplayer_client)
	-- local self = MenuBase:new()
	
	-- local _game
	
	-- function self:cons()		
	-- 	EnvironmentSetup:set_mode(EnvironmentSetup.Mode.Game)
		
	-- 	
	-- 	
	-- 	
	-- end
	
	-- --[[Override--]] function self:update(dt_scale)
	-- 	_game:update(dt_scale)
	-- 	_loading_time_sec = _loading_time_sec + CurveUtil:TimescaleToDeltaTime(dt_scale)
	-- end
	
	-- --[[Override--]] function self:should_remove()
	-- 	return _game._audio_manager:is_ready_to_play() == true
	-- end
	
	-- --[[Override--]] function self:do_remove()
	-- 	if false then
	-- 		_game:teardown()
	-- 	else
	-- 		_local_services._state:dispatch("setIsLoading", {
	-- 			value = false
	-- 		})
	-- 		_game:start_game()
	-- 		_local_services._menus:push_menu(InGameMenu:new(_local_services, _game, _start_song_key, _multiplayer_client))
	-- 	end
	-- end
	
	-- self:cons()
	-- return self
end

return SongStartMenu