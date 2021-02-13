local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local EnvironmentSetup = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.API.EnvironmentSetup)

local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Note = require(script.Parent.NoteTypes["3D"].Note)
local Hold = require(script.Parent.NoteTypes["3D"].Hold)

local Playfield3D = Roact.Component:extend("Playfield3D")

function Playfield3D:init()
    self.DEFAULT_X_OFFSET = 0
end

function Playfield3D:didMount()
    self.playfield3D = EnvironmentSetup:setup_three_dimensional_world()
    self.keybinds = self.props.keybinds

    self.keybindToGIndex = {}

    for i, v in ipairs(self.keybinds) do
        self.keybindToGIndex[v] = i
    end

    local glows = {
        self.playfield3D.Track1.TriggerButtonProto.InteriorGlow;
        self.playfield3D.Track2.TriggerButtonProto.InteriorGlow;
        self.playfield3D.Track3.TriggerButtonProto.InteriorGlow;
        self.playfield3D.Track4.TriggerButtonProto.InteriorGlow;
    }

    self.motor = Flipper.GroupMotor.new({
        0;
        0;
        0;
        0;
    })

    self.keyBindings = {
        SPUtil:bind_to_key(Enum.KeyCode, function(keyCode)
            if self.keybindToGIndex[keyCode] then
                self.motor:setGoal({
                    [self.keybindToGIndex[keyCode]] = Flipper.Spring.new(1, {
                        frequency = 5;
                        dampingRatio = 2.5;
                    })
                })
            end
        end);
        SPUtil:bind_to_key_release(Enum.KeyCode, function(keyCode)
            if self.keybindToGIndex[keyCode] then
                self.motor:setGoal({
                    [self.keybindToGIndex[keyCode]] = Flipper.Spring.new(0, {
                        frequency = 8;
                        dampingRatio = 2.5;
                    })
                })
            end
        end)
    }

    self.motor:onStep(function(a)
        for i = 1, #glows do
            glows[i].Transparency = 1-a[i]
        end
    end)
end

function Playfield3D:render()
    return nil
end

function Playfield3D:willUnmount()
    self.playfield3D:Destroy()
    for _, binding in ipairs(self.keyBindings) do
        binding:Disconnect()
    end
    self.motor:stop()
end

return Playfield3D
