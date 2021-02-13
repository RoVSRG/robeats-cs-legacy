local Window = require(script.Parent.Window)

local Judgement = {}

Judgement.TimingWindows = {
    Window:new(-136, 136); --Bad
    Window:new(-112, 112); --Good
    Window:new(-82, 82); --Great
    Window:new(-49, 49); --Perfect
    Window:new(-16, 16); --Marvelous
}

function Judgement:new(props)
    local timeLeft = props.currentAudioTime - props.judgementTime
    local currentJudgement = 0
    
    for i, window in ipairs(self.TimingWindows) do
        if not (timeLeft >= window.early and timeLeft <= window.late) then break end
        currentJudgement = i
    end

    return {
        judgement = currentJudgement;
        timeLeft = timeLeft;
    }
end

return Judgement
