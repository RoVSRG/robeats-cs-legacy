local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)
local Bindable = require(game.ReplicatedStorage.Libraries.Bindable)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

local Score = {}

function Score.new(props)
	assert(props ~= nil, "You must pass a props table")
	assert(props.songKey ~= nil, "You must pass a song key!")
	local self = {}
	self.hit_deviance = {}
	
	local chain = 0
	function self:getChain() return chain end
	
	local bonus = 100

	self.data = {
		marvelouses = 0;
		perfects = 0;
		greats = 0;
		goods = 0;
		bads = 0;
		misses = 0;
		maxChain = 0;
		score = 0;
		chain = 0;
		accuracy = 0;
	}

	local function getTotalCount()
		return self.data.marvelouses + self.data.perfects +  self.data.greats + self.data.goods + self.data.bads + self.data.misses
	end

	local maxscore = 1000000

	local hit_color = {
		[0] = Color3.fromRGB(255, 0, 0);
		[1] = Color3.fromRGB(190, 10, 240);
		[2] = Color3.fromRGB(56, 10, 240);
		[3] = Color3.fromRGB(7, 232, 74);
		[4] = Color3.fromRGB(252, 244, 5);
		[5] = Color3.fromRGB(255, 255, 255);
	}

	local song_length = SongDatabase:get_song_length_for_key(props.songKey)
	local note_count, hold_count = SongDatabase:get_note_metrics_for_key(props.songKey)

	function self:getAccuracy()
		local totalCount = getTotalCount()
		if totalCount == 0 then 
			return 0
		else
			return 100*( ( self.data.marvelouses + self.data.perfects + (self.data.greats*0.66) + (self.data.goods*0.33) + (self.data.bads*0.166) ) / totalCount)
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
		local spread = {self.data.marvelouses, self.data.perfects, self.data.greats, self.data.goods, self.data.bads}
		return self:calculateTotalScore(spread)
	end
	
	function self:getGlobalScore(marv,perf,great,good,bad)
		local spread = {marv,perf,great,good,bad}
		return self:calculateTotalScore(spread)
	end

	function self:addHitToDeviance(hit_time_ms, time_to_end, noteResult)
		local to_add = {
			x = (hit_time_ms-time_to_end)/song_length,
			y = NumberUtil.InverseLerp(-360, 360, time_to_end),
			result = noteResult;
			color = hit_color[noteResult];
		}

		self.hit_deviance[#self.hit_deviance+1] = to_add
	end

	function self:getHitDeviance() return self.hit_deviance end
	
	function self:calculateTotalScore(spread)
		local totalnotes = note_count + (hold_count*2) -- multiply the number of hold objects by 2 to get the total number of possible judgements lol
		local marv = 0
		for tota = 1, spread[1] do
			marv = marv + self:resultToPointTotal(5,totalnotes)
		end
		local perf = 0
		for tota = 1, spread[2] do
			perf = perf + self:resultToPointTotal(4,totalnotes)
		end
		local great = 0
		for tota = 1, spread[3] do
			great = great + self:resultToPointTotal(3,totalnotes)
		end
		local good = 0
		for tota = 1, spread[4] do
			good = good + self:resultToPointTotal(2,totalnotes)
		end
		local bad = 0
		for tota = 1, spread[5] do
			bad = bad + self:resultToPointTotal(1,totalnotes)
		end
		return marv + perf + great + good + bad
	end
	
	function self:calculateNoteScore(totalnotes,hitvalue,hitbonusvalue,hitbonus,hitpunishment)
		local prebonus = bonus + hitbonus - hitpunishment
		if prebonus>100 then
			bonus = 100
		elseif prebonus<0 then
			bonus = 0
		else
			bonus = prebonus
		end
		local basescore = (maxscore * 0.5 / totalnotes) * (hitvalue / 320)
		local bonusscore = (maxscore * 0.5 / totalnotes) * (hitbonusvalue * math.sqrt(bonus) / 320)
		local score = basescore + bonusscore
		return score
	end

	function self:resultToPointTotal(noteResult,totalnotes)
		local totalCount = getTotalCount()
		if noteResult == 5 then
			return self:calculateNoteScore(totalnotes,320,32,2,0)
		elseif noteResult == 4 then
			return self:calculateNoteScore(totalnotes,300,32,1,0)
		elseif noteResult == 3 then
			return self:calculateNoteScore(totalnotes,200,16,0,8)
		elseif noteResult == 2 then
			return self:calculateNoteScore(totalnotes,100,8,0,24)
		elseif noteResult == 1 then
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

	function self:registerHit(noteResult)
		local _add_to_devaince = true

		if noteResult == 5 then
			self.data.chain = self.data.chain + 1
			self.data.marvelouses = self.data.marvelouses + 1
		elseif noteResult == 4 then
			self.data.chain = self.data.chain + 1
			self.data.perfects = self.data.perfects + 1
		elseif noteResult == 3 then
			self.data.chain = self.data.chain + 1
			self.data.greats =  self.data.greats + 1
		elseif noteResult == 2 then
			--self.data.chain = self.data.chain + 1
			self.data.goods = self.data.goods + 1
		elseif noteResult == 1 then
			self.data.bads = self.data.bads + 1
		else
			self.data.chain = 0
			self.data.misses = self.data.misses + 1
		end
		
		local totalnotes = 500 --ok someoENee fix this lol
		self.data.score = self.data.score + self:resultToPointTotal(noteResult,totalnotes)
		self.data.accuracy = self:getAccuracy()
		self.data.maxChain = math.max(self.data.chain, self.data.maxChain)
		return self.data
	end

	return self
end

return Score
