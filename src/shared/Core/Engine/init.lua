local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)
local ScoreManager = require(script.ScoreManager)
local HitObjectPool = require(script.HitObjectPool)
local Hitsound = require(script.Hitsound)
local Audio = require(script.Audio)
local Replay = require(script.Replay)

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

        self.audio:set_volume(((props.volume/100)/2) or 0.5)
        self.audio:set_rate(props.rate or 1)

        self.audio:parent(workspace)
    end

    self.state = Engine.States.Loading
    self.didInitialize = false
    self.currentAudioTime = -5000
    self.scoreManager = ScoreManager:new()
    self.hitsound = Hitsound:new()

    self.scrollSpeed = 1000 * CurveUtil:YForPointOf2PtLine(Vector2.new(0,1), Vector2.new(40,0.2), props.scrollSpeed)
    
    self.objectPool = HitObjectPool:new({
        --replay = Replay.perfectReplay(props.key, props.rate);
        scrollSpeed = self.scrollSpeed;
        key = props.key;
        scoreManager = self.scoreManager;
        hitsound = self.hitsound;
        rate = props.rate;
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
