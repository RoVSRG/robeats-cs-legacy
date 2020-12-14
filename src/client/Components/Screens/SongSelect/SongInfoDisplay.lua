local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)
local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)
local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local Gradient = require(game.ReplicatedStorage.Shared.Utils.Gradient)

local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)

local NpsGraph = require(game.ReplicatedStorage.Client.Components.Graph.NpsGraph)

local SongInfoDisplay = Roact.Component:extend("SongInfoDisplay")

local function noop() end

function SongInfoDisplay:init()
    self.onLeaderboardClick = self.props.onLeaderboardClick

    self.motor = Flipper.GroupMotor.new({
        title = 0;
        artist = 0;
    })
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function SongInfoDisplay:didUpdate()
    self.motor:setGoal({
        title = Flipper.Instant.new(0);
        artist = Flipper.Instant.new(0);
    })
    self.motor:step(0)
    self.motor:setGoal({
        title = Flipper.Spring.new(1, {
            frequency = 2;
            dampingRatio = 2.5;
        });
        artist = Flipper.Spring.new(1, {
            frequency = 2.5;
            dampingRatio = 2.5;
        });
    })
end

function SongInfoDisplay:didMount()
    self.motor:setGoal({
        title = Flipper.Spring.new(1, {
            frequency = 4;
            dampingRatio = 2.5;
        });
        artist = Flipper.Spring.new(1, {
            frequency = 2.5;
            dampingRatio = 2.5;
        });
    })
end

function SongInfoDisplay:getGradient()
    local gradient = Gradient:new()

    for i = 0, 1, 0.1 do
        gradient:add_number_keypoint(i, 1-i)
    end

    return gradient:number_sequence()
end

function SongInfoDisplay:render()
    local _songkey = self.props.song_key

    local total_notes, total_holds = SongDatabase:get_note_metrics_for_key(_songkey)
    return Roact.createElement("Frame", {
        Name = "SongInfoSection",
        AnchorPoint = self.props.AnchorPoint,
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Position = self.props.Position or UDim2.new(0,0,0,0),
        Size = self.props.Size or UDim2.new(1,0,1,0),
    }, {
        SongCover = Roact.createElement("ImageLabel", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0.25, 0),
            ScaleType = Enum.ScaleType.Crop,
            Image = SongDatabase:get_image_for_key(_songkey),
            BackgroundTransparency = 1;
        }, {
            Gradient = Roact.createElement("UIGradient", {
                Transparency = self:getGradient();
                Rotation = -90;
            }),
            Corner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0, 4),
            }),
        }),
        Corner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        Nps = Roact.createElement(NpsGraph, {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Position = UDim2.new(0.0134330085, 0, 0.796225548, 0),
            Size = UDim2.new(0.971014559, 0, 0.185931787, 0),
            song_key = _songkey,
        }),
        Metadata = Roact.createElement("Frame", {
            Name = "Metadata",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 11,
            Position = UDim2.new(0.05, 0, 0.31, 0),
            Size = UDim2.new(1, 0, 0.8, 0),
        }, {
            ArtistDisplay = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 1,
                Size = UDim2.new(0.75, 0, 0.1, 0);
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.05*(1-a.artist), 0, 0, 0)
                end),
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.artist
                end);
                Font = Enum.Font.Gotham,
                Text = SongDatabase:get_artist_for_key(_songkey),
                TextColor3 = Color3.fromRGB(255, 208, 87),
                TextScaled = true,
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                TextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 40,
                })
            }),
            TitleDisplay = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 2,
                Size = UDim2.new(0.75, 0, 0.1, 0);
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.05*(1-a.title), 0, 0.11, 0)
                end),
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.title
                end);
                Font = Enum.Font.GothamBold,
                Text = SongDatabase:get_title_for_key(_songkey),
                TextColor3 = Color3.fromRGB(255, 208, 87),
                TextScaled = true,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 40,
                })
            }),
            DifficultyDisplay = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 3,
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.05*(1-a.artist), 0, 0.2, 0)
                end),
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.title
                end);
                Size = UDim2.new(1, 0, 0.175, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("Difficulty: %d", SongDatabase:get_difficulty_for_key(_songkey)),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 14,
                })
            }),
            TotalNotesDisplay = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 3,
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.05*(1-a.artist), 0, 0.25, 0)
                end),
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.title
                end);
                Size = UDim2.new(1, 0, 0.175, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("Total Notes: %d", total_notes),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 14,
                })
            }),
            TotalHoldsDisplay = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 4,
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.05*(1-a.artist), 0, 0.3, 0)
                end),
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.title
                end);
                Size = UDim2.new(1, 0, 0.175, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("Total Holds: %d", total_holds),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 14,
                })
            }),
            TotalLengthDisplay = Roact.createElement("TextLabel", {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 4,
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(0.05*(1-a.artist), 0, 0.35, 0)
                end),
                TextTransparency = self.motorBinding:map(function(a)
                    return 1-a.title
                end);
                Size = UDim2.new(1, 0, 0.175, 0),
                Font = Enum.Font.GothamSemibold,
                Text = string.format("Total Length: %s", SPUtil:format_ms_time(SongDatabase:get_song_length_for_key(_songkey))),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 30,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, {
                Roact.createElement("UITextSizeConstraint", {
                    MaxTextSize = 14,
                })
            })
        }),
        Rate = Roact.createElement("TextLabel", {
            Name = "",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.98, 0, 0.75, 0),
            Size = UDim2.new(0.2, 0, 0.05, 0),
            AnchorPoint = Vector2.new(1, 0);
            ZIndex = 3,
            Font = Enum.Font.GothamBold,
            Text = string.format("%0.02fx", (self.props.rate and self.props.rate or 100)/100),
            TextColor3 = Color3.fromRGB(193, 193, 193),
            TextScaled = true;
            TextXAlignment = Enum.TextXAlignment.Right,
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                MaxTextSize = 14,
                MinTextSize = 10,
            })
        });
        ToLeaderboard = Roact.createElement(Button, {
            AnchorPoint = Vector2.new(0, 0.5);
            Size = UDim2.new(0.3, 0, 0.05, 0);
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Position = UDim2.new(0.05, 0, 0.735, 0);
            shrinkBy = -0.02;
            darkenBy = 11;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            Text = "Leaderboard >";
            onActivated = self.onLeaderboardClick;
            TextSize = 13;
        })
    })
end

return SongInfoDisplay