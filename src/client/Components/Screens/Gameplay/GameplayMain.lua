local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Engine = require(script.Parent.Engine)

-- local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

local Score = require(script.Parent.Score)
local Accuracy = require(script.Parent.Accuracy)
local TimeLeft = require(script.Parent.TimeLeft)
local SpreadDisplay = require(game.ReplicatedStorage.Client.Components.Screens.Results.SpreadDisplay)
local Combo = require(script.Parent.Combo)
local Playfield2D = require(script.Parent.Playfield2D)
-- local Playfield3D = require(script.Parent.Playfield3D)
-- local Judgement = require(script.Parent.Judgement)
-- local TabLayout = require(script.Parent.Parent.Parent.Layout.TabLayout)
local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)
-- local ConditionalReturn = require(game.ReplicatedStorage.Shared.Utils.ConditionalReturn)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

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

    self.keybinds = {
        Enum.KeyCode.V;
        Enum.KeyCode.B;
        Enum.KeyCode.KeypadOne;
        Enum.KeyCode.KeypadTwo;
    }

    self.currentAudioTime = 0

    self.scoreManager = Engine.Score.new({
        songKey = self.props.selectedSongKey;
    });

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
        hitObjects = {};
    })
    
    local function onNoteJudged(judgement, timeLeft)
        -- print(judgement)
    end

    self.notePool = Engine.NotePool.new({
        scrollSpeed = self.props.settings.scrollSpeed;
        onNoteJudged = onNoteJudged;
        songKey = self.props.selectedSongKey;
    })

    self.onPress = function(track)
        print(track)
        self.notePool:pressAgainst(track)
    end

    self.onRelease = function(track)
        self.notePool:releaseAgainst(track)
    end
    
    self.onPressCon = SPUtil:bind_to_key(Enum.KeyCode, function(keyCode)
        local track

        for i, v in ipairs(self.keybinds) do
            if keyCode == v then track = i break end
        end

        if not track then return end
        self.onPress(track)
    end)

    self.onReleaseCon = SPUtil:bind_to_key_release(Enum.KeyCode, function(keyCode)
        local track

        for i, v in ipairs(self.keybinds) do
            if keyCode == v then track = i break end
        end

        if not track then return end
        self.onRelease(track)
    end)

    self.everyFrame = SPUtil:bind_to_frame(function(dt)
        self.currentAudioTime += dt
        self.notePool:update(self.currentAudioTime*1000)

        self:setState({
            hitObjects = self.notePool:getSerialized()
        })
    end)

    self.isMobile = SPUtil:is_mobile()
end

function GameplayMain:render()
    local settings = self.props.settings
	return Roact.createElement("Frame", {
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
       Playfield = Roact.createElement(Playfield2D, {
           hitObjects = self.state.hitObjects;
       })
    });
end

function GameplayMain:willUnmount()
    self.everyFrame:Disconnect()
    self.onPressCon:Disconnect()
    self.onReleaseCon:Disconnect()
end

return GameplayMain
