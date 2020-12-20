local CurveUtil = require(game.ReplicatedStorage.Shared.Utils.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local RobeatsGame = require(game.ReplicatedStorage.Shared.Core.Engine)
local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)

local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local GameplayMain = require(script.Parent.GameplayMain)

local GameplayMainHOC = Roact.Component:extend("GameplayMainHOC")

function GameplayMainHOC:init()
    self.game = RobeatsGame:new({
        scrollSpeed = 450;
        key = self.props.selectedSongKey;
    })

    self.sendStatsToGlobal = self.props.sendStatsToGlobal
    self.sendHitDevianceToGlobal = self.props.sendHitDevianceToGlobal

    self.didStart = false

    self.backOut = function()
        self.props.history:push("/results")
    end

    self.game:load()
    

    self:setState({
        hitObjects = self.game:getCurrentHitObjectsSerialized();
        stats = {
            accuracy = 0;
            maxcombo = 0;
            marvelouses = 0;
            perfects = 0;
            greats = 0;
            goods = 0;
            bads = 0;
            misses = 0;
            combo = 0;
            score = 0;
        };
    })

    self.keyConnections = {
        SPUtil:bind_to_key(Enum.KeyCode.Q, function()
            self.game:press(1)
        end);
        SPUtil:bind_to_key(Enum.KeyCode.W, function()
            self.game:press(2)
        end);
        SPUtil:bind_to_key(Enum.KeyCode.O, function()
            self.game:press(3)
        end);
        SPUtil:bind_to_key(Enum.KeyCode.P, function()
            self.game:press(4)
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode.Q, function()
            self.game:release(1)
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode.W, function()
            self.game:release(2)
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode.O, function()
            self.game:release(3)
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode.P, function()
            self.game:release(4)
        end);
    }

    self.game.scoreManager:bindToChange(function(stats)
        self:setState({
            stats = stats
        })
    end)
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
        stats = self.state.stats;
        backOut = self.backOut;
        hitObjects = self.state.hitObjects;
    }, self.props[Roact.Children])
end

function GameplayMainHOC:willUnmount()
    self.boundToFrame:Disconnect()
    self.game:teardown()
    for _, keyConnection in ipairs(self.keyConnections) do
        keyConnection:Disconnect()
    end
end

return GameplayMainHOC
