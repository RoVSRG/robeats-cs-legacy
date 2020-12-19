local Roact: Roact = require(game.ReplicatedStorage.Libraries.Roact)

local Flipper = require(game.ReplicatedStorage.Libraries.Flipper)
local RoactFlipper = require(game.ReplicatedStorage.Libraries.RoactFlipper)

local SongSelectUI: RoactComponent = Roact.PureComponent:extend("SongSelectUI")

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

local TweenService = game:GetService("TweenService")

local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)

local SongButtonLayout = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButtonLayout)
local LeaderboardDisplay = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.LeaderboardDisplay)
local TabLayout = require(game.ReplicatedStorage.Client.Components.Layout.TabLayout)
local SongInfoDisplay = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongInfoDisplay)
local Button = require(game.ReplicatedStorage.Client.Components.Primitive.Button)
local Slideshow = require(game.ReplicatedStorage.Client.Components.Primitive.Slideshow)
local Slide = require(game.ReplicatedStorage.Client.Components.Primitive.Slideshow.Slide)

local noop = function() end

function SongSelectUI:init()
    self.getSongs = function()
        if self._songs then return self._songs end
        local songs = {}
        for itr_key, itr_data in SongDatabase:key_itr() do
            songs[itr_key] = itr_data
        end
        self._songs = songs
        return songs
    end
    self.select_song_key = self.props.selectSongKey or function() end

    self:setState({
        selectedTab = 1
    })

    self.on_play_button_pressed = function()
        self.props.startGame()
        self.props.history:push("/gameplay")
    end

    self._current_sfx = Instance.new("Sound")
    self._current_sfx.Parent = workspace
    self._current_sfx.Loaded:Connect(function()
        self._current_sfx.TimePosition = NumberUtil.Lerp(0,self._current_sfx.TimeLength,0.35)
        self._current_sfx.PlaybackSpeed = 1
        self._current_sfx.Volume = 0
        local volume_tween_info = TweenInfo.new(3)
        local volume_tween = TweenService:Create(self._current_sfx, volume_tween_info, {
            Volume = 0.5
        })
        volume_tween:Play()
        self._current_sfx:Play()
    end)
    self._current_sfx.Looped = true

    -- MOTOR

    self.motor = Flipper.GroupMotor.new({
        songButtonLayout = 0;
        songInfoDisplay = 0;
        tabLayout = 0;
    })
    self.motorBinding = RoactFlipper.getBinding(self.motor)
end

function SongSelectUI:didUpdate()
    self:update_preview()
end

function SongSelectUI:didMount()
    self.motor:setGoal({
        songInfoDisplay = Flipper.Spring.new(1, {
            frequency = 3.5;
            dampingRatio = 2.5;
        });
        songButtonLayout = Flipper.Spring.new(1, {
            frequency = 4;
            dampingRatio = 2.5;
        });
        tabLayout = Flipper.Spring.new(1, {
            frequency = 5;
            dampingRatio = 2.5;
        });
    })
end

function SongSelectUI:update_preview()
    local _selected_songkey = self.props.selectedSongKey
    if _selected_songkey == SongDatabase:invalid_songkey() then return end

    if self._current_sfx then
        self._current_sfx:Stop()
    end

    local audio_id = SongDatabase:get_data_for_key(_selected_songkey).AudioAssetId
    self._current_sfx.SoundId = audio_id
end

function SongSelectUI:render()
    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 1, 0),
    }, {
        SectionContainer = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 1),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 0.99, 0),
            Size = UDim2.new(0.985, 0, 0.915, 0),
        }, {
            SongInfoLeaderboard = Roact.createElement(Slideshow, {
                slide = self.state.selectedTab;
                Size = UDim2.new(0.35, 0, 0.94, 0);
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(a.songInfoDisplay-1, 0, 0, 0)
                end);
                BackgroundTransparency = 1;
                render = function(slide)
                    return Roact.createFragment({
                        SongInfoDisplay = Roact.createElement(Slide, {
                            slide = 1;
                            currentSlide = slide;
                        }, {
                            Display = Roact.createElement(SongInfoDisplay, {
                                Size = UDim2.new(1, 0, 1, 0),
                                song_key = self.props.selectedSongKey,
                                rate = self.props.songRate,
                                onLeaderboardClick = function()
                                    self:setState({
                                        selectedTab = 2;
                                    })
                                end;
                            }),
                        });
                        Leaderboard = Roact.createElement(Slide, {
                            slide = 2;
                            currentSlide = slide;
                        }, {
                            Display = Roact.createElement(LeaderboardDisplay, {
                                Size = UDim2.new(1, 0, 1, 0),
                                leaderboard = {
                                    {
                                        userid = 526993347,
                                        playername = "kisperal",
                                        marvelouses = 6,
                                        perfects = 5,
                                        greats = 4,
                                        goods = 3,
                                        bads = 2,
                                        misses = 1,
                                        time = 1596444113,
                                        accuracy = 98.98,
                                        place = 1,
                                        score = 0,
                                    }
                                },
                                onSongInfoClick = function()
                                    self:setState({
                                        selectedTab = 1;
                                    })    
                                end,
                                rate = self.props.songRate,
                                onLeaderboardClick = function()
                                    self:setState({
                                        selectedTab = 2;
                                    })
                                end;
                            }),
                        })
                    })
                end
            });
            PlayButton = Roact.createElement(Button, {
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(0.15, 0, 0.05, 0),
                AutoButtonColor = false,
                Font = Enum.Font.Gotham,
                Visible = true;
                Text = "Play!",
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextScaled = true,
                onActivated = self.on_play_button_pressed;
                shrinkBy = 0.005
            }, {
                UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 16;
                    MaxTextSize = 26;
                }),
                UICorner = Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4)
                })
            }),
            SongButtonLayout = Roact.createElement(SongButtonLayout, {
                songs = self.getSongs();
                AnchorPoint = Vector2.new(1,0);
                Position = self.motorBinding:map(function(a)
                    return UDim2.new(2-a.songButtonLayout, 0, 0, 0)
                end);
                Size = UDim2.new(0.645, 0, 0.94, 0);
                on_button_click = self.select_song_key
            }),
        }),
        TabContainer = Roact.createElement(TabLayout, {
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = self.motorBinding:map(function(a)
                return UDim2.new(0.5*a.tabLayout, 0, 0.01, 0)
            end),
            Size = UDim2.new(0.985, 0, 0.055, 0),
            buttons = {
                {
                    Text = "⚙ Settings",
                    OnActivated = function()
                        self.props.history:push("/settings")
                    end
                },

                {
                    Text = "📃 Update Log",
                    OnActivated = noop
                },
            }
        })
    })
end

function SongSelectUI:willUnmount()
    self._current_sfx:Stop()
    self._current_sfx:Destroy()
end

return SongSelectUI
