local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)

local GameplayMain = require(script.Parent.GameplayMain)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local GameplayMainApp = Story:new()

function GameplayMainApp:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        MainComponent = Roact.createElement(self.component)
    })
end

function GameplayMainApp:init()
    self.store = Rodux.Store.new(function(state, action)
        state = state or {
            stats = {
                marvelouses = 1;
                perfects = 0;
                greats = 0;
                goods = 0;
                bads = 0;
                misses = 0;
                score = 0;
                accuracy = 0;
                time_left = 0;
                combo = 0;
            }
        }
        return state
    end)

    self.component = RoactRodux.connect(function(state)
        return state
    end)(GameplayMain)
end

return GameplayMainApp
