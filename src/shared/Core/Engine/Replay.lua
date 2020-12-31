local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

local Replay = {}

function Replay:new(hits)
    local self = {}

    self.hits = hits or {}

    function self:addHit(props)
        self.hits[#self.hits+1] = {
            time = props.time;
            press = {
                time = props.press.time;
                timeLeft = props.press.timeLeft;
            };
            release = props.release and {
                time = props.release.time;
                timeLeft = props.release.timeLeft;
            };
            timeLeft = props.timeLeft;
            judgement = props.judgement;
            lane = props.lane;
            id = props.id;
            timeReleased = props.timeReleased;
        }
    end

    function self:findHitWithId(id, startingIndex)
        startingIndex = startingIndex or 1
        for i = startingIndex, #self.hits do
            local v = self.hits[i]
            if v.id == id then
                return v
            end
        end
        return nil
    end

    return self
end

function Replay.perfectReplay(songkey, rate)
    local replay = Replay:new()

    local hitObjects = SongDatabase:get_hit_objects_for_key(songkey, rate)

    for id, v in ipairs(hitObjects) do
        replay:addHit({
            press = {
                time = v.Time;
                timeLeft = 0;
            };
            release = v.Duration and {
                time = v.Time + v.Duration;
                timeLeft = 0;
            };
            judgement = 5;
            lane = v.Track;
            id = id;
        })
    end

    return replay
end

function Replay.humanlikeReplay(songkey, rate)
    local replay = Replay:new()

    local hitObjects = SongDatabase:get_hit_objects_for_key(songkey, rate)

    for id, v in ipairs(hitObjects) do
        if math.random() < 0.98 then
            replay:addHit({
                press = {
                    time = v.Time;
                    timeLeft = math.random(-45, 45);
                };
                release = v.Duration and {
                    time = v.Time + v.Duration;
                    timeLeft = math.random(-45, 45);
                };
                judgement = 5;
                lane = v.Track;
                id = id;
            })
        end
    end

    return replay
end

return Replay
