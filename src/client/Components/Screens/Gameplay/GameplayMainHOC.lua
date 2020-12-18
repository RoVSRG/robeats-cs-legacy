local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local RobeatsGame = require(game.ReplicatedStorage.Shared.Core.Engine)
local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.Parent.GameplayMain)

local GameplayMainHOC = Roact.Component:extend("GameplayMainHOC")

function GameplayMainHOC:init()
    self.game = RobeatsGame:new({
        scrollSpeed = 1000;
        key = 1;
    })

    self.sendStatsToGlobal = self.props.sendStatsToGlobal
    self.sendHitDevianceToGlobal = self.props.sendHitDevianceToGlobal

    self.didStart = false

    self.backOut = function()
        self.props.history:push("/results")
    end

    self:setState({
        hitObjects = self.game:getCurrentHitObjectsSerialized()
    })
end

function GameplayMainHOC:didMount()
    self.game:load()

    self.boundToFrame = SPUtil:bind_to_frame(function(dt)
        self.game:update(dt)

        self:setState({
            hitObjects = self.game:getCurrentHitObjectsSerialized()
        })
    end)
end

function GameplayMainHOC:render()
    return Roact.createElement(GameplayMain, {
        stats = self.props.stats;
        backOut = self.backOut;
        hitObjects = self.state.hitObjects;
    }, self.props[Roact.Children])
end

function GameplayMainHOC:willUnmount()
    self.game:teardown()
    self.boundToFrame:Disconnect()
end

return GameplayMainHOC
