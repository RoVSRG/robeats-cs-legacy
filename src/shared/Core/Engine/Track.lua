local SPList = require(game.ReplicatedStorage.Shared.Utils.SPList)

local Track = {}

function Track:new(props)
    local self = {}

    self.hitObjects = SPList:new()
    self.scoreManager = props.scoreManager
    self.currentAudioTime = 0

    function self:add(hitOb)
        self.hitObjects:push_back(hitOb)
    end

    function self:getCandidate()
        return self.hitObjects:get(1)
    end

    function self:removeFront(index)
        self.hitObjects:pop_front()
    end

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime


    end

    function self:cleanUpRemovingNotes()
        for i = 1, self.pool:count() do
            local hitObject = self.hitObjects:get(i)
            if hitObject and hitObject:shouldRemove() then
                self.scoreManager:registerHit(hitObject:currentPressJudgement())
                self.hitObjects:remove_at(i)
            end
        end
    end

    function self:updateNotes()
        for i = 1, self.pool:count() do
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
            }
        end

        return ret
    end

    return self
end

return Track
