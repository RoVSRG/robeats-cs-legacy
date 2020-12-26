local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local ScoreManager = require(script.ScoreManager)
local HitObjectPool = require(script.HitObjectPool)
local Hitsound = require(script.Hitsound)
local Audio = require(script.Audio)

local Engine = {
    States = {
        Idle = 0;
        Loading = 1;
        Playing = 2;
        Cleanup = 3;
    }
}

function Engine:new(props)
    local self = {}
    function self:cons()
        self.audio = Audio:new()
        
        self.audio:parent(workspace)
    end

    self.state = Engine.States.Loading
    self.didInitialize = false
    self.currentAudioTime = -5000
    self.scoreManager = ScoreManager:new()
    self.hitsound = Hitsound:new()
    self.scrollSpeed = props.scrollSpeed
    self.objectPool = HitObjectPool:new({
        scrollSpeed = props.scrollSpeed;
        key = props.key;
        scoreManager = self.scoreManager;
        hitsound = self.hitsound;
    })

    self.didStart = false
    
    function self:load()
        self.audio:load(SongDatabase:get_data_for_key(props.key).AudioAssetId)
        self.offset = SongDatabase:get_data_for_key(props.key).AudioTimeOffset
    end

    function self:play()
        self.audio:play()
    end

    function self:stop()
        self.audio:stop(true)
    end

    function self:update(dt)
        if self.state == Engine.States.Loading then
            self.state = self.audio:loaded() and Engine.States.Playing or Engine.States.Loading
        elseif self.state == Engine.States.Playing then
            if (not self.didStart) and self.currentAudioTime > self.offset then
                self:play()
                self.didStart = true
                self.state = Engine.States.Playing
            end
            self.objectPool:update(self.currentAudioTime)
            self.currentAudioTime = self.currentAudioTime + (dt*1000)
        end
    end

    function self:getCurrentHitObjectsSerialized()
        return self.objectPool.trackSystem:getSerialized()
    end

    function self:press(lane)
        self.objectPool.trackSystem:getTrack(lane):pressAgainst()
    end

    function self:release(lane)
        self.objectPool.trackSystem:getTrack(lane):releaseAgainst()
    end

    function self:teardown()
        self:stop()
        self.hitsound:teardown()
        self.state = Engine.States.Cleanup
    end

    self:cons()

    return self
end

return Engine
