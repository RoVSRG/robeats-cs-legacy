local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)

local function ScrollSpeed(arbitraryScrollSpeedValue)
    return 1000 * CurveUtil:YForPointOf2PtLine(Vector2.new(0,1), Vector2.new(40,0.2), props.scrollSpeed or 0)
end

return ScrollSpeed