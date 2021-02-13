local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)
local Bindable = require(game.ReplicatedStorage.Libraries.Bindable)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Score = {}

function Score.new()
	local self = {}
	self.hit_deviance = {}
	
	local chain = 0
	function self:getChain() return chain end
	
	self.bonus = 100
	self.score = 0
	self.chain = 0

	self.mostRecentJudgement = 0
	
	local marvCount = 0
	local perfectCount = 0
	local greatCount = 0
	local goodCount = 0
	local badCount = 0
	local missCount = 0
	local maxChain = 0
	local totalCount = 0
	local maxscore = 1000000

	local hit_color = {
		[0] = Color3.fromRGB(255, 0, 0);
		[1] = Color3.fromRGB(190, 10, 240);
		[2] = Color3.fromRGB(56, 10, 240);
		[3] = Color3.fromRGB(7, 232, 74);
		[4] = Color3.fromRGB(252, 244, 5);
		[5] = Color3.fromRGB(255, 255, 255);
	}

	function self:getEndRecords() return  marvCount, perfectCount, greatCount, goodCount, badCount, missCount, maxChain, self.score end
	function self:getAccuracy()
		local totalCount = marvCount + perfectCount +  greatCount + goodCount + badCount + missCount
		if totalCount == 0 then 
			return 0
		else
			return 100*( ( marvCount + perfectCount + (greatCount*0.66) + (goodCount*0.33) + (badCount*0.166) ) / totalCount)
		end
	end
	
	function self:getGlobalAccuracy(marv,perf,great,good,bad,miss)
		local totalCount = marv + perf + great + good + bad + miss
		if totalCount == 0 then 
			return 0
		else
			return 100*( ( marv + perf + (great*0.66) + (good*0.33) + (bad*0.166) ) / totalCount)
		end
	end
	
	function self:getScore()
		local spread = {marvCount, perfectCount, greatCount, goodCount, badCount}
		return self:calculateTotalScore(spread)
	end
	
	function self:getGlobalScore(marv,perf,great,good,bad)
		local spread = {marv,perf,great,good,bad}
		return self:calculateTotalScore(spread)
	end

	function self:addHitToDeviance(hit_time_ms, time_to_end, note_result)
		local song_length = _game._audio_manager:get_song_length_ms()
		local to_add = {
			x = (hit_time_ms-time_to_end)/song_length,
			y = NumberUtil.InverseLerp(-360, 360, time_to_end),
			result = note_result;
			color = hit_color[note_result];
		}

		self.hit_deviance[#self.hit_deviance+1] = to_add
	end

	function self:getHitDeviance() return self.hit_deviance end
	
	function self:calculateTotalScore(spread)
		local totalnotes = 1 --TODO: FIX
		local marv = 0
		for total = 1, spread[1] do
			marv = marv + self:resultToPointTotal(5,totalnotes)
		end
		local perf = 0
		for total = 1, spread[2] do
			perf = perf + self:resultToPointTotal(4,totalnotes)
		end
		local great = 0
		for total = 1, spread[3] do
			great = great + self:resultToPointTotal(3,totalnotes)
		end
		local good = 0
		for total = 1, spread[4] do
			good = good + self:resultToPointTotal(2,totalnotes)
		end
		local bad = 0
		for total = 1, spread[5] do
			bad = bad + self:resultToPointTotal(1,totalnotes)
		end
		return marv + perf + great + good + bad
	end
	
	function self:calculateNoteScore(totalnotes,hitvalue,hitbonusvalue,hitbonus,hitpunishment)
		local prebonus = self.bonus + hitbonus - hitpunishment
		if prebonus>100 then
			self.bonus = 100
		elseif prebonus<0 then
			self.bonus = 0
		else
			self.bonus = prebonus
		end
		local basescore = (maxscore * 0.5 / totalnotes) * (hitvalue / 320)
		local bonusscore = (maxscore * 0.5 / totalnotes) * (hitbonusvalue * math.sqrt(self.bonus) / 320)
		local score = basescore + bonusscore
		return score
	end

	function self:resultToPointTotal(note_result,totalnotes)
		if note_result == 5 then
			return self:calculateNoteScore(totalnotes,320,32,2,0)
		elseif note_result == 4 then
			return self:calculateNoteScore(totalnotes,300,32,1,0)
		elseif note_result == 3 then
			return self:calculateNoteScore(totalnotes,200,16,0,8)
		elseif note_result == 2 then
			return self:calculateNoteScore(totalnotes,100,8,0,24)
		elseif note_result == 1 then
			return self:calculateNoteScore(totalnotes,50,4,0,44)
		else
			if totalCount > 0 then
				return self:calculateNoteScore(totalnotes,0,0,0,100)
			else
				return 0
			end
		end
	end

	local _frame_has_played_sfx = false

	function self:registerHit(note_result)
		SPUtil:spawn(function()
			local _add_to_devaince = true
			
			--Incregertment stats
			if note_result == 5 then
				chain = chain + 1
				marvCount = marvCount + 1
			elseif note_result == 4 then
				chain = chain + 1
				perfectCount = perfectCount + 1
			elseif note_result == 3 then
				chain = chain + 1
				greatCount =  greatCount + 1
			elseif note_result == 2 then
				chain = chain + 1
				goodCount = goodCount + 1
			elseif note_result == 1 then
				badCount = badCount + 1
			else
				chain = 0
				missCount = missCount + 1
			end

			-- if _add_to_devaince then
			-- 	self:addHitToDeviance(params.HitTime, params.TimeToEnd, note_result)
			-- end
			
			local totalnotes = 500
			self.score = self.score + self:resultToPointTotal(note_result,totalnotes)
			
			maxChain = math.max(chain,maxChain)

			self.mostRecentJudgement = note_result
			self.stats:change(self:getStatTable())
		end)
	end

	function self:getStatTable()
		local marv_count, perf_count, great_count, good_count, bad_count, miss_count, max_combo, score = self:getEndRecords()
		local combo = self:getChain()
		local accuracy = self:getAccuracy()

		return {
			score = score;
			marvelouses = marv_count;
			perfects = perf_count;
			greats = great_count;
			goods = good_count;
			bads = bad_count;
			misses = miss_count;
			combo = combo;
			accuracy = accuracy;
			max_combo = max_combo;
			most_recent = self.mostRecentJudgement;
		}
	end

	function self:update(dt_scale)
		_frame_has_played_sfx = false
	end

	self.stats = Bindable:new(self:getStatTable())

	return self
end

return Score
