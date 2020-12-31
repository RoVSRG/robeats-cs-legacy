local Roact = require(game.ReplicatedStorage.Libraries.Roact)
local MultiplayerLobbyUI = Roact.PureComponent:extend("MultiplayerLobbyUI")

local TableUtil = require(game.ReplicatedStorage.Shared.Utils.TableUtil)

local TabLayout = require(game.ReplicatedStorage.Client.Components.Layout.TabLayout)

local MultiplayerRoomButton = require(script.Parent.MultiplayerRoomButton)

function MultiplayerLobbyUI:init()
	self.ref = Roact.createRef()
end

function MultiplayerLobbyUI:didMount()
	local multiListScrolling = self.ref:getValue()
	multiListScrolling.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		multiListScrolling.CanvasSize = UDim2.new(0,0,0,multiListScrolling.UIListLayout.AbsoluteContentSize.Y)
	end)
end

function MultiplayerLobbyUI:render()
	local rooms = TableUtil.Map(self.props.rooms, function(element)
		return Roact.createElement(MultiplayerRoomButton, element)
	end)

	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.49999997, 0),
		Size = UDim2.new(1, 0, 1, 0),
	}, {
		SectionContainer = Roact.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.99000001, 0),
			Size = UDim2.new(0.985000014, 0, 0.915000021, 0),
		}, {
			MultiSection = Roact.createElement("Frame", {
				AnchorPoint = Vector2.new(0, 0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.007, 0),
				Size = UDim2.new(0.7, 0, 0.99, 0),
			}, {
				UICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Multilist = Roact.createElement("ScrollingFrame", {
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.970000029, 0, 0.959999979, 0),
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					ScrollBarThickness = 14,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left,
					[Roact.Ref] = self.ref;
				}, {
					UIListLayout = Roact.createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 15),
					}),
					Rooms = Roact.createFragment(rooms)
				})
			}),
		}),
		TabContainer = Roact.createElement(TabLayout, {
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.00999999978, 0),
			Size = UDim2.new(0.985000014, 0, 0.055, 0),
			buttons = {
				{
					Text = "Back";
				}
			}
		})
	})
end

return MultiplayerLobbyUI
