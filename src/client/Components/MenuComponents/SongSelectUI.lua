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
			Roact.createElement("Frame", {
				Name = "SongInfoSection",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.new(0.340000004, 0, 0.875, 0),
			}, {
				Roact.createElement("TextLabel", {
					Name = "NoSongSelectedDisplay",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(-0.00191900111, 0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					Visible = false,
					ZIndex = 2,
					Font = Enum.Font.GothamSemibold,
					Text = "Click on a song to play.",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 20,
					TextWrapped = true,
				}),
				Roact.createElement("Frame", {
					Name = "SongInfoDisplay",
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Size = UDim2.new(1, 0, 1, 0),
				}, {
					Roact.createElement("ImageLabel", {
						Name = "SongCover",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0.25, 0),
						ScaleType = Enum.ScaleType.Crop,
					}, {
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("UIGradient", {
							Color = ColorSequence.new({0, 0, 0, 0, 0, 0.266223, 0.0941176, 0.0941176, 0.0941176, 0, 1, 1, 1, 1, 0}),
							Rotation = -90,
						})
					}),
					Roact.createElement("UIGradient", {
						Color = ColorSequence.new({0, 1, 1, 1, 0, 0.25, 0, 0, 0, 0, 0.55, 1, 1, 1, 0, 1, 1, 1, 1, 0}),
						Rotation = 90,
					}),
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					}),
					Roact.createElement("TextLabel", {
						Name = "DescriptionDisplay",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.0499999113, 0, 0.611425757, 0),
						Size = UDim2.new(0.899999976, 0, 0.12886931, 0),
						Font = Enum.Font.Gotham,
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
					}),
					Roact.createElement("Frame", {
						Name = "NpsGraph",
						BackgroundColor3 = Color3.fromRGB(16, 16, 16),
						BorderSizePixel = 0,
						Position = UDim2.new(0.0134330085, 0, 0.796225548, 0),
						Size = UDim2.new(0.971014559, 0, 0.185931787, 0),
					}, {
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("TextLabel", {
							Name = "MaxNps",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							Position = UDim2.new(0.0138339922, 0, 0, 0),
							Size = UDim2.new(0.249011859, 0, 0.235294119, 0),
							ZIndex = 3,
							Font = Enum.Font.GothamBlack,
							Text = "MAX NPS: 0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextSize = 14,
							TextXAlignment = Enum.TextXAlignment.Left,
						}),
						Roact.createElement("Frame", {
							Name = "Items",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							ClipsDescendants = true,
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
						}, {
							Roact.createElement("UICorner", {
								CornerRadius = UDim.new(0, 4),
							}),
							Roact.createElement("UIListLayout", {
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Bottom,
							})
						}),
						Roact.createElement("Frame", {
							Name = "SongPosition",
							BackgroundColor3 = Color3.fromRGB(93, 93, 93),
							BorderSizePixel = 0,
							Size = UDim2.new(0.00499999989, 0, 1, 0),
						})
					}),
					Roact.createElement("Frame", {
						Name = "Metadata",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 11,
						Position = UDim2.new(0.0499999113, 0, 0.314990371, 0),
						Size = UDim2.new(0, 349, 0, 129),
					}, {
						Roact.createElement("UIListLayout", {
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0.0109999999, 0),
						}),
						Roact.createElement("TextLabel", {
							Name = "ArtistDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 1,
							Size = UDim2.new(0.957943857, 0, 0.268147349, 0),
							Font = Enum.Font.Gotham,
							Text = "FinnMK",
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
							Name = "NameDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 2,
							Position = UDim2.new(0, 0, 0.26814732, 0),
							Size = UDim2.new(0.957943916, 0, 0.164641663, 0),
							Font = Enum.Font.GothamBold,
							Text = "Monday Night Monsters",
							TextColor3 = Color3.fromRGB(255, 208, 87),
							TextScaled = true,
							TextSize = 26,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
						}, {
							Roact.createElement("UITextSizeConstraint", {
								MaxTextSize = 28,
							})
						}),
						Roact.createElement("TextLabel", {
							Name = "DifficultyDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 3,
							Position = UDim2.new(0, 0, 0.432788938, 0),
							Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
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
							Name = "TotalNotesDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 3,
							Position = UDim2.new(0, 0, 0.432788938, 0),
							Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
							Font = Enum.Font.GothamSemibold,
							Text = "Total Notes: 0",
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
							Name = "TotalHoldsDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 4,
							Position = UDim2.new(0, 0, 0.432788938, 0),
							Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
							Font = Enum.Font.GothamSemibold,
							Text = "Total Holds: 0",
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
							Name = "TotalLengthDisplay",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = 4,
							Position = UDim2.new(0, 0, 0.432788938, 0),
							Size = UDim2.new(0.957943916, 0, 0.122751191, 0),
							Font = Enum.Font.GothamSemibold,
							Text = "Total Length: 0:00",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 26,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
						}, {
							Roact.createElement("UITextSizeConstraint", {
								MaxTextSize = 20,
							})
						})
					}),
					Roact.createElement("TextLabel", {
						Name = "Rate",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.0253480561, 0, 0.740295172, 0),
						Size = UDim2.new(0.289368182, 0, 0.0559303947, 0),
						ZIndex = 3,
						Font = Enum.Font.GothamBold,
						Text = "RATE: 1x",
						TextColor3 = Color3.fromRGB(193, 193, 193),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					}, {
						Roact.createElement("UITextSizeConstraint", {
							MaxTextSize = 18,
							MinTextSize = 10,
						})
					})
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
