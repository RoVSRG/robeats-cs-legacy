local Roact = require(game.ReplicatedStorage.Libraries.Roact)


local Slideshow = Roact.Component:extend("Slideshow")

function Slideshow:render()
    return Roact.createElement("Frame", {
        Size = self.props.Size;
        Position = self.props.Position;
        BackgroundTransparency = self.props.BackgroundTransparency;
        ClipsDescendants = true;
    }, self.props.render(self.props.slide))
end

return Slideshow
