local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Rodux = require(game.ReplicatedStorage.Libraries.Rodux)
local RoactRodux = require(game.ReplicatedStorage.Libraries.RoactRodux)
local Story = require(game.ReplicatedStorage.Shared.Utils.Story)
local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local ResultsScreenMain = require(script.Parent.ResultsScreenMain)

local ResultsScreenMainApp = Story:new()

function ResultsScreenMainApp:render()
    return Roact.createElement(RoactRodux.StoreProvider, { 
        store = self.store
    }, Roact.createFragment({
        app = Roact.createElement(self.testApp)
    }))
end

function ResultsScreenMainApp:init()
    local testApp = ResultsScreenMain

    self.store = Rodux.Store.new(function(state, action)
        state = state or {
            stats = {
                accuracy = 0;
                maxcombo = 0;
                marvelouses = 1;
                perfects = 0;
                greats = 0;
                goods = 0;
                bads = 0;
                misses = 0;
                combo = 0;
                score = 0;
            }
        }
        return state
    end)

    self.testApp = RoactRodux.connect(function(state, props)
        return state
    end)(testApp)
end

return ResultsScreenMainApp
