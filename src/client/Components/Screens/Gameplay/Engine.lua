local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Engine = require(game.ReplicatedStorage.Shared.Core.Engine)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local EngineHOC = Roact.Component:extend("EngineHOC")

local function noop() end

function EngineHOC:init()
    self.game = Engine:new({
        scrollSpeed = self.props.settings.scrollSpeed or 0;
        key = self.props.selectedSongKey;
        volume = self.props.settings.volume;
        rate = self.props.settings.rate;
    })

    self.game:load()

    self.keybinds = {
        [Enum.KeyCode.R] = 1;
        [Enum.KeyCode.T] = 2;
        [Enum.KeyCode.KeypadSeven] = 3;
        [Enum.KeyCode.KeypadEight] = 4;
    }
    

    self:setState({
        data = {
            hitObjects = self.game:getCurrentHitObjectsSerialized();
        }
    })

    self.press = function(lane)
        self.game:press(lane)
    end

    self.release = function(lane)
        self.game:release(lane)
    end

    self.keyConnections = {
        SPUtil:bind_to_key(Enum.KeyCode, function(keyCode)
            if self.keybinds[keyCode] then
                self.press(self.keybinds[keyCode])
            end
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode, function(keyCode)
            if self.keybinds[keyCode] then
                self.release(self.keybinds[keyCode])
            end
        end)
    }

    self.onExit = self.props.onExit or noop
    self.onJudgement = self.props.onJudgement or noop
end

function EngineHOC:didMount()
    self.boundToFrame = SPUtil:bind_to_frame(function(dt)
        self.game:update(dt)

        self:setState({
            data = {
                hitObjects = self.game:getCurrentHitObjectsSerialized();
            }
        })
    end)

    self.game.scoreManager.stats.onChange.Event:Connect(self.onJudgement)
end

function EngineHOC:render()
    return Roact.createFragment(self.props.render(self.state.data, self.press, self.release))
end

function EngineHOC:willUnmount()
    self.boundToFrame:Disconnect()
    self.game:teardown()
    for _, keyConnection in ipairs(self.keyConnections) do
        keyConnection:Disconnect()
    end

    self.onExit(self.game.scoreManager:getStatTable())
end

return EngineHOC
