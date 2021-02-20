local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local SPDict = require(game.ReplicatedStorage.Shared.Utils.SPDict)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local SongErrorParser = require(game.ReplicatedStorage.Shared.Core.API.Map.SongErrorParser)
local MD5 = require(game.ReplicatedStorage.Libraries.MD5)
local Promise = require(game.ReplicatedStorage.Libraries.Promise)

local SongMapList = workspace.SongMaps:GetChildren()

local SongDatabase = {}

SongDatabase.SongMode = {
	Normal = 0;
	SupporterOnly = 1;
}

function SongDatabase:new()
	local self = {}
	self.SongMode = SongDatabase.SongMode

	local function requireKey(i)
		return require(SongMapList[i])
	end

	function self:get_data_for_key(key)
		return requireKey(key)
	end

	function self:contains_key(key)
		return SongMapList[key] ~= nil
	end

	function self:key_get_audiomod(key)
		local data = self:get_data_for_key(key)
		if data.AudioMod == 1 then
			return SongDatabase.SongMode.SupporterOnly
		end
		return SongDatabase.SongMode.Normal
	end

	function self:render_coverimage_for_key(cover_image, overlay_image, key)
		local songdata = self:get_data_for_key(key)
		cover_image.Image = songdata.AudioCoverImageAssetId

		local audiomod = self:key_get_audiomod(key)
		if audiomod == SongDatabase.SongMode.SupporterOnly then
			overlay_image.Image = "rbxassetid://837274453"
			overlay_image.Visible = true
		else
			overlay_image.Visible = false
		end
	end

	function self:get_chart_hash_for_key(key)
		return Promise.new(function(resolve, reject)
			local songdata = self:get_data_for_key(key)
			local s = ""

			for _, hitOb in pairs(songdata.HitObjects) do
				s ..= string.format("%s%s", hitOb.Time, hitOb.Track)
			end

			resolve(MD5.tohex(MD5.sum(MD5.tohex(s))))
		end)
	end

	function self:render_bannerimage_for_key(banner_image, key)
		local data = self:get_data_for_key(key)
		banner_image.Image = data.AudioCoverImageAssetId
	end

	function self:get_title_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioFilename
	end

	function self:get_artist_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioArtist
	end

	function self:get_difficulty_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioDifficulty
	end
	
	function self:get_description_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioDescription
	end
	
	function self:get_image_for_key(key)
		local songdata = self:get_data_for_key(key)
		return songdata.AudioCoverImageAssetId
	end
	
	function self:get_hit_objects_for_key(key, rate)
		local songdata = self:get_data_for_key(key)
		if rate == nil then
			return songdata.HitObjects
		end

		local hitObjects = {}

		for i, v in ipairs(songdata.HitObjects) do
			hitObjects[i] = {
				Time = v.Time / rate;
				Track = v.Track;
				Duration = v.Duration and v.Duration / rate;
				Type = v.Duration and 2 or 1;
			}
		end
		
		return hitObjects
	end

	function self:get_song_length_for_key(key)
		local data = self:get_data_for_key(key)
		local hit_ob = data.HitObjects
		
		local len = 0

		for _, hit_object in pairs(hit_ob) do
			len = math.max(hit_object.Time + (hit_object.Duration or 0), len)
		end
		
		return len
	end

	function self:get_nps_graph_for_key(key, resolution)
		local nps_graph = {}
		local data = self:get_data_for_key(key)

		local last_time = 0
		local cur_nps = 0

		for i, hit_object in pairs(data.HitObjects) do
			if hit_object.Time - last_time > 1000 then
				if (resolution and i % resolution == 0) or (not resolution) then
					nps_graph[#nps_graph+1] = cur_nps
				end
				last_time = hit_object.Time
				cur_nps = 0
			end
			cur_nps += 1
		end

		return nps_graph
	end

	function self:get_note_metrics_for_key(key)
		local data = self:get_data_for_key(key)
		local total_notes = 0
		local total_holds = 0

		for _, hit_object in pairs(data.HitObjects) do
			if hit_object.Type == 1 then
				total_notes += 1
			elseif hit_object.Type == 2 then
				total_holds += 1
			end
		end

		return total_notes, total_holds
	end

	function self:get_searchable_string_for_key(key)
		local data = self:get_data_for_key(key)
		return string.format("%s %s %s %s artist=%s name=%s difficulty=%s",
			data.AudioArtist,
			data.AudioFilename,
			data.AudioDifficulty,
			data.AudioDescription,
			data.AudioArtist,
			data.AudioFilename,
			data.AudioDifficulty
		)
	end

	function self:search(search)
		assert(search ~= nil, "Search must not be nil")
		return Promise.new(function(resolve)
			local foundKeys = {}
			for i = 1, self:number_of_keys() do
				local searchableString = self:get_searchable_string_for_key(i)
				local splSearch = string.split(search, " ")

				local found = 0
				for itr = 1, #splSearch do
					local search_term = splSearch[itr]
					if string.find(searchableString:lower(), search_term:lower()) ~= nil then
						found = found + 1
					end
				end

				if found == #search then
					table.insert(foundKeys, i)
				end
			end
			resolve(foundKeys)
		end)
	end

	function self:lol()
		return Promise.new(function(resolve)
			wait(2)
			resolve("XD")
		end)
	end
	
	function self:number_of_keys() return #SongMapList end
	function self:invalid_songkey() return -1 end

	return self
end

return SongDatabase:new()