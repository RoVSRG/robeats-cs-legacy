local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Receptor = require(script.Parent.Receptor)
local Note = require(script.Parent.Note)
local Hold = require(script.Parent.Hold)
local Judgement = require(script.Parent.Judgement)

local Playfield = Roact.Component:extend("Playfield")

function Playfield:init()
    self.DEFAULT_X_OFFSET = 0
end

function Playfield:render()
    local hitObjs = {}

    for _, track in ipairs(self.props.hitObjects) do
        for k = 1, #track do
            local itrHitObj = track[k]
            if itrHitObj.type == 1 then
                hitObjs[#hitObjs+1] = Roact.createElement(Note, {
                    alpha = itrHitObj.pressAlpha;
                    numberOfLanes = 4;
                    lane = itrHitObj.lane;
                    Image = "rbxassetid://5571834044";
                    rotateArrow = true;
                })
            elseif itrHitObj.type == 2 then
                hitObjs[#hitObjs+1] = Roact.createElement(Hold, {
                    alpha = itrHitObj.headPressed and 1 or itrHitObj.pressAlpha;
                    releaseAlpha = itrHitObj.releaseAlpha;
                    numberOfLanes = 4;
                    lane = itrHitObj.lane;
                    Image = "rbxassetid://5571834044";
                    rotateArrow = true;
                })
            end
        end
    end

    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Size = UDim2.new(0.25, 0, 1, 0);
        Position = UDim2.new(0.5, 0, 0, 0);
        AnchorPoint = Vector2.new(0.5, 0);
        BorderSizePixel = 0;
    }, {
        Receptors = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0.2, 0);
            Position = UDim2.new(0, 0, 1-(self.props.XOffset or self.DEFAULT_X_OFFSET), 0);
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
        Judgement = Roact.createElement(Judgement, {
            judgement = self.props.judgement;
        })
    })
end

return Playfield
