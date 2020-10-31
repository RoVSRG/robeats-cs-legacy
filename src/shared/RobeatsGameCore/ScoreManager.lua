local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteResult = require(game.ReplicatedStorage.RobeatsGameCore.Enums.NoteResult)
local SFXManager = require(game.ReplicatedStorage.RobeatsGameCore.SFXManager)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local NoteResultPopupEffect = require(game.ReplicatedStorage.RobeatsGameCore.Effects.NoteResultPopupEffect)
local HoldingNoteEffect = require(game.ReplicatedStorage.RobeatsGameCore.Effects.HoldingNoteEffect)
local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)

local ScoreManager = {}

function ScoreManager:new(_game)
	local self = {}
	self.hit_deviance = {}
	
	local _chain = 0
	function self:get_chain() return _chain end
	
	self._bonus = 100
	self._score = 0
	self._chain = 0
	
	local _marv_count = 0
	local _perfect_count = 0
	local _great_count = 0
	local _good_count = 0
	local _bad_count = 0
	local _miss_count = 0
	local _max_chain = 0
	local _total_count = 0
	local maxscore = 1000000
	
	function self:get_end_records() return  _marv_count,_perfect_count,_great_count, _good_count, _bad_count,_miss_count,_max_chain, self._score end
	function self:get_accuracy()
		local _total_count = _marv_count + _perfect_count + _great_count + _good_count + _bad_count + _miss_count
		if _total_count == 0 then 
			return 0
		else
			return 100*( ( _marv_count + _perfect_count + (_great_count*0.66) + (_good_count*0.33) + (_bad_count*0.166) ) / _total_count)
		end
	end
	
	function self:get_global_accuracy(marv,perf,great,good,bad,miss)
		local _total_count = marv + perf + great + good + bad + miss
		if _total_count == 0 then 
			return 0
		else
			return 100*( ( marv + perf + (great*0.66) + (good*0.33) + (bad*0.166) ) / _total_count)
		end
	end
	
	function self:get_score()
		local spread = {_marv_count, _perfect_count, _great_count, _good_count, _bad_count}
		return self:calculate_total_score(spread)
	end
	
	function self:get_global_score(marv,perf,great,good,bad)
		local spread = {marv,perf,great,good,bad}
		return self:calculate_total_score(spread)
	end

	function self:add_hit_to_deviance(hit_time_ms, time_to_end, note_result)
		self.hit_deviance[#self.hit_deviance+1] = {hit_time_ms = hit_time_ms, time_to_end = time_to_end, note_result = note_result}
	end

	function self:get_hit_deviance() return self.hit_deviance end
	
	function self:calculate_total_score(spread)
		local totalnotes =_game._audio_manager:get_note_count()
		local marv = 0
		for total = 1, spread[1] do
			marv = marv + self:result_to_point_total(NoteResult.Marvelous,totalnotes)
		end
		local perf = 0
		for total = 1, spread[2] do
			perf = perf + self:result_to_point_total(NoteResult.Perfect,totalnotes)
		end
		local great = 0
		for total = 1, spread[3] do
			great = great + self:result_to_point_total(NoteResult.Great,totalnotes)
		end
		local good = 0
		for total = 1, spread[4] do
			good = good + self:result_to_point_total(NoteResult.Good,totalnotes)
		end
		local bad = 0
		for total = 1, spread[5] do
			bad = bad + self:result_to_point_total(NoteResult.Bad,totalnotes)
		end
		return marv + perf + great + good + bad
	end
	
	function self:calculate_note_score(totalnotes,hitvalue,hitbonusvalue,hitbonus,hitpunishment)
		local prebonus = self._bonus + hitbonus - hitpunishment
		if prebonus>100 then
			self._bonus = 100
		elseif prebonus<0 then
			self._bonus = 0
		else
			self._bonus = prebonus
		end
		local basescore = (maxscore * 0.5 / totalnotes) * (hitvalue / 320)
		local bonusscore = (maxscore * 0.5 / totalnotes) * (hitbonusvalue * math.sqrt(self._bonus) / 320)
		local score = basescore + bonusscore
		return score
	end

	function self:result_to_point_total(note_result,totalnotes)
		if note_result == NoteResult.Marvelous then
			return self:calculate_note_score(totalnotes,320,32,2,0)
		elseif note_result == NoteResult.Perfect then
			return self:calculate_note_score(totalnotes,300,32,1,0)
		elseif note_result == NoteResult.Great then
			return self:calculate_note_score(totalnotes,200,16,0,8)
		elseif note_result == NoteResult.Good then
			return self:calculate_note_score(totalnotes,100,8,0,24)
		elseif note_result == NoteResult.Bad then
			return self:calculate_note_score(totalnotes,50,4,0,44)
		else
			if _total_count > 0 then
				return self:calculate_note_score(totalnotes,0,0,0,100)
			else
				return 0
			end
		end
	end

	local _frame_has_played_sfx = false

	function self:register_hit(
		note_result,
		slot_index,
		track_index,
		params
	)
		local track = _game:get_tracksystem(slot_index):get_track(track_index)
		_game._effects:add_effect(NoteResultPopupEffect:new(
			_game,
			track:get_end_position() + Vector3.new(0,0.25,0),
			note_result
		))

		if params.PlaySFX == true then
			
			--Make sure only one sfx is played per frame
			if _frame_has_played_sfx == false then
				if note_result == NoteResult.Perfect or note_result == NoteResult.Marvelous then
					if params.IsHeldNoteBegin == true then
						_game._audio_manager:get_hit_sfx_group():play_first()
					else
						_game._audio_manager:get_hit_sfx_group():play_alternating()
					end

				elseif note_result == NoteResult.Great then
					_game._audio_manager.get_hit_sfx_group():play_first()
				elseif note_result == NoteResult.Good or note_result == NoteResult.Bad then
					_game._sfx_manager:play_sfx(SFXManager.SFX_DRUM_OKAY)
				else
					_game._sfx_manager:play_sfx(SFXManager.SFX_MISS)
				end
				_frame_has_played_sfx = true
			end
			
			--Create an effect at HoldEffectPosition if PlayHoldEffect is true
			if params.PlayHoldEffect then
				if note_result ~= NoteResult.Miss then
					_game._effects:add_effect(HoldingNoteEffect:new(
						_game,
						params.HoldEffectPosition,
						note_result
					))
				end
			end
		end
		
		local totalnotes =_game._audio_manager:get_note_count()

		local _add_to_devaince = true
		
		--Incregertment stats
		if note_result == NoteResult.Marvelous then
			_chain = _chain + 1
			_marv_count = _marv_count + 1
		elseif note_result == NoteResult.Perfect then
			_chain = _chain + 1
			_perfect_count = _perfect_count + 1
		elseif note_result == NoteResult.Great then
			_great_count = _great_count + 1
		elseif note_result == NoteResult.Good then
			_good_count = _good_count + 1
		elseif note_result == NoteResult.Bad then
			_chain = _chain + 1
			_bad_count = _bad_count + 1
		else
			if _chain > 0 then
				_chain = 0
				_miss_count = _miss_count + 1

			elseif params.TimeMiss == true then
				_miss_count = _miss_count + 1
			else
				_add_to_devaince = false
			end
		end

		if _add_to_devaince then
			self:add_hit_to_deviance(params.HitTime, params.TimeToEnd, note_result)
		end
		
		local totalnotes =_game._audio_manager:get_note_count()
		self._score = self._score + self:result_to_point_total(note_result,totalnotes)
		
		_max_chain = math.max(_chain,_max_chain)
	end

	function self:update(dt_scale)
		_frame_has_played_sfx = false
	end

	return self
end

return ScoreManager
