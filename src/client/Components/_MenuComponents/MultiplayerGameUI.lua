local Roact = require(script.Parent.Parent.Parent.ReplicatedStorage.Roact)
local MultiplayerGameUI = Roact.PureComponent:extend("MultiplayerGameUI")

function MultiplayerGameUI:init()
end

function MultiplayerGameUI:render()
	return Roact.createElement("Frame", {
		Name = "MultiplayerGameUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.49999997, 0),
		Size = UDim2.new(1, 0, 1, 0),
	}, {
		Roact.createElement("Frame", {
			Name = "SectionContainer",
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.99000001, 0),
			Size = UDim2.new(0.985000014, 0, 0.915000021, 0),
		}, {
			Roact.createElement("Frame", {
				Name = "PlayerSection",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.5, 0),
				Size = UDim2.new(0.654999971, 0, 1, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("ScrollingFrame", {
					Name = "PlayerList",
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
				}, {
					Roact.createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 15),
					}),
					Roact.createElement("Frame", {
						Name = "PlayerListElementProto",
						BackgroundColor3 = Color3.fromRGB(15, 15, 15),
						BorderSizePixel = 0,
						Size = UDim2.new(0.975000024, 0, 0, 25),
					}, {
						Roact.createElement("ImageLabel", {
							Name = "PlayerCover",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(5, 5, 5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Position = UDim2.new(0.00999999978, 0, 0.5, 0),
							Size = UDim2.new(0.0850000009, 0, 0.0199999996, 0),
							Image = "http://www.roblox.com/asset/?id=5779931881",
							ScaleType = Enum.ScaleType.Fit,
						}, {
							Roact.createElement("TextLabel", {
								Name = "RankDisplay",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Position = UDim2.new(1.20000005, 0, 0.375, 0),
								Size = UDim2.new(5, 0, 0.200000003, 0),
								Font = Enum.Font.GothamSemibold,
								Text = "Rank #???",
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextScaled = true,
								TextSize = 16,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
							}, {
								Roact.createElement("UITextSizeConstraint", {
									MaxTextSize = 24,
									MinTextSize = 10,
								})
							}),
							Roact.createElement("TextLabel", {
								Name = "NameDisplay",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Position = UDim2.new(1.20000005, 0, 0, 0),
								Selectable = true,
								Size = UDim2.new(5, 0, 0.349999994, 0),
								Font = Enum.Font.SourceSansBold,
								Text = "OnlyTwentyCharacters",
								TextColor3 = Color3.fromRGB(255, 208, 87),
								TextScaled = true,
								TextSize = 26,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
							}, {
								Roact.createElement("UITextSizeConstraint", {
									MaxTextSize = 32,
								})
							}),
							Roact.createElement("UIAspectRatioConstraint", {
								AspectType = Enum.AspectType.ScaleWithParentSize,
							}),
							Roact.createElement("UICorner", {
								CornerRadius = UDim.new(0, 4),
							}),
							Roact.createElement("ImageLabel", {
								Name = "Host",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Position = UDim2.new(0.669131219, 0, 0.575000107, 0),
								Size = UDim2.new(0.322174311, 0, 0.322174311, 0),
								Image = "rbxassetid://2515296725",
							})
						}),
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("UIAspectRatioConstraint", {
							AspectRatio = 10,
							AspectType = Enum.AspectType.ScaleWithParentSize,
						})
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "InfoSection",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.new(0.340000004, 0, 0.889999986, 0),
			}, {
				Roact.createElement("TextLabel", {
					Name = "NoSongSelectedDisplay",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
					Visible = false,
					ZIndex = 2,
					Font = Enum.Font.GothamSemibold,
					Text = "Select a song (host) /  Waiting for host (player)",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 20,
					TextWrapped = true,
				}),
				Roact.createElement("Frame", {
					Name = "InfoDisplay",
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
				}, {
					Roact.createElement("ImageLabel", {
						Name = "SongCover",
						BackgroundColor3 = Color3.fromRGB(15, 15, 15),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0.25, 0),
						Image = "rbxassetid://698514070",
						ScaleType = Enum.ScaleType.Crop,
					}, {
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("UIGradient", {
							Color = ColorSequence.new(0 0 0 0 0 0.266223 0.0941176 0.0941176 0.0941176 0 1 1 1 1 0 ),
							Rotation = -90,
						})
					}),
					Roact.createElement("UIGradient", {
						Color = ColorSequence.new(0 1 1 1 0 0.25 0 0 0 0 0.55 1 1 1 0 1 1 1 1 0 ),
						Rotation = 90,
					}),
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					}),
					Roact.createElement("TextLabel", {
						Name = "MultiNameDisplay",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.0500000007, 0, 0.300000012, 0),
						Size = UDim2.new(0.600000024, 0, 0.0500000007, 0),
						Font = Enum.Font.SourceSansBold,
						Text = "OnlyTwentyCharacter's Lobby",
						TextColor3 = Color3.fromRGB(255, 208, 87),
						TextScaled = true,
						TextSize = 26,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					}, {
						Roact.createElement("UITextSizeConstraint", {
							MaxTextSize = 32,
						})
					}),
					Roact.createElement("TextLabel", {
						Name = "SongDisplay",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.0500000007, 0, 0.349999994, 0),
						Size = UDim2.new(0.5, 0, 0.0500000007, 0),
						Font = Enum.Font.SourceSansBold,
						Text = "Monday Night Monsters",
						TextColor3 = Color3.fromRGB(255, 208, 87),
						TextScaled = true,
						TextSize = 26,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					}, {
						Roact.createElement("UITextSizeConstraint", {
							MaxTextSize = 26,
						})
					}),
					Roact.createElement("TextLabel", {
						Name = "DifficultyDisplay",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.0500000007, 0, 0.389999986, 0),
						Size = UDim2.new(0.5, 0, 0.0299999993, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "Difficulty: 1",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					}, {
						Roact.createElement("UITextSizeConstraint", {
							MaxTextSize = 20,
						})
					}),
					Roact.createElement("TextLabel", {
						Name = "DescriptionDisplay",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.0500000007, 0, 0.449999988, 0),
						Size = UDim2.new(0.899999976, 0, 0.5, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "The main theme to MONDAY NIGHT MONSTERS, a 2016 game by spotco. FinnMK is also the main composer for Robeats!",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					}, {
						Roact.createElement("UITextSizeConstraint", {
							MaxTextSize = 22,
						})
					})
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			}),
			Roact.createElement("TextButton", {
				Name = "PlayButton",
				AnchorPoint = Vector2.new(1, 1),
				BackgroundColor3 = Color3.fromRGB(50, 188, 0),
				Position = UDim2.new(1, 0, 1, 0),
				Size = UDim2.new(0.340000004, 0, 0.100000001, 0),
				AutoButtonColor = false,
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextScaled = true,
				TextSize = 26,
				TextWrapped = true,
			}, {
				Roact.createElement("TextLabel", {
					Name = "PlayButtonText",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Selectable = true,
					Size = UDim2.new(0.5, 0, 0.400000006, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "Play",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			})
		}),
		Roact.createElement("Frame", {
			Name = "TabContainer",
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.00999999978, 0),
			Size = UDim2.new(0.985000014, 0, 0.0549999997, 0),
		}, {
			Roact.createElement("UIGridLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				CellPadding = UDim2.new(0.00999999978, 0, 0.100000001, 0),
				CellSize = UDim2.new(0.189999998, 0, 1, 0),
			}),
			Roact.createElement("TextButton", {
				Name = "LeaveRoomButton",
				BackgroundColor3 = Color3.fromRGB(234, 57, 57),
				Size = UDim2.new(0.200000003, 0, 1, 0),
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 22,
				TextWrapped = true,
			}, {
				Roact.createElement("TextLabel", {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "Leave Room",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			}),
			Roact.createElement("TextButton", {
				Name = "TransferHostButton",
				BackgroundColor3 = Color3.fromRGB(50, 188, 0),
				Size = UDim2.new(0.200000003, 0, 1, 0),
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 22,
				TextWrapped = true,
			}, {
				Roact.createElement("TextLabel", {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "Transfer Host",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			}),
			Roact.createElement("TextButton", {
				Name = "ChangeSongButton",
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				Size = UDim2.new(0.200000003, 0, 1, 0),
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 22,
				TextWrapped = true,
			}, {
				Roact.createElement("TextLabel", {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "Change Song",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			}),
			Roact.createElement("TextButton", {
				Name = "TestButton",
				BackgroundColor3 = Color3.fromRGB(59, 59, 59),
				Size = UDim2.new(0.200000003, 0, 1, 0),
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 22,
				TextWrapped = true,
			}, {
				Roact.createElement("TextLabel", {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "TestButton",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			})
		})
	})
end

return MultiplayerGameUI
