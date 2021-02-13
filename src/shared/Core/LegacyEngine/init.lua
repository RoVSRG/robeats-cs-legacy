local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)
local InputUtil = require(game.ReplicatedStorage.Shared.Utils.InputUtil)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local SPDict = require(game.ReplicatedStorage.Shared.Utils.SPDict)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local AudioManager = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.AudioManager)
local SFXManager = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.SFXManager)
local ScoreManager = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.ScoreManager)
local NoteTrackSystem = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.NoteTrack.NoteTrackSystem)
local EffectSystem = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.Effects.EffectSystem)
local GameSlot = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.Enums.GameSlot)
local GameTrack = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.Enums.GameTrack)
local DebugOut = require(game.ReplicatedStorage.Shared.Utils.DebugOut)
local AssertType = require(game.ReplicatedStorage.Shared.Utils.AssertType)
local ObjectPool = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.ObjectPool)

local RobeatsGame = {}
RobeatsGame.Mode = {
	Setup = 1;
	Game = 2;
	GameEnded = 3;
}

function RobeatsGame:new(_game_environment_center_position)
	local self = {
		_tracksystems = SPDict:new();
		_audio_manager = nil;
		_score_manager = nil;
		_effects = EffectSystem:new();
		_input = InputUtil:new();
		_sfx_manager = SFXManager:new();
		_object_pool = ObjectPool:new();
	}
	self._audio_manager = AudioManager:new(self)
	self._score_manager = ScoreManager:new(self)
	
	local _local_game_slot = 0
	function self:get_local_game_slot() return _local_game_slot end
	
	local _current_mode = RobeatsGame.Mode.Setup
	function self:get_mode() return _current_mode end
	function self:set_mode(val) 
		AssertType:is_enum_member(val, RobeatsGame.Mode)
		_current_mode = val 
	end

	function self:get_game_environment_center_position()
		return _game_environment_center_position
	end

	function self:setup_world(game_slot)
		_local_game_slot = game_slot
		workspace.CurrentCamera.CFrame = GameSlot:slot_to_camera_cframe_offset(self:get_local_game_slot()) + self:get_game_environment_center_position()
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		workspace.CurrentCamera.CameraSubject = nil
	end

	function self:start_game()
		self._tracksystems:add(self:get_local_game_slot(),NoteTrackSystem:new(self,self:get_local_game_slot()))
		self._audio_manager:start_play()
		_current_mode = RobeatsGame.Mode.Game
	end

	function self:get_tracksystem(index)
		return self._tracksystems:get(index)
	end
	function self:get_local_tracksystem()
		return self:get_tracksystem(self:get_local_game_slot())
	end
	function self:tracksystems_itr()
		return self._tracksystems:key_itr()
	end

	function self:update(dt_scale)
		if _current_mode == RobeatsGame.Mode.Game then
			self._audio_manager:update(dt_scale,self)
			for itr_key,itr_index in GameTrack:inpututil_key_to_track_index():key_itr() do
				if self._input:control_just_pressed(itr_key) then
					self:get_local_tracksystem():press_track_index(itr_index)
				end
				if self._input:control_just_released(itr_key) then
					self:get_local_tracksystem():release_track_index(itr_index)
				end
			end
			
			for slot,itr in self._tracksystems:key_itr() do
				itr:update(dt_scale)
			end
			
			self._sfx_manager:update(dt_scale)
			self._input:post_update()
			self._effects:update(dt_scale)
			self._score_manager:update(dt_scale)
		end
	end
	
	function self:teardown()
		for key,val in self:tracksystems_itr() do
			val:teardown()
		end
		self._audio_manager:teardown()
		self._effects:teardown()
	end

	return self
end

return RobeatsGame
