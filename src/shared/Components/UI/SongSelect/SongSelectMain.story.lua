local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local SongSelectUI = require(game.ReplicatedStorage.Shared.Components.UI.SongSelect.SongSelectMain)

return function(target)
    local testApp = SongSelectUI

    local store = Rodux.Store.new(function(state, action)
        state = state or {
            selectedSongKey = 1
        }
        if action.type == "changeSelectedSongKey" then
            return {
                selectedSongKey = action.songKey
            }
        end
        return state
    end)

    testApp = RoactRodux.connect(function(state, props)
        return {
            selectedSongKey = state.selectedSongKey
        }
    end,
    function(dispatch)
        return {
            selectSongKey = function(key)
                dispatch({type = "changeSelectedSongKey", songKey = key})
            end,
        }
    end)(testApp)

    local toMount = Roact.createElement(RoactRodux.StoreProvider, {
        store = store
    }, Roact.createFragment({
        app = Roact.createElement(testApp)
    }))

    local fr = Roact.mount(toMount, target)

    return function()
        Roact.unmount(fr)
    end 
end
