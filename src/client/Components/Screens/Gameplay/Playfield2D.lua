local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Receptor = require(script.Parent.Receptor)

local Note = require(script.Parent.NoteTypes["2D"].Note)
local Hold = require(script.Parent.NoteTypes["2D"].Hold)

local Playfield2D = Roact.Component:extend("Playfield2D")

Playfield2D.defaultProps = {
    XOffset = 0.2;
}

function Playfield2D:init()
    self.motor = Flipper.SingleMotor.new(0)
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function Playfield2D:render()
    local hitObjs = {}

    for _, itrHitObj in ipairs(self.props.hitObjects) do
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

    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Size = UDim2.new(0.25, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0, 0);
        AnchorPoint = Vector2.new(0.5, 0);
        BorderSizePixel = 0;
        Visible = true;
    }, {
        Receptors = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0.2, 0);
            Position = UDim2.new(0, 0, 1-self.props.XOffset, 0);
            AnchorPoint = Vector2.new(0, 1);
            BackgroundTransparency = self.props.receptorBackgroundTransparency or 1;
        }, {
            Receptora = Roact.createElement(Receptor, {
                Image = "rbxassetid://5571834044";
                lane = 1;
                numberOfLanes = 4;
                keyToDarken = Enum.KeyCode.G;
                rotateArrow = true;
            });
            Receptorb = Roact.createElement(Receptor, {
                Image = "rbxassetid://5571834044";
                lane = 2;
                numberOfLanes = 4;
                keyToDarken = Enum.KeyCode.G;
                rotateArrow = true;
            });
            Receptorc = Roact.createElement(Receptor, {
                Image = "rbxassetid://5571834044";
                lane = 3;
                numberOfLanes = 4;
                keyToDarken = Enum.KeyCode.G;
                rotateArrow = true;
            });
            Receptord = Roact.createElement(Receptor, {
                Image = "rbxassetid://5571834044";
                lane = 4;
                numberOfLanes = 4;
                keyToDarken = Enum.KeyCode.G;
                rotateArrow = true;
            });
        });
        HitObjs = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1-(self.props.XOffset or self.DEFAULT_X_OFFSET), 0);
            Position = UDim2.new(0, 0, 0, 0);
            BackgroundTransparency = self.props.hitObjectBackgroundTransparency or 1;
        }, hitObjs);
    })
end

return Playfield2D