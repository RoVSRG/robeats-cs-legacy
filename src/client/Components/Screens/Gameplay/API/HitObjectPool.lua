local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)

local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local HitObject = require(script.Parent.HitObject)

local HitObjectPool = {}

function HitObjectPool:new(props)
    local self = {}
    self.hitData = SongDatabase:get_hit_objects_for_key(props.key, props.rate)
    self.index = 1
    self.currentAudioTime = -5000
    self.scrollSpeed = props.scrollSpeed
	self.scoreManager = props.scoreManager
    self.hitsound = props.hitsound
    self.hitObjects = SPList:new()
    self.replayIndex = 1

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime
        self.hitsound:update()
        self:checkNewNotes()
        self.trackSystem:update(self.currentAudioTime)
        self:handleReplay()
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

    function self:handleReplay()
        if props.replay == nil then return end

        local replay = props.replay
        for i = 1, 4 do
            local track = self.trackSystem:getTrack(i)
            local noteCandidate = track:getCandidate()
            local replayHit

            if noteCandidate then
                replayHit = replay:findHitWithId(noteCandidate.poolId)
            end
            
            if replayHit then
                if noteCandidate:currentPressJudgement().timeLeft >= replayHit.press.timeLeft then
                    track:pressAgainst()
                end

                if replayHit.release then
                    if noteCandidate:currentReleaseJudgement().timeLeft >= replayHit.release.timeLeft then
                        track:releaseAgainst()
                    end
                end
            end
        end
    end

    function self:add(props)
        self.hitObjects:push_back(HitObject:new(props))
    end

    function self:getCandidate(track)
        local hitObjects = Llama.List.copy(self.hitObjects._table)

        table.sort(hitObjects, function(a, b)
            return a.pressTime < b.pressTime
        end)

        for _, hitObject in ipairs(hitObjects) do
            if hitObject.track == track then
                return hitObject
            end
        end
    end

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime

        self:cleanUpRemovingNotes()
        self:updateNotes()
    end

    function self:cleanUpRemovingNotes()
        for i = 1, self.hitObjects:count() do
            local hitObject = self.hitObjects:get(i)
            if hitObject and hitObject:shouldRemove() then
                local judgement = hitObject:currentPressJudgement().judgement
                self.scoreManager:registerHit(judgement)
                self.hitObjects:remove_at(i)
            end
        end
    end

    function self:updateNotes()
        for i = 1, self.hitObjects:count() do
            self.hitObjects:get(i):update(self.currentAudioTime)
        end
    end

    function self:getSerialized()
        local ret  = {}
        
        for i = 1, self.hitObjects:count() do
            local hitObject = self.hitObjects:get(i)
            ret[#ret+1] = {
                type = hitObject.type;
                pressAlpha = hitObject.pressTimeAlpha;
                releaseAlpha = hitObject.releaseTimeAlpha;
                lane = hitObject.lane;
                headPressed = hitObject.headPressed;
                releasedEarly = hitObject.releasedEarly;
                poolId = hitObject.poolId;
            }
        end

        return ret
    end

    function self:pressAgainstSingleNote(candidate)
        assert(candidate ~= nil, "You must pass a NoteCandidate!")
        local judgement = candidate:currentPressJudgement().judgement
        if judgement ~= 0 then
            self.scoreManager:registerHit(judgement)
            self.hitObjects:remove_at(1)
            self.hitsound:playHitsound(1)
        end
    end
    
    function self:pressAgainstHoldNote(candidate)
        assert(candidate ~= nil, "You must pass a NoteCandidate!")
        local judgement = candidate:currentPressJudgement().judgement
        if not candidate.headPressed then
            if judgement ~= 0 then
                candidate.headPressed = true
                self.scoreManager:registerHit(judgement)
                self.hitsound:playHitsound(1)
            end
        else
            --if release and next hit object is a note then lol
            local nextObject = self.hitObjects:get(2)
            if nextObject then
                local nextObjectJudgement = nextObject:currentPressJudgement().judgement
                if nextObjectJudgement ~= 0 then
                    self.hitObjects:remove_at(1)
                    self.scoreManager:registerHit(0)
                    if nextObject.type == 1 then
                        self.hitObjects:remove_at(1)
                    else
                        nextObject.headPressed = true
                    end
                    self.scoreManager:registerHit(nextObjectJudgement)
                    self.hitsound:playHitsound(1)
                end
            end
        end
    end

    function self:releaseAgainstHoldNote(candidate)
        assert(candidate ~= nil, "You must pass a NoteCandidate!")
        local judgement = candidate:currentReleaseJudgement().judgement
        if judgement ~= 0 then
            self.scoreManager:registerHit(judgement)
            self.hitObjects:remove_at(1)
            self.hitsound:playHitsound(1)
        else
            if (not candidate.releasedEarly) and candidate.headPressed then
                candidate.releasedEarly = true
                self.scoreManager:registerHit(judgement)
            end
        end
    end

    function self:pressAgainst()
        local candidate = self:getCandidate()
        if candidate then
            if candidate.type == 1 then
                self:pressAgainstSingleNote(candidate)
            elseif candidate.type == 2 then
                self:pressAgainstHoldNote(candidate)
            end
        end 
    end

    function self:releaseAgainst()
        local candidate = self:getCandidate()
        if candidate then
            if candidate.type == 2 then
                self:releaseAgainstHoldNote(candidate)
            end
        end
    end

    return self
end

return HitObjectPool
