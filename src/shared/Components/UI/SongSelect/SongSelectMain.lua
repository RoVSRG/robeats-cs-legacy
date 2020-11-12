local Roact: Roact = require(game.ReplicatedStorage.Libraries.Roact)
local SongSelectUI: RoactComponent = Roact.PureComponent:extend("SongSelectUI")

local SongDatabase = require(game.ReplicatedStorage.RobeatsGameCore.SongDatabase)

local Tab = require(game.ReplicatedStorage.Shared.Components.Tab)

local SongButtonLayout = require(game.ReplicatedStorage.Shared.Components.UI.SongSelect.SongButtonLayout)
local TabLayout = require(game.ReplicatedStorage.Shared.Components.UI.TabLayout)
local SongInfoDisplay = require(game.ReplicatedStorage.Shared.Components.UI.SongSelect.SongInfoDisplay)

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
        current_tab = "SongButtonLayout"
    })
end

function SongSelectUI:didUpdate(prevProps, prevState)
    if prevProps.selectedSongKey ~= self.props.selectedSongKey then
        self:setState({
            cur_selected = self.props.selectedSongKey
        })
    end
end

function SongSelectUI:render()
	return Roact.createElement("Frame", {
		Name = "SongSelectUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 1, 0),
        Visible = self.props.currentScreen == nil and true or (self.props.currentScreen == "SongSelect" and true or false)
	}, {
		SectionContainer = Roact.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.99, 0),
			Size = UDim2.new(0.985, 0, 0.915, 0),
		}, {
            SongInfoDisplay = Roact.createElement(SongInfoDisplay, {
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(0.35, 0, 0.89, 0),
                song_key = self.props.selectedSongKey,
                rate = self.props.songRate
            }),
			PlayButton = Roact.createElement("TextButton", {
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(0.65, 0, 1, 0),
				Size = UDim2.new(0.35, 0, 0.1, 0),
				AutoButtonColor = false,
				Font = Enum.Font.Gotham,
				Text = "Play!",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
			}, {
                UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", {
                    MinTextSize = 16;
                    MaxTextSize = 26;
                }),
                UICorner = Roact.createElement("UICorner", {
                    CornerRadius = UDim.new(0, 4)
                })
            }),
			SectionTabs = Roact.createElement(TabLayout, {
				BackgroundColor3 = Color3.fromRGB(53, 53, 53),
                Size = UDim2.new(0.645, 0, 0.05, 0),
                buttons = {
                    {
                        Text = "📃 Select",
                        OnActivated = function()
                            self:setState({
                                current_tab = "SongButtonLayout"
                            })
                        end
                    },
                    {
                        Text = "🎮 Leaderboard",
                        OnActivated = function()
                            self:setState({
                                current_tab = ""
                            })
                        end
                    }
                }
            }),
            Roact.createElement(Tab, {
                current_tab = self.state.current_tab,
                tab_name = "SongButtonLayout"
            }, {
                SongButtonLayout = Roact.createElement(SongButtonLayout, {
                    songs = self.getSongs();
                    AnchorPoint = Vector2.new(0,1);
                    Position = UDim2.new(0,0,1,0);
                    Size = UDim2.new(0.645, 0, 0.94, 0);
                    on_button_click = self.select_song_key
                }),
            })
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

                    end
                },
            }
		})
	})
end

return SongSelectUI
