local with = require(game.ReplicatedStorage.Client.State.with)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local SongSelect = require(script.SongSelectMain)

return with(nil, function(dispatch)
    return {
        selectSongKey = function(key)
            dispatch({type = "changeSelectedSongKey", songKey = key})
        end;
        startGame = function()
            dispatch({type = "setIsPlaying", value = true})
            dispatch({type = "setIsLoading", value = true})
        end;
        changeRate = function(rate)
            dispatch({type = "changeRate", delta = rate})
        end
    }
end)(SongSelect)
