local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local NoteTrack = require(game.ReplicatedStorage.Shared.Core.Engine.NoteTrack.NoteTrack)
local GameSlot = require(game.ReplicatedStorage.Shared.Core.Engine.Enums.GameSlot)
local DebugOut = require(game.ReplicatedStorage.Shared.Utils.DebugOut)
local NoteResult = require(game.ReplicatedStorage.Shared.Core.Engine.Enums.NoteResult)
local GameTrack = require(game.ReplicatedStorage.Shared.Core.Engine.Enums.GameTrack)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)
local HitParams = require(game.ReplicatedStorage.Shared.Core.Engine.HitParams)

local NoteTrackSystem = {}

function NoteTrackSystem:new(_game, _game_slot)
	local self = {}
	
	local _obj
	
	--List of all notes active for this system
	local _notes = SPList:new()
	
	--List of all tracks active for this system
	local _tracks = SPList:new()

	function self:cons()
		--Clone "NoteTrackSystemProto" and use the elements in-game
		_obj = EnvironmentSetup:get_element_protos_folder().NoteTrackSystemProto:Clone()
		_obj:SetPrimaryPartCFrame(SPUtil:look_at(
			_game:get_game_environment_center_position(),
			_game:get_game_environment_center_position() + GameSlot:slot_to_world_position_offset(_game_slot)
		))
		_obj.Parent = EnvironmentSetup:get_local_elements_folder()
		
		--For every defined enum value in GameTrack, create a NoteTrack for it
		for track_enum_name,track_enum_value in GameTrack:track_itr() do
			local tar_track_obj = _obj:FindFirstChild(track_enum_name)
			if tar_track_obj == nil then
				return DebugOut:errf("%s (Enum member of GameTrack) not found as child under NoteTrackSystemProto", track_enum_name)
			end
			_tracks:push_back(NoteTrack:new(_game, self, tar_track_obj, track_enum_value))
		end
	end
	
	function self:get_game_slot() return _game_slot end
	function self:get_notes() return _notes end

	function self:teardown()
		for i=1,_notes:count() do
			_notes:get(i):do_remove()
		end
		for i=1,_tracks:count() do
			_tracks:get(i):teardown()
		end
		_obj:Destroy()
	end

	function self:update(dt_scale)
		local time_started = tick()
		for i=1, _tracks:count() do
			local itr_track = _tracks:get(i)
			itr_track:update(dt_scale)
		end

		for i=_notes:count(),1,-1 do
			local itr_note = _notes:get(i)

			itr_note:update(dt_scale)

			if itr_note:should_remove() then
				itr_note:do_remove()
				_notes:remove_at(i)
			end
		end
		print(tick()-time_started)
	end
	
	function self:get_game_slot()
		return _game_slot
	end
	function self:get_track(index)
		return _tracks:get(index)
	end

	function self:press_track_index(track_index)
		self:get_track(track_index):press()
		local hit_found = false

		for i=1,_notes:count() do
			local itr_note = _notes:get(i)
			if itr_note:get_track_index() == track_index then
				local did_hit, note_result, time_to_end = itr_note:test_hit()
				if did_hit then
					itr_note:on_hit(note_result,i,time_to_end)
					hit_found = true
					break
				end
			end
		end

		if hit_found == false then
			--Ghost tapping, comment out to disable
			_game._score_manager:register_hit(
				NoteResult.Miss,
				_game_slot,
				track_index,
				HitParams:new():set_play_hold_effect(false):set_whiff_miss(true)
			)
		end
	end

	function self:release_track_index(track_index)
		self:get_track(track_index):release()

		for i=1,_notes:count() do
			local itr_note = _notes:get(i)
			if itr_note:get_track_index() == track_index then
				local did_release, note_result, time_to_end = itr_note:test_release()
				if did_release then
					itr_note:on_release(note_result,i,time_to_end)
					break
				end
			end
		end
	end

	self:cons()
	return self
end

return NoteTrackSystem
