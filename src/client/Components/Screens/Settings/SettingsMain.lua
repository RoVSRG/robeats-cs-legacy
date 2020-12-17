local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local SettingsMain = Roact.Component:extend("SettingsMain")

local SettingsGrid = require(script.Parent.SettingsGrid)

local TabLayout = require(game.ReplicatedStorage.Client.Components.Layout.TabLayout)

local SPUtil = require(game.ReplicatedStorage.Shared.Utils.SPUtil)

local Types = script.Parent.Types
local IntSetting = require(Types.IntSetting)

local function noop() end

function SettingsMain:init()
	self.changeValue = self.props.changeValue or noop
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
		grid = Roact.createElement(SettingsGrid, {
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0.5, 0, 0.99000001, 0),
			Size = UDim2.new(0.985000014, 0, 0.915000021, 0),
		}, {
			NoteSpeed = Roact.createElement(IntSetting, {
				value = self.props.settings.NoteSpeed;
				changeSetting = self.changeValue;
				name = "NoteSpeed";
				title = "Notespeed";
			})
		})
	})
end

return SettingsMain
