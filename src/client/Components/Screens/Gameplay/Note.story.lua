local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Story = require(game.ReplicatedStorage.Shared.Utils.Story)

local Note = require(script.Parent.Note)

local NoteStory = Story:new()

function NoteStory:render()
    return Roact.createElement(Note, {
        Image = "rbxassetid://5571834044";
        lane = 1;
        alpha = 0.6;
        numberOfLanes = 4;
        upscroll = false;
        keyToDarken = Enum.KeyCode.G;
    })
end
    
return NoteStory
