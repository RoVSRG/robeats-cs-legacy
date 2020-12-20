local Promise = require(game.ReplicatedStorage.Libraries.Promise)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local HitObject = require(script.Parent.HitObject)
local Hitsound = require(script.Parent.Hitsound)

local TrackSystem = require(script.Parent.TrackSystem)

local HitObjectPool = {}

function HitObjectPool:new(props)
    local self = {}
    self.pool = SPList:new()
    self.hitData = SongDatabase:get_hit_objects_for_key(props.key)
    self.index = 1
    self.currentAudioTime = 0
    self.scrollSpeed = props.scrollSpeed
	self.scoreManager = props.scoreManager
    self.hitsound = Hitsound:new(props)
    self.trackSystem = TrackSystem:new()

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime
        self.hitsound:update()
        self:checkNewNotes()
        self.trackSystem:update()
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

    function self:getCandidate(lane)
        return Promise.new(function(resolve, reject)
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

            resolve(candidate, candidates)
        end)
    end

    function self:pressAgainst(lane)
        self:getCandidate(lane):andThen(function(candidate, candidates)
            if candidate then
                if candidate.hitObject.type == 1 then
                    local judgement = candidate.hitObject:currentPressJudgement().judgement
                    if judgement ~= 0 then
                        self.scoreManager:registerHit(judgement)
                        self.pool:remove_at(candidate.indexInPool)
                        self.hitsound:playHitsound(1)
                    end
                elseif candidate.hitObject.type == 2 then
                    local hitObject = candidate.hitObject
                    local judgement = hitObject:currentPressJudgement().judgement
                    if not hitObject.headPressed then
                        if judgement ~= 0 then
                            hitObject.headPressed = true
                            self.scoreManager:registerHit(judgement)
                            self.hitsound:playHitsound(1)
                        end
                    else
                        local nextObject = candidates[2]
                        if nextObject then
                            local nextObjectJudgement = nextObject.hitObject:currentPressJudgement().judgement
                            if nextObjectJudgement ~= 0 then
                                self.pool:remove_at(candidate.indexInPool)
                                self.scoreManager:registerHit(0)
                                if nextObject.hitObject.type == 1 then
                                    print("Note on lane " .. nextObject.hitObject.lane .. "removing")
                                    self.pool:remove_at(nextObject.indexInPool)
                                else
                                    nextObject.hitObject.headPressed = true
                                end
                                self.scoreManager:registerHit(nextObjectJudgement)
                                self.hitsound:playHitsound(1)
                            end
                        end
                    end
                end
            end
        end)        
    end

    function self:releaseAgainst(lane)
        self:getCandidate(lane):andThen(function(candidate)
            if candidate then
                if candidate.hitObject.type == 2 then
                    local hitObject = candidate.hitObject
                    local judgement = hitObject:currentReleaseJudgement().judgement
                    if judgement ~= 0 then
                        self.scoreManager:registerHit(judgement)
                        self.pool:remove_at(candidate.indexInPool)
                        self.hitsound:playHitsound(0.5)
                    else
                        if (not hitObject.releasedEarly) and hitObject.headPressed then
                            hitObject.releasedEarly = true
                            self.scoreManager:registerHit(judgement)
                        end
                    end
                end
            end
        end) 
    end

    function self:add(props)
        self.pool:push_back(HitObject:new(props))
    end

    return self
end

return HitObjectPool
