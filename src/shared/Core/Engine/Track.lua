local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local HitObject = require(script.Parent.HitObject)

local Track = {}

function Track:new(props)
    local self = {}

    self.hitObjects = SPList:new()
    self.scoreManager = props.scoreManager
    self.hitsound = props.hitsound
    self.currentAudioTime = 0

    function self:add(props)
        self.hitObjects:push_back(HitObject:new(props))
    end

    function self:getCandidate()
        return self.hitObjects:get(1)
    end

    function self:removeFront(index)
        self.hitObjects:pop_front()
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
                self.scoreManager:registerHit(hitObject:currentPressJudgement())
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

    function self:pressAgainst()
        local candidate = self:getCandidate()
        if candidate then
            if candidate.type == 1 then
                local judgement = candidate:currentPressJudgement().judgement
                if judgement ~= 0 then
                    self.scoreManager:registerHit(judgement)
                    self.hitObjects:remove_at(1)
                    self.hitsound:playHitsound(1)
                end
            elseif candidate.type == 2 then
                local judgement = candidate:currentPressJudgement().judgement
                if not candidate.headPressed then
                    if judgement ~= 0 then
                        candidate.headPressed = true
                        self.scoreManager:registerHit(judgement)
                        self.hitsound:playHitsound(1)
                    end
                else
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
        end 
    end

    function self:releaseAgainst()
        local candidate = self:getCandidate()
        if candidate then
            if candidate.type == 2 then
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
        end
    end

    return self
end

return Track
