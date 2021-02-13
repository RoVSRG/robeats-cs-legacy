local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local EnvironmentSetup = require(game.ReplicatedStorage.Client.Components.Screens.Gameplay.Engine.EnvironmentSetup)
local ThreeDimensionalHitObject = require(game.ReplicatedStorage.Shared.Utils.ThreeDimensionalHitObject)

local Note = Roact.Component:extend("Note")

function Note:init()
    self.laneToNoteRotation = {
        0,
        270,
        90,
        180,
    }
end

function Note:render()
    if not self.props.use2d then
        return Roact.createElement("ImageLabel", {
            Image = self.props.Image;
            Size = UDim2.new(1/self.props.numberOfLanes, 0, 0.2, 0);
            Position = UDim2.new(((self.props.lane-1)/self.props.numberOfLanes)+0.125, 0, self.props.upscroll and 1-self.props.alpha or self.props.alpha, 0);
            AnchorPoint = Vector2.new(0.5, 1);
            BackgroundTransparency = 1;
            Rotation = self.props.rotateArrow and self.laneToNoteRotation[self.props.lane];
            ZIndex = 25;
        }, {
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 1;
            });
            Chdn = Roact.createFragment(self.props[Roact.Children]);
        })
        else return
    end
end

return Note
