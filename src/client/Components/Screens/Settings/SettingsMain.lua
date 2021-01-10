local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SettingsMain = Roact.Component:extend("SettingsMain")

local SettingsList = require(script.Parent.SettingsList)

local TabLayout = require(game.ReplicatedStorage.Client.Components.Layout.TabLayout)

local SettingsGroupToggle = require(script.Parent.SettingsGroupToggle)

local Slideshow = require(game.ReplicatedStorage.Client.Components.Primitive.Slideshow)
local Slide = require(game.ReplicatedStorage.Client.Components.Primitive.Slideshow.Slide)

local Types = script.Parent.Types
local IntSetting = require(Types.IntSetting)
local BindSetting = require(Types.BindSetting)

local function noop() end

function SettingsMain:init()
	self.changeValue = self.props.changeValue or noop
	self:setState({
		selectedTab = 1
	})
end

function SettingsMain:render()
    return Roact.createElement("Frame", {
		Name = "SettingsUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0),
	}, {
		tab = Roact.createElement(TabLayout, {
			buttons = {
				{
					Text = "Back";
					OnActivated = function()
						self.props.history:push("/select")
					end;
				};
				{
					Text = "Reset";
					OnActivated = function()
						self.props.history:push("/select")
					end;
					Color = Color3.new(1, 0, 0);
				};
			};
			AnchorPoint = Vector2.new(0.5, 0);
			Position = UDim2.new(0.5, 0, 0.01, 0);
			Size = UDim2.new(0.985, 0, 0.05, 0);
		});
		Settings = Roact.createElement(Slideshow, {
			slide = self.state.selectedTab;
			Position = UDim2.new(0.191, 0, 0.07, 0),
			Size = UDim2.new(0.802, 0, 0.915, 0),
			BackgroundTransparency = 1;
			render = function(slide)
				return Roact.createFragment({
					General = Roact.createElement(Slide, {
						slide = 1;
						currentSlide = slide;
					}, {
						grid = Roact.createElement(SettingsList, {
							Size = UDim2.new(1, 0, 1, 0),
						}, {
							NoteSpeed = Roact.createElement(IntSetting, {
								value = self.props.settings.NoteSpeed;
								changeSetting = self.changeValue;
								name = "NoteSpeed";
								title = "Note Speed";
							});
							FOV = Roact.createElement(IntSetting, {
								value = self.props.settings.FOV;
								changeSetting = self.changeValue;
								name = "FOV";
								title = "Field of View";
							});
							Keybinds = Roact.createElement(BindSetting, {
								bindingProps = {
									{
										title = "Track 1",
										value = self.props.settings.Keybind1;
										name = "Keybind1"
									},
									{
										title = "Track 2",
										value = self.props.settings.Keybind2;
										name = "Keybind2"
									},
									{
										title = "Track 3",
										value = self.props.settings.Keybind3;
										name = "Keybind3"
									},
									{
										title = "Track 4",
										value = self.props.settings.Keybind4;
										name = "Keybind4"
									}
								},
								changeSetting = self.changeValue;
								title = "Keybinds";
								getDerivedText = function(v)
									return string.format("%0d%%", v)
								end;
							})
						});
					});
					Audio = Roact.createElement(Slide, {
						slide = 2;
						currentSlide = slide;
					}, {
						grid = Roact.createElement(SettingsList, {
							Size = UDim2.new(1, 0, 1, 0),
						}, {
							MusicVolume = Roact.createElement(IntSetting, {
								value = self.props.settings.MusicVolume;
								changeSetting = self.changeValue;
								name = "MusicVolume";
								title = "Music Volume";
								useSlider = true;
								getDerivedText = function(v)
									return string.format("%0d%%", v)
								end;
								initialPercent = self.props.settings.MusicVolume;
								minValue = 0;
								maxValue = 100;
							});
							EffectVolume = Roact.createElement(IntSetting, {
								value = self.props.settings.EffectVolume;
								changeSetting = self.changeValue;
								name = "EffectVolume";
								title = "Effect Volume";
								useSlider = true;
								getDerivedText = function(v)
									return string.format("%0d%%", v)
								end;
								initialPercent = self.props.settings.EffectVolume;
								minValue = 0;
								maxValue = 100;
							});
						});
					});
				})
			end
		});
		list = Roact.createElement("Frame", {
			BackgroundColor3 = Color3.fromRGB(25, 25, 25),
			Position = UDim2.new(0.01, 0, 0.07, 0),
			Size = UDim2.new(0.181, 0, 0.915, 0),
		}, {
			ToggleGeneral = Roact.createElement(SettingsGroupToggle, {
				Size = UDim2.new(1,0,0.2,0);
				Text = "⚙ General";
				LayoutOrder = 1;
				selected = self.state.selectedTab == 1;
				onActivated = function()
					self:setState({
						selectedTab = 1;
					})
				end;
			});
			ToggleAudio = Roact.createElement(SettingsGroupToggle, {
				Size = UDim2.new(1,0,0.2,0);
				Text = "🔉 Audio";
				LayoutOrder = 2;
				selected = self.state.selectedTab == 2;
				onActivated = function()
					self:setState({
						selectedTab = 2;
					})
				end;
			});
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			});
			list = Roact.createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
			});
		})
	})
end

return SettingsMain
