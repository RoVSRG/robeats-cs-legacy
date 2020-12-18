local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Receptor = Roact.Component:extend("Receptor")

function Receptor:init()
    self.laneToReceptorRotation = {
        0,
        270,
        90,
        180,
    }
end

function Receptor:render()
    return Roact.createElement("ImageLabel", {
        Image = self.props.Image;
        Size = UDim2.new(1/self.props.numberOfLanes, 0, self.props.ySize or 0.2, 0);
        Position = UDim2.new(((self.props.lane-1)/self.props.numberOfLanes)+0.125, 0, self.props.upscroll and (self.props.YOffset or 0) or 1-(self.props.YOffset or 0), 0);
        AnchorPoint = Vector2.new(0.5, self.props.upscroll and 0 or 1);
        BackgroundTransparency = 1;
        Rotation = self.props.rotateArrow and self.laneToReceptorRotation[self.props.lane]
    }, {
        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
            AspectRatio = 1;
            AspectType = "ScaleWithParentSize";
            DominantAxis = "Width";
        })
    })
end

return Receptor
