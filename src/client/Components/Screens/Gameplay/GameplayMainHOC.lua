local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local RobeatsGame = require(game.ReplicatedStorage.Shared.Core.Engine)
local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.Parent.GameplayMain)

local GameplayMainHOC = Roact.Component:extend("GameplayMainHOC")

function GameplayMainHOC:init()
    self.game = RobeatsGame:new()

    self.sendStatsToGlobal = self.props.sendStatsToGlobal
    self.sendHitDevianceToGlobal = self.props.sendHitDevianceToGlobal

    self.didStart = false

    self.onStatChange = self.game._score_manager:bind_to_change(function(stats)
        self.sendStatsToGlobal(stats)
    end)

    self.backOut = function()
        self.props.history:push("/results")
    end
end

function GameplayMainHOC:didMount()
    self.boundToFrame = SPUtil:bind_to_frame(function(dt)
        -- if self.game._audio_manager:is_ready_to_play() == true and not self.didStart then
        --     self.didStart = true
        --     self.game:start_game()
        -- elseif self.didStart then
        --     self.game:update(CurveUtil:DeltaTimeToTimescale(dt))
        -- end
    end)
end

function GameplayMainHOC:render()
    return Roact.createElement(GameplayMain, {
        stats = self.props.stats;
        backOut = self.backOut;
    }, self.props[Roact.Children])
end

function GameplayMainHOC:willUnmount()
    self.sendStatsToGlobal(self.game._score_manager:get_stat_table())
    self.sendHitDevianceToGlobal(self.game._score_manager:get_hit_deviance())
    self.game:teardown()
    self.onStatChange:Disconnect()
    self.boundToFrame:Disconnect()
end

return GameplayMainHOC
