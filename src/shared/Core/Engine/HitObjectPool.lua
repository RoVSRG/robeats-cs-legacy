local Promise = require(game.ReplicatedStorage.Libraries.Promise)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local Hitsound = require(script.Parent.Hitsound)

local TrackSystem = require(script.Parent.TrackSystem)

local HitObjectPool = {}

function HitObjectPool:new(props)
    local self = {}
    self.pool = SPList:new()
    self.hitData = SongDatabase:get_hit_objects_for_key(props.key, props.rate)
    self.index = 1
    self.currentAudioTime = -5000
    self.scrollSpeed = props.scrollSpeed
	self.scoreManager = props.scoreManager
    self.hitsound = props.hitsound
    self.trackSystem = TrackSystem:new({
        scoreManager = self.scoreManager;
        hitsound = self.hitsound;
    })

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime
        self.hitsound:update()
        self:checkNewNotes()
        self.trackSystem:update(self.currentAudioTime)
    end

    function self:checkNewNotes()
        for i = self.index, #self.hitData do
            local noteData = self.hitData[i]
            if self.currentAudioTime >= noteData.Time - self.scrollSpeed then
                self:add({
                    pressTime = noteData.Time;
					releaseTime = noteData.Type == 2 and (noteData.Time) + noteData.Duration;
                    lane = noteData.Track;
                    scrollSpeed = self.scrollSpeed;
                    poolId = i;
                })
                self.index = self.index + 1
                else break
            end
        end
    end

    function self:add(props)
        self.trackSystem:getTrack(props.lane):add(props)
    end

    return self
end

return HitObjectPool
