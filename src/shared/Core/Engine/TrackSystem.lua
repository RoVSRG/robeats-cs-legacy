local Track = require(script.Parent.Track)

local TrackSystem = {}

function TrackSystem:new(props)
    local self = {}
    self.scoreManager = props.scoreManager

    self.tracks = {}

    function self:cons()
        for i = 1, 4 do
            self.tracks[i] = Track:new({
                scoreManager = props.scoreManager;
            });
        end
    end

    function self:update()
        for i = 1, #self.tracks do
            self.tracks[i]:update()
        end
    end

    function self:pressTrack(track)
        self.tracks[track]:pressAgainst()
    end

    function self:releaseTrack(track)
        self.tracks[track]:releaseAgainst()
    end

    self:cons()

    return self
end

return TrackSystem
