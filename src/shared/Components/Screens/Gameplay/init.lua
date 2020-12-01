local Llama = require(game.ReplicatedStorage.Libraries.Llama)
local with = require(game.ReplicatedStorage.Shared.State.with)

local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local RobeatsGame = require(game.ReplicatedStorage.RobeatsGameCore.RobeatsGame)
local EnvironmentSetup = require(game.ReplicatedStorage.RobeatsGameCore.EnvironmentSetup)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.GameplayMain)

local GameplayMainHOC = Roact.Component:extend("GameplayMainHOC")

function GameplayMainHOC:init()
    self.game_instance = RobeatsGame:new(EnvironmentSetup:get_game_environment_center_position())
    self.game_instance._audio_manager:load_song(1)
    self.game_instance:setup_world(1)

    self.didStart = false

    self.onStatChange = self.game_instance._score_manager:bind_to_change(function(stats)
        self:setState({
            stats = stats;
        })
    end)

    self:setState({
        stats = self.game_instance._score_manager:get_stat_table()
    })
end

function GameplayMainHOC:didMount()
    SPUtil:bind_to_frame(function(dt)
        if self.game_instance._audio_manager:is_ready_to_play() == true and not self.didStart then
            self.didStart = true
            self.game_instance:start_game()
        elseif self.didStart then
            self.game_instance:update(CurveUtil:DeltaTimeToTimescale(dt))
        end
    end)
end

function GameplayMainHOC:render()
    return Roact.createElement(GameplayMain, {
        stats = self.state.stats;
    }, self.props[Roact.Children])
end

function GameplayMainHOC:willUnmount()
    self.game_instance:teardown()
    self.onStatChange:Disconnect()
    self.props.setStatsToGlobal(self.game_instance._score_manager:get_stat_table())
end

return with(function(state, props)
    return {
        isPlaying = state.gameState.isPlaying;
    }
end,
function(dispatch)
    return {
        backOut = function()
            dispatch({type = "setForceQuit", value = true})
        end;
        setStatsToGlobal = function(stats)
            dispatch(Llama.Dictionary.join({type = "setStats"}, stats))
        end
    }
end)(GameplayMainHOC)