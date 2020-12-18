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

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime

        self:checkNewNotes()
        self:cleanUpRemovingNotes()
        self:update()
    end

    function self:checkNewNotes()
        local w = 0
        for i = self.index, #self.hitData do
            w = w + 1
            local noteData = self.hitData[i]
            if self.currentAudioTime >= noteData.Time - self.scrollSpeed then
                print(string.format("%s %s %s %s",
                    tostring(noteData.Track == 1),
                    tostring(noteData.Track == 2),
                    tostring(noteData.Track == 3),
                    tostring(noteData.Track == 4)
                ))

                self:add({
                    pressTime = noteData.Time;
                    releaseTime = noteData.Type == 2 and noteData.Time + noteData.Duration;
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
            if hitObject:shouldRemove() then
                print("HA BONKED")
                self.pool:remove_at(i)
            end
        end
    end

    function self:updateNotes()
        for i = 1, self.pool:count() do
            self.pool:get(i):update(self.currentAudioTime)
        end
    end

    function self:add(props)
        self.pool:push_back(HitObject:new(props))
    end

    return self
end

return HitObjectPool
