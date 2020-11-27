local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local function noop() return {} end

return function(getExtraProps, getExtraDispatches)
    getExtraProps = getExtraProps or noop
    getExtraDispatches = getExtraDispatches or noop

    return RoactRodux.connect(function(state, props)
        local extraProps = getExtraProps(state, props)
        local baseProps = {
            selectedSongKey = state.gameData.selectedSongKey;
            songRate = state.gameData.songRate
        }
        return Llama.Dictionary.join(baseProps, extraProps)
    end, function(dispatch)
        local extraDispatches = getExtraDispatches(dispatch)
        local baseDispacthes = {}
        return Llama.Dictionary.join(baseDispacthes, extraDispatches)
    end)
end
