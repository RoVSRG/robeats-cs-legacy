local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Receptor = require(script.Parent.Receptor)

local PlayfieldMode = require(script.Parent.PlayfieldMode)

local Note = require(script.Parent.NoteTypes["2D"].Note)
local Hold = require(script.Parent.NoteTypes["2D"].Hold)

local Playfield = Roact.Component:extend("Playfield")

Playfield.defaultProps = {
    mode = PlayfieldMode.TwoDimensional;
    XOffset = 0.1;
}

function Playfield:init()

end

function Playfield:render()
    if self.props.mode ~= PlayfieldMode.TwoDimensional then
        return nil
    end

    local hitObjs = {}

    for _, itrHitObj in ipairs(self.props.hitObjects) do
        if itrHitObj.type == 1 then
            hitObjs[itrHitObj.poolId] = Roact.createElement(Note, {
                alpha = itrHitObj.pressAlpha;
                numberOfLanes = 4;
                lane = itrHitObj.lane;
                Image = "rbxassetid://6405683288";
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
                Image = "rbxassetid://6405683288";
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
                Image = "rbxassetid://6405686835";
                lane = 1;
                numberOfLanes = 4;
            });
            Receptorb = Roact.createElement(Receptor, {
                Image = "rbxassetid://6405687326";
                lane = 2;
                numberOfLanes = 4;
            });
            Receptorc = Roact.createElement(Receptor, {
                Image = "rbxassetid://6405687877";
                lane = 3;
                numberOfLanes = 4;
            });
            Receptord = Roact.createElement(Receptor, {
                Image = "rbxassetid://6405688589";
                lane = 4;
                numberOfLanes = 4;
            });
        });
        HitObjs = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1-(self.props.XOffset or self.DEFAULT_X_OFFSET), 0);
            Position = UDim2.new(0, 0, 0, 0);
            BackgroundTransparency = self.props.hitObjectBackgroundTransparency or 1;
        }, hitObjs);
    })
end

return Playfield