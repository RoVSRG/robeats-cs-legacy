local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Engine = require(script.Parent.Engine)
local Score = require(script.Parent.Score)
local Accuracy = require(script.Parent.Accuracy)
local TimeLeft = require(script.Parent.TimeLeft)
local SpreadDisplay = require(game.ReplicatedStorage.Client.Components.Screens.Results.SpreadDisplay)
local Combo = require(script.Parent.Combo)
local Playfield = require(script.Parent.Playfield)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)

local GameplayMain = Roact.Component:extend("GameplayMain")

function GameplayMain:didMount()
    self.motor:setGoal(Flipper.Spring.new(1, {
        frequency = 3.5;
        dampingRatio = 2;
    }))
end

function GameplayMain:init()
	self.motor = Flipper.SingleMotor.new(0)
    self.motorBinding = RoactFlipper.getBinding(self.motor)

    self.backOut = function()
        self.props.history:push("/results")
    end

    self.doStats = self.props.doStats
    self.doHitDeviance = self.props.doHitDeviance

    self:setState({
        stats = {
			score = 0;
			marvelouses = 0;
			perfects = 0;
			greats = 0;
			goods = 0;
			bads = 0;
			misses = 0;
			combo = 0;
			accuracy = 0;
			max_combo = 0;
		}
    })
end

function GameplayMain:render()
	return Roact.createFragment({
        Engine = Roact.createElement(Engine, {
            selectedSongKey = self.props.selectedSongKey;
            onExit = function(data)
                self.doStats(data)
                self.doHitDeviance({})
            end;
            onJudgement = function(stats)
                print(stats)                
            end;
            render = function(data)
                return Roact.createElement(Playfield, {
                    XOffset = 0.1;
                    hitObjects = data.hitObjects;
                });
            end
        });
        Stats = Roact.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            Score = Roact.createElement(Score, {
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.98*(2-a),0,0.02,0);
                end);
                Size = UDim2.new(0.25,0,0.08,0);
                score = self.state.stats.score
            });
            Accuracy = Roact.createElement(Accuracy, {
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.98*(2-a),0,0.112,0);
                end);
                Size = UDim2.new(0.25,0,0.04,0);
                accuracy = self.state.stats.accuracy
            });
            TimeLeft = Roact.createElement(TimeLeft, {
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.98*(2-a),0,0.9,0);
                end);
                Size = UDim2.new(0.2,0,0.1,0);
                time_left = self.state.stats.time_left;
            });
            Combo = Roact.createElement(Combo, {
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.5*(2-a),0,0.5,0);
                end);
                Size = UDim2.new(1,0,0.2,0);
                combo = self.state.stats.combo;
            });
            SpreadDisplay = Roact.createElement(SpreadDisplay, {
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.98*(2-a),0,0.2,0);
                end);
                Size = UDim2.new(0.127,0,0.3,0);
                AnchorPoint = Vector2.new(1,0);
                marvelouses = self.state.stats.marvelouses;
                perfects = self.state.stats.perfects;
                greats = self.state.stats.greats;
                goods = self.state.stats.goods;
                bads = self.state.stats.bads;
                misses = self.state.stats.misses;
            });
            ExitButton = Roact.createElement("TextButton", {
                BackgroundColor3 = Color3.fromHSV(0, 1, 0.85),
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(NumberUtil.Lerp(-0.5, 0.02, a), 0, 0.05, 0)
                end);
                Size = UDim2.new(0.1, 0, 0.05, 0),
                Font = Enum.Font.GothamSemibold,
                Text = "Exit",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 22,
                [Roact.Event.InputBegan] = SPUtil:input_callback(function()
                    self.backOut()
                end)
            }, {
                UICorner = Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4),
                })
            })
        })
    })
end

return GameplayMain
