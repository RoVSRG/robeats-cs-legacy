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

    self.keybinds = {
        [Enum.KeyCode.Q] = 1;
        [Enum.KeyCode.W] = 2;
        [Enum.KeyCode.O] = 3;
        [Enum.KeyCode.P] = 4;
    }
    

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
        SPUtil:bind_to_key(Enum.KeyCode, function(keyCode)
            if self.keybinds[keyCode] then
                self.game:press(self.keybinds[keyCode])
            end
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode, function(keyCode)
            if self.keybinds[keyCode] then
                self.game:release(self.keybinds[keyCode])
            end
        end)
    }
end

function GameplayMainHOC:didMount()
    self.game:load()

    self.boundToFrame = SPUtil:bind_to_frame(function(dt)
        self.game:update(dt)

        self:setState({
            hitObjects = self.game:getCurrentHitObjectsSerialized();
            mostRecentJudgement = self.game.scoreManager.mostRecentJudgement;
            stats = self.game.scoreManager.stats;
        })
    end)
end

function GameplayMainHOC:render()
    return Roact.createElement(GameplayMain, {
        stats = self.game.scoreManager.stats;
        backOut = self.backOut;
        hitObjects = self.state.hitObjects;
        judgement = self.state.mostRecentJudgement;
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
