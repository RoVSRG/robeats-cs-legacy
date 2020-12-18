local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local ScoreManager = require(script.ScoreManager)
local HitObjectPool = require(script.HitObjectPool)
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

    self.audioTime = props.audioTime or 0
    self.state = Engine.States.Loading
    self.didInitialize = false
    self.currentTime = 0
    --self.scoreManager = ScoreManager:new()
    self.objectPool = HitObjectPool:new({
        scrollSpeed = props.scrollSpeed;
        key = props.key;
    })
    
    function self:load()
        self.audio:load(SongDatabase:get_data_for_key(props.key).AudioAssetId)
    end

    function self:play()
        self.audio:play()
    end

    function self:update(dt)
        if self.state == Engine.States.Loading then
            if self.audio:loaded() then
                self.state = Engine.States.Playing
            end
        elseif self.state == Engine.States.Playing then
            self.objectPool:update(self.currentTime)
            self.currentTime = self.currentTime + (dt*1000)
        elseif self.state == Engine.State.Cleanup then
            self.audio:stop()
            self.state = Engine.States.Idle
        end
    end

    function self:teardown()
        self.state = Engine.States.Cleanup
    end

    self:cons()

    return self
end

return Engine
