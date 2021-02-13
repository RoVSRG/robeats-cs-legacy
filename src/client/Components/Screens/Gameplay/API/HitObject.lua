local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)
local AssertType = require(game.ReplicatedStorage.Shared.Utils.AssertType)

local Judgement = require(script.Parent.Judgement)

local HitObject = {}

function HitObject:new(props)
    AssertType:is_number(props.pressTime, "HitObject must have a press time!")
    AssertType:is_number(props.scrollSpeed, "HitObject must have a scroll speed!")
    AssertType:is_number(props.lane, "HitObject must have a lane!")

    local self = {}
    self.pressTime = props.pressTime
    self.releaseTime = props.releaseTime
    self.scrollSpeed = props.scrollSpeed
    self.currentAudioTime = 0
    self.lane = props.lane
    self.type = self.releaseTime and 2 or 1 -- implicitly define note type based on whether a "release time" was specified or not
    self.poolId = props.poolId

    self.releasedEarly = false
    self.headPressed = false

    self.pressTimeAlpha = 0
    self.releaseTimeAlpha = 0

    function self:update(currentAudioTime)
        self.currentAudioTime = currentAudioTime

        local spawnTime = self.pressTime - self.scrollSpeed
        self.pressTimeAlpha = NumberUtil.InverseLerp(spawnTime, self.pressTime, self.currentAudioTime)

        if self.type == 1 then
            return
        end

        if (self.currentAudioTime - self.pressTime > Judgement.TimingWindows[1].late) and not self.headPressed then
            self.releasedEarly = true
        end

        local spawnTimeRelease = self.releaseTime - self.scrollSpeed
        self.releaseTimeAlpha = NumberUtil.InverseLerp(spawnTimeRelease, self.releaseTime, self.currentAudioTime)
    end

    function self:currentPressJudgement()
        return Judgement:new({
            currentAudioTime = self.currentAudioTime;
            judgementTime = self.pressTime;
        })
    end

    function self:currentReleaseJudgement()
        return Judgement:new({
            currentAudioTime = self.currentAudioTime;
            judgementTime = self.releaseTime;
        })
    end

    function self:shouldRemove()
        local removeBy = self.type == 1 and self.pressTime or self.releaseTime

        return self.currentAudioTime - removeBy > Judgement.TimingWindows[1].late
    end

    return self
end

return HitObject
