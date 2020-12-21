local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Engine = require(game.ReplicatedStorage.Shared.Core.Engine)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local EngineHOC = Roact.Component:extend("EngineHOC")

function EngineHOC:init()
    self.game = Engine:new({
        scrollSpeed = 450;
        key = self.props.selectedSongKey;
    })

    self.game:load()

    self.keybinds = {
        [Enum.KeyCode.Q] = 1;
        [Enum.KeyCode.W] = 2;
        [Enum.KeyCode.O] = 3;
        [Enum.KeyCode.P] = 4;
    }
    

    self:setState({
        data = {
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
            mostRecentJudgement = 0;
        }
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

function EngineHOC:didMount()
    self.boundToFrame = SPUtil:bind_to_frame(function(dt)
        self.game:update(dt)

        self:setState({
            data = {
                hitObjects = self.game:getCurrentHitObjectsSerialized();
                mostRecentJudgement = self.game.scoreManager.mostRecentJudgement;
                stats = self.game.scoreManager.stats:getValue();
            }
        })
    end)
end

function EngineHOC:render()
    return Roact.createFragment(self.props.render(self.state.data))
end

function EngineHOC:willUnmount()
    self.boundToFrame:Disconnect()
    self.game:teardown()
    for _, keyConnection in ipairs(self.keyConnections) do
        keyConnection:Disconnect()
    end
end

return EngineHOC
