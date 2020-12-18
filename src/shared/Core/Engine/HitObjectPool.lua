local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)
local HitObject = require(script.Parent.HitObject)

local HitObjectPool = {}

function HitObjectPool:new(props)
    local self = {}
    self.pool = SPList:new()
    self.hitData = SongDatabase:get_hit_objects_for_key(props.key)
    self.index = 1
    self.currentAudioTime = 0
    self.scrollSpeed = props.scrollSpeed

    function HitObjectPool:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime

        self:checkNewNotes()
        self:cleanUpRemovingNotes()
    end

    function HitObjectPool:checkNewNotes()
        for i = self.index, #self.hitData do
            local noteData = self.hitData[i]
            if self.currentAudioTime >= noteData.Time - self.scrollSpeed then
                self:add({
                    pressTime = noteData.Time;
                    releaseTime = noteData.Type == 2 and noteData.Time + noteData.Duration;
                    lane = noteData.Track;
                    scrollSpeed = self.scrollSpeed;
                })
                self.scrollSpeed = self.scrollSpeed + 1
                else break
            end
        end
    end

    function self:cleanUpRemovingNotes()
        for i = 1, self.pool:count() do
            local hitObject = self.pool:get(i)

            if hitObject:doRemove() then
                self.pool:remove_at(i)
            end
        end
    end

    function HitObjectPool:add(props)
        self.pool:push_back(HitObject:new(props))
    end

    return self
end

return HitObjectPool
