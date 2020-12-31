local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local SongSelectUI = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongSelectMain)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local SongSelectMainApp = Story:new()

function SongSelectMainApp:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, Roact.createFragment({
        app = Roact.createElement(self.app)
    }))
end

function SongSelectMainApp:init()
    local testApp = SongSelectUI

    self.store = Rodux.Store.new(function(state, action)
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

    self.app = testApp
end


return SongSelectMainApp

