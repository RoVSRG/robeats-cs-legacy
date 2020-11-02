local DataStoreService = require(game.ReplicatedStorage.Libraries.MockDataStoreService)

local _db_version = "v2.3"

local ScoreDatabase = DataStoreService:GetDataStore("ScoreDatabase".._db_version)
local NoteDevainceDatabase = DataStoreService:GetDataStore("NoteDevainceDatabase".._db_version)

local DebugOut = require(game.ReplicatedStorage.Shared.DebugOut)

local Metrics = require(game.ReplicatedStorage.Libraries.Data.Metrics)

--TODO: REPLACE KISPERAL'S NETWORKING MODULE WITH "sl0th"'s

local HttpService = game:GetService("HttpService")
local Network = require(game.ReplicatedStorage.Network)
local AssertType = require(game.ReplicatedStorage.Shared.AssertType)
local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)
local CustomServerSettings = require(game.Workspace.CustomServerSettings)

local function getLeaderboardKey(mapid)
	return string.format("leaderboard_songkey(%s)", tostring(mapid))
end

local function getDevianceKey(userid, mapid)
	print(string.format("deviance_userid_songkey(%s,%s)", tostring(userid), tostring(mapid)))
	return string.format("deviance_userid_songkey(%s,%s)", tostring(userid), tostring(mapid))
end

Network.AddEvent("SubmitScore"):Connect(function(player, sent_data)
	AssertType:is_true(SongDatabase:contains_key(sent_data.mapid))
	AssertType:is_number(sent_data.accuracy)
	AssertType:is_int(sent_data.maxcombo)
	AssertType:is_int(sent_data.marvelouses)
	AssertType:is_int(sent_data.perfects)
	AssertType:is_int(sent_data.greats)
	AssertType:is_int(sent_data.goods)
	AssertType:is_int(sent_data.bads)
	AssertType:is_int(sent_data.misses)
	AssertType:is_number(sent_data.score)
	AssertType:is_int(sent_data.rate)
	AssertType:is_number(sent_data.mean)

	sent_data.hitdeviance = sent_data.hitdeviance or {}
	
	local player_id = player.UserId

	sent_data.userid = player_id
	sent_data.playername = player.Name
	sent_data.time = os.time()
	sent_data.rating = Metrics.calculate_rating(sent_data.rate/100, sent_data.accuracy, SongDatabase:get_difficulty_for_key(sent_data.mapid))
	
	local name = getLeaderboardKey(sent_data.mapid)
	local save_hitdeviance = false
	local suc, err = pcall(function()
		ScoreDatabase:UpdateAsync(name, function(leaderboard)
			leaderboard = leaderboard or {}
			local _score

			for i = 1, #leaderboard do
				local itr_slot = leaderboard[i]
				if itr_slot.userid == player_id then
					_score = itr_slot
				end
			end

			save_hitdeviance = false

			if _score then
				if _score.rating < sent_data.rating then
					save_hitdeviance = true
					for i, _ in pairs(_score) do
						_score[i] = sent_data[i]
					end
				end
			else
				save_hitdeviance = true
				leaderboard[#leaderboard+1] = sent_data
			end

			return leaderboard
		end)
	end)

	if not suc then
		warn(err)
	end

	local suc, err = pcall(function()
		if save_hitdeviance then
			local key = getDevianceKey(player_id, sent_data.mapid)
			NoteDevainceDatabase:SetAsync(key, sent_data.hitdeviance)
		end
	end)

	if not suc then
		warn(err)
	end
end)

Network.AddFunction("GetLeaderboard"):Set(function(player, request)
	AssertType:is_true(SongDatabase:contains_key(request.mapid))
	
	local name = getLeaderboardKey(request.mapid)

	local lb = {}
	local suc, err = pcall(function()
		lb = ScoreDatabase:GetAsync(name)
	end)

	if not suc then
		warn(err)
	end

	return lb
end)

Network.AddFunction("GetDeviance"):Set(function(player, request)
	AssertType:is_true(SongDatabase:contains_key(request.mapid))
	AssertType:is_int(request.userid)

	return NoteDevainceDatabase:GetAsync(getDevianceKey(request.userid, request.mapid))
end)
