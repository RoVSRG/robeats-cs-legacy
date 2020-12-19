local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local HitObject = require(script.Parent.HitObject)
local Hitsound = require(script.Parent.Hitsound)

local NoteConsole = require(script.Parent.NoteConsole)

local HitObjectPool = {}

function HitObjectPool:new(props)
    local self = {}
    self.pool = SPList:new()
    self.hitData = SongDatabase:get_hit_objects_for_key(props.key)
    self.index = 1
    self.currentAudioTime = 0
    self.scrollSpeed = props.scrollSpeed
	self.scoreManager = props.scoreManager
	self.Hitsound = Hitsound:new(props)

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime
        self:checkNewNotes()
        self:cleanUpRemovingNotes()
        self:updateNotes()
    end

    function self:checkNewNotes()
        for i = self.index, #self.hitData do
            local noteData = self.hitData[i]
            if self.currentAudioTime >= noteData.Time - self.scrollSpeed then
                self:add({
                    pressTime = noteData.Time + 1000;
					releaseTime = noteData.Type == 2 and (noteData.Time + 1000) + noteData.Duration;
                    lane = noteData.Track;
                    scrollSpeed = self.scrollSpeed;
                })
                self.index = self.index + 1
                else break
            end
        end
    end

    function self:cleanUpRemovingNotes()
        for i = 1, self.pool:count() do
            local hitObject = self.pool:get(i)
            if hitObject and hitObject:shouldRemove() then
                self.scoreManager:registerHit(hitObject:currentPressJudgement())
                self.pool:remove_at(i)
            end
        end
    end

    function self:updateNotes()
        for i = 1, self.pool:count() do
            self.pool:get(i):update(self.currentAudioTime)
        end
    end

    function self:getCandidate(lane)
        local candidates = {}

        for i = 1, self.pool:count() do
            local hitObject = self.pool:get(i)
            if hitObject.lane == lane then
                candidates[#candidates+1] = {
                    hitObject = hitObject;
                    indexInPool = i;
                }
            end
        end

        table.sort(candidates, function(candidateA, candidateB)
            return candidateA.hitObject.pressTime < candidateB.hitObject.pressTime
        end)

        local candidate = candidates[1]

        return candidate
    end

    function self:pressAgainst(lane)
        local candidate = self:getCandidate(lane)

        if candidate then
            if candidate.hitObject.type == 1 then
                local judgement = candidate.hitObject:currentPressJudgement().judgement
                if judgement ~= 0 then
                    self.scoreManager:registerHit(judgement)
					self.pool:remove_at(candidate.indexInPool)
					self.Hitsound:PlayHitsound(1)
                end
            elseif candidate.hitObject.type == 2 then
                local hitObject = candidate.hitObject
                local judgement = hitObject:currentPressJudgement().judgement
                if judgement ~= 0 and not hitObject.headPressed then
                    hitObject.headPressed = true
					self.scoreManager:registerHit(judgement)
					self.Hitsound:PlayHitsound(1)
                end
            end
        end
    end

    function self:releaseAgainst(lane)
        local candidate = self:getCandidate(lane)

        if candidate then
            if candidate.hitObject.type == 2 then
                local hitObject = candidate.hitObject
                local judgement = hitObject:currentReleaseJudgement().judgement
                if judgement ~= 0 then
                    self.scoreManager:registerHit(judgement)
					self.pool:remove_at(candidate.indexInPool)
					self.Hitsound:PlayHitsound(0.5)
                end
            end
        end
    end

    function self:add(props)
        self.pool:push_back(HitObject:new(props))
    end

    return self
end

return HitObjectPool
