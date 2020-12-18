local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Note = require(script.Parent.Note)

local Hold = Roact.Component:extend("Hold")

function Hold:init()
    self.laneToNoteRotation = {
        0,
        270,
        90,
        180,
    }
end

function Hold:render()
    return Roact.createFragment({
        Press = Roact.createElement(Note, {
            Image = "rbxassetid://5571834044";
            lane = self.props.lane;
            alpha = self.props.alpha;
            numberOfLanes = 4;
            upscroll = false;
        });
        Body = Roact.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(119, 117, 117);
            Size = UDim2.new(0.25, 0, self.props.alpha-self.props.releaseAlpha, 0);
            Position = UDim2.new((self.props.lane-1)/4, 0, self.props.alpha, 0);
            AnchorPoint = Vector2.new(0, 1);
        }, {
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0,4);
            })
        })
    })
end

return Hold
