local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local EnvironmentSetup = require(game.ReplicatedStorage.Shared.Core.Engine.EnvironmentSetup)

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
    local hitObjs = {}

    for _, track in ipairs(self.props.hitObjects) do
        for k = 1, #track do
            local itrHitObj = track[k]
            if itrHitObj.type == 1 then
                hitObjs[itrHitObj.poolId] = Roact.createElement(Note, {
                    alpha = itrHitObj.pressAlpha;
                    numberOfLanes = 4;
                    lane = itrHitObj.lane;
                    Image = "rbxassetid://5571834044";
                    rotateArrow = true;
                    playfield = self.playfield3D;
                    poolId = itrHitObj.poolId;
                })
            elseif itrHitObj.type == 2 then
                hitObjs[itrHitObj.poolId] = Roact.createElement(Hold, {
                    alpha = itrHitObj.headPressed and 1 or itrHitObj.pressAlpha;
                    headPressed = itrHitObj.headPressed;
                    releaseAlpha = itrHitObj.releaseAlpha;
                    lane = itrHitObj.lane;
                    releasedEarly = itrHitObj.releasedEarly;
                    Image = "rbxassetid://5571834044";
                    playfield = self.playfield3D;
                    poolId = itrHitObj.poolId;
                })
            end
        end
    end

    return Roact.createFragment(hitObjs)
    
    -- Roact.createElement("Frame", {
    --     BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    --     Size = UDim2.new(0.25, 0, 1, 0);
    --     Position = UDim2.new(0.1, 0, 0, 0);
    --     AnchorPoint = Vector2.new(0.5, 0);
    --     BorderSizePixel = 0;
    --     Visible = true;
    -- }, {
    --     Receptors = Roact.createElement("Frame", {
    --         Size = UDim2.new(1, 0, 0.2, 0);
    --         Position = UDim2.new(0, 0, 1-(self.props.XOffset or self.DEFAULT_X_OFFSET), 0);
    --         AnchorPoint = Vector2.new(0, 1);
    --         BackgroundTransparency = self.props.receptorBackgroundTransparency or 1;
    --     }, {
    --         Receptora = Roact.createElement(Receptor, {
    --             Image = "rbxassetid://5571834044";
    --             lane = 1;
    --             numberOfLanes = 4;
    --             keyToDarken = Enum.KeyCode.G;
    --             rotateArrow = true;
    --         });
    --         Receptorb = Roact.createElement(Receptor, {
    --             Image = "rbxassetid://5571834044";
    --             lane = 2;
    --             numberOfLanes = 4;
    --             keyToDarken = Enum.KeyCode.G;
    --             rotateArrow = true;
    --         });
    --         Receptorc = Roact.createElement(Receptor, {
    --             Image = "rbxassetid://5571834044";
    --             lane = 3;
    --             numberOfLanes = 4;
    --             keyToDarken = Enum.KeyCode.G;
    --             rotateArrow = true;
    --         });
    --         Receptord = Roact.createElement(Receptor, {
    --             Image = "rbxassetid://5571834044";
    --             lane = 4;
    --             numberOfLanes = 4;
    --             keyToDarken = Enum.KeyCode.G;
    --             rotateArrow = true;
    --         });
    --     });
    --     HitObjs = Roact.createElement("Frame", {
    --         Size = UDim2.new(1, 0, 1-(self.props.XOffset or self.DEFAULT_X_OFFSET), 0);
    --         Position = UDim2.new(0, 0, 0, 0);
    --         BackgroundTransparency = self.props.hitObjectBackgroundTransparency or 1;
    --     }, hitObjs);
    --     Judgement = Roact.createElement(Judgement, {
    --         judgement = self.props.judgement;
    --     })
    -- })
end

function Playfield3D:willUnmount()
    self.playfield3D:Destroy()
    for _, binding in ipairs(self.keyBindings) do
        binding:Disconnect()
    end
    self.motor:stop()
end

return Playfield3D
