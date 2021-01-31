local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Engine = require(script.Parent.Engine)
local Score = require(script.Parent.Score)
local Accuracy = require(script.Parent.Accuracy)
local TimeLeft = require(script.Parent.TimeLeft)
local SpreadDisplay = require(game.ReplicatedStorage.Client.Components.Screens.Results.SpreadDisplay)
local Combo = require(script.Parent.Combo)
local Playfield3D = require(script.Parent.Playfield3D)
local Judgement = require(script.Parent.Judgement)
local TabLayout = require(script.Parent.Parent.Parent.Layout.TabLayout)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)
local ConditionalReturn = require(game.ReplicatedStorage.Shared.Utils.ConditionalReturn)

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
            most_recent = 0;
        };
    })

    self.isMobile = SPUtil:is_mobile()
end

function GameplayMain:render()
    local settings = self.props.settings
	return Roact.createFragment({
        Engine = Roact.createElement(Engine, {
            selectedSongKey = self.props.selectedSongKey;
            onExit = function(data)
                self.doStats(data)
                self.doHitDeviance({})
            end;
            onJudgement = function(stats)
                self:setState({
                    stats = stats;
                })
            end;
            settings = {
                volume = settings.MusicVolume;
                scrollSpeed = settings.NoteSpeed;
                rate = self.props.data.songRate / 100;
                FOV = settings.FOV;
                Keybind1 = settings.Keybind1;
                Keybind2 = settings.Keybind2;
                Keybind3 = settings.Keybind3;
                Keybind4 = settings.Keybind4;
            };
            render = function(data, press, release)
                return Roact.createFragment({
                    Playfield = Roact.createElement(Playfield3D, {
                        XOffset = 0.1;
                        hitObjects = data.hitObjects;
                        keybinds = {
                            settings.Keybind1;
                            settings.Keybind2;
                            settings.Keybind3;
                            settings.Keybind4;
                        }
                    });
                    TapButtons = ConditionalReturn(self.isMobile, (
                        Roact.createElement(TabLayout, {
                            totalButtons = 4;
                            Size = UDim2.new(1, 0, 0.2, 0);
                            AnchorPoint = Vector2.new(0, 1);
                            Position = UDim2.new(0, 0, 1, 0);
                            buttons = {
                                {
                                    Text = "1",
                                    onPress = function()
                                        press(1)
                                    end;
                                    onRelease = function()
                                        release(1)
                                    end
                                },
                                {
                                    Text = "2",
                                    onPress = function()
                                        press(2)
                                    end;
                                    onRelease = function()
                                        release(2)
                                    end
                                },
                                {
                                    Text = "3",
                                    onPress = function()
                                        press(3)
                                    end;
                                    onRelease = function()
                                        release(3)
                                    end
                                },
                                {
                                    Text = "4",
                                    onPress = function()
                                        press(4)
                                    end;
                                    onRelease = function()
                                        release(4)
                                    end
                                }
                            }
                        })
                    ))
                })
                
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
            });
            Judgement = Roact.createElement(Judgement, {
                judgement = self.state.stats.most_recent;
            })
        });
    })
end

return GameplayMain
