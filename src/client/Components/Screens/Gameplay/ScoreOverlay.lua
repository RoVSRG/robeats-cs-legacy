local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Score = require(script.Parent.Score)
local Accuracy = require(script.Parent.Accuracy)
local TimeLeft = require(script.Parent.TimeLeft)
local SpreadDisplay = require(game.ReplicatedStorage.Client.Components.Screens.Results.SpreadDisplay)
local Combo = require(script.Parent.Combo)

local ScoreOverlay = Roact.Component:extend("ScoreOverlay")

function ScoreOverlay:render()
    return Roact.createFragment({
        Score = Roact.createElement(Score, {
            Position = UDim2.new(0.98,0,0.02,0);
            Size = UDim2.new(0.25,0,0.08,0);
            score = self.props.score
        });
        Accuracy = Roact.createElement(Accuracy, {
            Position = UDim2.new(0.98,0,0.112,0);
            Size = UDim2.new(0.25,0,0.04,0);
            accuracy = self.props.accuracy
        });
        TimeLeft = Roact.createElement(TimeLeft, {
            Position = UDim2.new(0.98,0,0.9,0);
            Size = UDim2.new(0.2,0,0.1,0);
            time_left = self.props.time_left;
        });
        Combo = Roact.createElement(Combo, {
            Position = UDim2.new(0.5,0,0.5,0);
            Size = UDim2.new(1,0,0.2,0);
            combo = self.props.combo;
        });
        SpreadDisplay = Roact.createElement(SpreadDisplay, {
            Position = UDim2.new(0.98,0,0.2,0);
            Size = UDim2.new(0.127,0,0.3,0);
            AnchorPoint = Vector2.new(1,0);
            marvelouses = self.props.marvs;
            perfects = self.props.perfs;
            greats = self.props.greats;
            goods = self.props.goods;
            bads = self.props.bads;
            misses = self.props.misses;
        })
    })
end

return ScoreOverlay
