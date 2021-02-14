local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)

local Llama = require(game.ReplicatedStorage.Libraries.Llama)

local HitObject = require(script.Parent.HitObject)
local ScrollSpeed = require(script.Parent.ScrollSpeed)

local function noop() warn("onNoteJudged not implemented!") end

local NotePool = {}

function NotePool.new(props)
    props = {
        scrollSpeed = props.scrollSpeed or 0;
        onNoteJudged = props.onNoteJudged or noop;
        songKey = props.songKey;
        rate = props.rate;
    }

    assert(props.songKey ~= nil, "Must pass a song key!")

    local self = {}

    self.hitData = SongDatabase:get_hit_objects_for_key(props.songKey, props.rate)
    self.index = 1
    self.currentAudioTime = -5000
    self.scrollSpeed = ScrollSpeed(props.scrollSpeed)
    self.hitObjects = SPList:new()

    function self:removeNoteWithId(id)
        for i = 1, self.hitObjects:count() do
            if self.hitObjects:get(i).poolId == id then
                self.hitObjects:remove_at(i)
                return
            end
        end
    end

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime

        self:cleanUpRemovingNotes()
        self:checkNewNotes()
        self:updateNotes()
        --self:handleReplay()
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

    function self:getCandidate(lane)
        local hitObjects = Llama.List.copy(self.hitObjects._table)

        local hitObjectsLane = {}
        
        for _, hitObject in ipairs(hitObjects) do
            if hitObject.lane == lane then
                table.insert(hitObjectsLane, #hitObjectsLane+1, hitObject)
            end
        end

        table.sort(hitObjectsLane, function(a, b)
            return a.pressTime < b.pressTime
        end)

        return hitObjectsLane[1]
    end

    function self:cleanUpRemovingNotes()
        for i = 1, self.hitObjects:count() do
            local hitObject = self.hitObjects:get(i)
            if hitObject and hitObject:shouldRemove() then
                local judgement = hitObject:currentPressJudgement().judgement
                props.onNoteJudged(judgement)
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
            props.onNoteJudged(judgement)
            self:removeNoteWithId(candidate.poolId)
        end
    end
    
    function self:pressAgainstHoldNote(candidate)
        assert(candidate ~= nil, "You must pass a NoteCandidate!")
        local judgement = candidate:currentPressJudgement().judgement
        if not candidate.headPressed then
            if judgement ~= 0 then
                candidate.headPressed = true
                props.onNoteJudged(judgement)
            end
        else
            --if release and next hit object is a note then lol
            local nextObject = self.hitObjects:get(2)
            if nextObject then
                local nextObjectJudgement = nextObject:currentPressJudgement().judgement
                if nextObjectJudgement ~= 0 then
                    self:removeNoteWithId(candidate.poolId)
                    props.onNoteJudged(0)
                    if nextObject.type == 1 then
                        self:removeNoteWithId(candidate.poolId)
                    else
                        nextObject.headPressed = true
                    end
                    props.onNoteJudged(nextObjectJudgement)
                end
            end
        end
    end

    function self:releaseAgainstHoldNote(candidate)
        assert(candidate ~= nil, "You must pass a NoteCandidate!")
        local judgement = candidate:currentReleaseJudgement().judgement
        if judgement ~= 0 then
            props.onNoteJudged(judgement)
            self:removeNoteWithId(candidate.poolId)
        else
            if (not candidate.releasedEarly) and candidate.headPressed then
                candidate.releasedEarly = true
                props.onNoteJudged(judgement)
            end
        end
    end

    function self:pressAgainst(lane)
        local candidate = self:getCandidate(lane)
        if candidate then
            if candidate.type == 1 then
                print(candidate.lane, "<< lol")
                self:pressAgainstSingleNote(candidate)
            elseif candidate.type == 2 then
                self:pressAgainstHoldNote(candidate)
            end
        end 
    end

    function self:releaseAgainst(lane)
        local candidate = self:getCandidate(lane)
        if candidate then
            if candidate.type == 2 then
                self:releaseAgainstHoldNote(candidate)
            end
        end
    end

    return self
end

return NotePool
