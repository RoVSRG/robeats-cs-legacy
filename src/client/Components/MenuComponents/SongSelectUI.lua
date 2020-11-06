local Roact = require(script.Parent.Parent.Parent.ReplicatedStorage.Roact)
local SongSelectUI = Roact.PureComponent:extend("SongSelectUI")

function SongSelectUI:init()
end

function SongSelectUI:render()
	return Roact.createElement("Frame", {
		Name = "SongSelectUI",
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
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
			Roact.createElement("TextButton", {
				Name = "PlayButton",
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(0.829707921, 0, 1, 0),
				Size = UDim2.new(0.340000004, 0, 0.110026568, 0),
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
					Size = UDim2.new(0.5, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "Play!",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			}),
			Roact.createElement("Frame", {
				Name = "TabsSection",
				BackgroundColor3 = Color3.fromRGB(53, 53, 53),
				Size = UDim2.new(0.649004459, 0, 0.998620689, 0),
			}, {
				Roact.createElement("Frame", {
					Name = "Tabs",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0, 0, 0.0666666701, 0),
					Size = UDim2.new(0.995177865, 0, 0.930069923, 0),
				}, {
					Roact.createElement("Frame", {
						Name = "LeaderboardSection",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						BorderSizePixel = 0,
						Position = UDim2.new(0.499490321, 0, 0.5, 0),
						Size = UDim2.new(0.998980641, 0, 1, 0),
						Visible = false,
					}, {
						Roact.createElement("ScrollingFrame", {
							Name = "LeaderboardList",
							Active = true,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(25, 25, 25),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(25, 25, 25),
							BorderSizePixel = 0,
							Position = UDim2.new(0.5, 0, 0.5, 0),
							Size = UDim2.new(0.949999988, 0, 0.959999979, 0),
							BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
							ScrollingDirection = Enum.ScrollingDirection.Y,
							TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
						}, {
							Roact.createElement("UIListLayout", {
								SortOrder = Enum.SortOrder.LayoutOrder,
							}),
							Roact.createElement("Frame", {
								Name = "LeaderboardListElementProto",
								BackgroundColor3 = Color3.fromRGB(15, 15, 15),
								BorderMode = Enum.BorderMode.Inset,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, -1.49385073e-08, 0),
								Size = UDim2.new(0.949999988, 0, 0.31054154, 25),
							}, {
								Roact.createElement("ImageLabel", {
									Name = "UserThumbnail",
									AnchorPoint = Vector2.new(0, 0.5),
									BackgroundColor3 = Color3.fromRGB(255, 255, 255),
									Position = UDim2.new(0.0250000097, 0, 0.5, 0),
									Size = UDim2.new(0.0679926649, 0, 0.632285655, 0),
								}, {
									Roact.createElement("UIAspectRatioConstraint", {
										AspectType = Enum.AspectType.ScaleWithParentSize,
										DominantAxis = Enum.DominantAxis.Height,
									}),
									Roact.createElement("UICorner", {
										CornerRadius = UDim.new(0, 4),
									}),
									Roact.createElement("TextLabel", {
										Name = "Place",
										BackgroundColor3 = Color3.fromRGB(54, 54, 54),
										BorderSizePixel = 0,
										Position = UDim2.new(0.0963930413, 0, 0.0963930413, 0),
										Size = UDim2.new(0.414072245, 0, 0.336587548, 0),
										Font = Enum.Font.GothamBold,
										Text = "#1",
										TextColor3 = Color3.fromRGB(204, 204, 8),
										TextScaled = true,
										TextSize = 26,
										TextWrapped = true,
									}, {
										Roact.createElement("UITextSizeConstraint", {
											MaxTextSize = 13,
											MinTextSize = 10,
										}),
										Roact.createElement("UICorner", {
											CornerRadius = UDim.new(0, 4),
										})
									}),
									Roact.createElement("TextLabel", {
										Name = "Data",
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										BackgroundTransparency = 1,
										BorderSizePixel = 0,
										Position = UDim2.new(1.24999988, 0, 0.600000143, 0),
										Size = UDim2.new(12.7336206, 0, 0.349999994, 0),
										Font = Enum.Font.GothamSemibold,
										RichText = true,
										Text = "<b>97.5%</b> | 19/0/8/7/0",
										TextColor3 = Color3.fromRGB(255, 255, 255),
										TextScaled = true,
										TextSize = 16,
										TextWrapped = true,
										TextXAlignment = Enum.TextXAlignment.Left,
									}, {
										Roact.createElement("UITextSizeConstraint", {
											MaxTextSize = 18,
											MinTextSize = 10,
										})
									}),
									Roact.createElement("TextLabel", {
										Name = "Player",
										BackgroundColor3 = Color3.fromRGB(255, 255, 255),
										BackgroundTransparency = 1,
										BorderSizePixel = 0,
										Position = UDim2.new(1.24999988, 0, -1.55270612e-07, 0),
										Size = UDim2.new(15.3386288, 0, 0.550000012, 0),
										Font = Enum.Font.GothamSemibold,
										RichText = true,
										Text = "kisperal <font size="12">Played at 0:00 on 11/3/2020</font>",
										TextColor3 = Color3.fromRGB(145, 145, 145),
										TextScaled = true,
										TextSize = 26,
										TextWrapped = true,
										TextXAlignment = Enum.TextXAlignment.Left,
									}, {
										Roact.createElement("UITextSizeConstraint", {
											MaxTextSize = 26,
										})
									})
								}),
								Roact.createElement("UIAspectRatioConstraint", {
									AspectRatio = 9,
									AspectType = Enum.AspectType.ScaleWithParentSize,
								}),
								Roact.createElement("UICorner", {
									CornerRadius = UDim.new(0, 4),
								})
							})
						}),
						Roact.createElement("TextLabel", {
							Name = "LoadingDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1.00000012, 0, 1, 0),
							Font = Enum.Font.GothamSemibold,
							Text = "Loading recent scores...",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 20,
							TextWrapped = true,
						}),
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("TextLabel", {
							Name = "NoScoresDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1.00000012, 0, 1, 0),
							Font = Enum.Font.GothamSemibold,
							Text = "There are no plays on this map. Go on, be the first!",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 20,
							TextWrapped = true,
						})
					})
				}),
				Roact.createElement("Frame", {
					Name = "TabsList",
					BackgroundColor3 = Color3.fromRGB(39, 39, 39),
					Position = UDim2.new(0.00603195, 0, 0.0104895104, 0),
					Size = UDim2.new(0.988717914, 0, 0.0437062941, 0),
				}, {
					Roact.createElement("Frame", {
						Name = "TabsLayout",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 11,
						Position = UDim2.new(0.010817186, 0, 0, 0),
						Size = UDim2.new(0.971040785, 0, 1, 0),
					}, {
						Roact.createElement("UIListLayout", {
							FillDirection = Enum.FillDirection.Horizontal,
							SortOrder = Enum.SortOrder.LayoutOrder,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							Padding = UDim.new(0.00999999978, 0),
						}),
						Roact.createElement("Frame", {
							Name = "Songs",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(20, 20, 20),
							Position = UDim2.new(0, 0, 0.5, 0),
							Size = UDim2.new(0.200000003, 0, 0.800000012, 0),
						}, {
							Roact.createElement("UICorner", {
								CornerRadius = UDim.new(0, 4),
							}),
							Roact.createElement("TextLabel", {
								Name = "TabName",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 111,
								Size = UDim2.new(0.995850623, 0, 1, 0),
								Font = Enum.Font.GothamBold,
								Text = "Songs",
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextScaled = true,
								TextSize = 14,
								TextWrapped = true,
							}, {
								Roact.createElement("UITextSizeConstraint", {
									MaxTextSize = 13,
									MinTextSize = 10,
								})
							})
						}),
						Roact.createElement("Frame", {
							Name = "Leaderboard",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(20, 20, 20),
							Position = UDim2.new(0, 0, 0.5, 0),
							Size = UDim2.new(0.200000003, 0, 0.800000012, 0),
						}, {
							Roact.createElement("UICorner", {
								CornerRadius = UDim.new(0, 4),
							}),
							Roact.createElement("TextLabel", {
								Name = "TabName",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 111,
								Size = UDim2.new(0.995850623, 0, 1, 0),
								Font = Enum.Font.GothamBold,
								Text = "Leaderboard",
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextScaled = true,
								TextSize = 14,
								TextWrapped = true,
							}, {
								Roact.createElement("UITextSizeConstraint", {
									MaxTextSize = 13,
									MinTextSize = 10,
								})
							})
						})
					}),
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				})
			}),
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
			Roact.createElement("TextButton", {
				Name = "SettingsButton",
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				Size = UDim2.new(0.200000003, 0, 1, 0),
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 22,
				TextWrapped = true,
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("TextLabel", {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "⚙️ Settings",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				})
			}),
			Roact.createElement("UIGridLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				CellPadding = UDim2.new(0.00999999978, 0, 0.100000001, 0),
				CellSize = UDim2.new(0.200000003, 0, 1, 0),
			}),
			Roact.createElement("TextButton", {
				Name = "MultiplayerButton",
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				Size = UDim2.new(0.200000003, 0, 1, 0),
				Font = Enum.Font.SourceSansBold,
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 22,
				TextWrapped = true,
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("TextLabel", {
					Name = "Label",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.75, 0, 0.5, 0),
					Font = Enum.Font.GothamSemibold,
					Text = "Multiplayer",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				})
			})
		})
	})
end

return SongSelectUI
