local Track = require(script.Parent.Track)

local TrackSystem = {}

function TrackSystem:new(props)
    local self = {}
    self.scoreManager = props.scoreManager
    self.hitsound = props.hitsound

    self.tracks = {}

    function self:cons()
        for i = 1, 4 do
            self.tracks[i] = Track:new({
                scoreManager = props.scoreManager;
                hitsound = props.hitsound;
            });
        end
    end

    function self:update(currentAudioTime)
        for i = 1, #self.tracks do
            self.tracks[i]:update(currentAudioTime)
        end
    end

    function self:getTrack(lane)
        return self.tracks[lane]
    end
    
    function self:pressTrack(track)
        self:getTrack(track):pressAgainst()
    end

    function self:releaseTrack(track)
        self:getTrack(track):releaseAgainst()
    end

    function self:getSerialized()
        local ret = {}

        for i = 1, #self.tracks do
            local track = self.tracks[i]
            ret[i] = track:getSerialized()
        end

        return ret
    end

    self:cons()

    return self
end

return TrackSystem
