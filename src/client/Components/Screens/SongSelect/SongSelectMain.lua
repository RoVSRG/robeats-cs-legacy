local Roact: Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SongSelectUI: RoactComponent = Roact.PureComponent:extend("SongSelectUI")

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local SongDatabase = require(game.ReplicatedStorage.Shared.Core.API.Map.SongDatabase)

local TweenService = game:GetService("TweenService")

local Tab = require(game.ReplicatedStorage.Client.Components.Tab)
local NumberUtil = require(game.ReplicatedStorage.Shared.Utils.NumberUtil)

local SongButtonLayout = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongButtonLayout)
local TabLayout = require(game.ReplicatedStorage.Client.Components.Layout.TabLayout)
local SongInfoDisplay = require(game.ReplicatedStorage.Client.Components.Screens.SongSelect.SongInfoDisplay)

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

    self.on_play_button_pressed = SPUtil:input_callback(function()
        self.props.startGame()
        self.props.history:push("/gameplay")
    end)

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
end

function SongSelectUI:didUpdate()
    self:update_preview()
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
            -- SongInfoDisplay = Roact.createElement(SongInfoDisplay, {
            --     Position = UDim2.new(1, 0, 0, 0),
            --     Size = UDim2.new(0.35, 0, 0.89, 0),
            --     song_key = self.props.selectedSongKey,
            --     rate = self.props.songRate
            -- }),
            PlayButton = Roact.createElement("TextButton", {
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Position = UDim2.new(0.65, 0, 1, 0),
                Size = UDim2.new(0.35, 0, 0.1, 0),
                AutoButtonColor = false,
                Font = Enum.Font.Gotham,
                Visible = false;
                Text = "Play!",
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextScaled = true,
                [Roact.Event.InputBegan] = self.on_play_button_pressed
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
                Position = UDim2.new(1,0,0,0);
                Size = UDim2.new(0.645, 0, 0.94, 0);
                on_button_click = self.select_song_key
            }),
        }),
        TabContainer = Roact.createElement(TabLayout, {
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 0.01, 0),
            Size = UDim2.new(0.985, 0, 0.055, 0),
            buttons = {
                {
                    Text = "⚙ Settings",
                    OnActivated = function()
                        self.props.history:push("/settings")
                    end
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
