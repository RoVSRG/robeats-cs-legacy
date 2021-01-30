local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Sound = Roact.Component:extend("Sound")

Sound.defaultProps = {
    animateVolume = false;
    Volume = 0.5;
    SoundId = "rbxassetid://5415754345";
    TimePosition = 0;
}

function Sound:render()
    return Roact.createElement("Sound", {
        SoundId = self.props.SoundId;
        Playing = self.props.Playing;
        Volume = self.props.Volume;
        TimePosition = self.props.TimePosition;
        [Roact.Ref] = self.props[Roact.Ref];
    })
end

return Sound