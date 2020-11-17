local Roact = require(game.ReplicatedStorage.Libraries.Roact)

local ResultsScreenMain = Roact.Component:extend("ResultsScreenMain")
 
function ResultsScreenMain:render()
    return Roact.createElement("Frame", {
		Name = "ResultsMenuUI",
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
				Name = "HitContainer",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				Position = UDim2.new(1, 0, 0.429999948, 0),
				Size = UDim2.new(0.497000009, 0, 0.563807964, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				Roact.createElement("Frame", {
					Name = "Hits",
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0.89999997615814,
					ClipsDescendants = true,
					Position = UDim2.new(0.00798931159, 0, 0.0132246064, 0),
					Size = UDim2.new(0.983741581, 0, 0.9718135, 0),
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 6),
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "SpreadContainer",
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				Position = UDim2.new(0, 0, 0.429999948, 0),
				Size = UDim2.new(0.497000009, 0, 0.563807964, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				Roact.createElement("Frame", {
					Name = "SpreadDisplay",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(15, 15, 15),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.985000014, 0, 0.973500013, 0),
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					}),
					Roact.createElement("Frame", {
						Name = "Marvelous",
						BackgroundColor3 = Color3.fromRGB(113, 113, 113),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0.166999996, 0),
					}, {
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("Frame", {
							Name = "Stabilizer",
							BackgroundColor3 = Color3.fromRGB(113, 113, 113),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 0, 0.5, 0),
							Size = UDim2.new(1, 0, 0.5, 0),
						}),
						Roact.createElement("Frame", {
							Name = "Total",
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BorderSizePixel = 0,
							Size = UDim2.new(0, 0, 1.00000012, 0),
						}, {
							Roact.createElement("Frame", {
								Name = "Stabilizer",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 0.5, 0),
							}),
							Roact.createElement("UICorner", {
								CornerRadius = UDim.new(0, 4),
							})
						}),
						Roact.createElement("TextLabel", {
							Name = "TotalNumber",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.908163249, 0, 0.500000179, 0),
							Size = UDim2.new(0.0804517642, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
						}),
						Roact.createElement("TextLabel", {
							Name = "MA",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.0382652916, 0, 0.500000179, 0),
							Size = UDim2.new(0.504279733, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "RATIO:",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
						})
					}),
					Roact.createElement("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Roact.createElement("Frame", {
						Name = "Perfect",
						BackgroundColor3 = Color3.fromRGB(117, 101, 23),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.167999998, 0),
						Size = UDim2.new(1, 0, 0.166999996, 0),
					}, {
						Roact.createElement("Frame", {
							Name = "Total",
							BackgroundColor3 = Color3.fromRGB(255, 221, 50),
							BorderSizePixel = 0,
							Size = UDim2.new(0, 0, 1.00000012, 0),
						}, {
							Roact.createElement("Frame", {
								Name = "Stabilizer",
								BackgroundColor3 = Color3.fromRGB(255, 221, 50),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 0.5, 0),
							})
						}),
						Roact.createElement("TextLabel", {
							Name = "TotalNumber",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.908163249, 0, 0.500000179, 0),
							Size = UDim2.new(0.0804517642, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
						}),
						Roact.createElement("TextLabel", {
							Name = "PA",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.0382652916, 0, 0.500000179, 0),
							Size = UDim2.new(0.504279733, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "RATIO:",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
						})
					}),
					Roact.createElement("Frame", {
						Name = "Great",
						BackgroundColor3 = Color3.fromRGB(19, 107, 35),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.335999995, 0),
						Size = UDim2.new(1, 0, 0.166999996, 0),
					}, {
						Roact.createElement("TextLabel", {
							Name = "TotalNumber",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.908163249, 0, 0.500000179, 0),
							Size = UDim2.new(0.0804517642, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
						}),
						Roact.createElement("Frame", {
							Name = "Total",
							BackgroundColor3 = Color3.fromRGB(47, 255, 85),
							BorderSizePixel = 0,
							Size = UDim2.new(0, 0, 1.00000012, 0),
						}, {
							Roact.createElement("Frame", {
								Name = "Stabilizer",
								BackgroundColor3 = Color3.fromRGB(47, 255, 85),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 0.5, 0),
							})
						})
					}),
					Roact.createElement("Frame", {
						Name = "Good",
						BackgroundColor3 = Color3.fromRGB(19, 79, 103),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.503999949, 0),
						Size = UDim2.new(1, 0, 0.166999996, 0),
					}, {
						Roact.createElement("TextLabel", {
							Name = "TotalNumber",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.908163249, 0, 0.500000179, 0),
							Size = UDim2.new(0.0804517642, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
						}),
						Roact.createElement("Frame", {
							Name = "Total",
							BackgroundColor3 = Color3.fromRGB(48, 197, 255),
							BorderSizePixel = 0,
							Size = UDim2.new(0, 0, 1, 0),
						}, {
							Roact.createElement("Frame", {
								Name = "Stabilizer",
								BackgroundColor3 = Color3.fromRGB(48, 197, 255),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 0.5, 0),
							})
						})
					}),
					Roact.createElement("Frame", {
						Name = "Bad",
						BackgroundColor3 = Color3.fromRGB(79, 16, 90),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.671999991, 0),
						Size = UDim2.new(1, 0, 0.166999996, 0),
					}, {
						Roact.createElement("TextLabel", {
							Name = "TotalNumber",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.908163249, 0, 0.499999613, 0),
							Size = UDim2.new(0.0804517642, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
						}),
						Roact.createElement("Frame", {
							Name = "Total",
							BackgroundColor3 = Color3.fromRGB(224, 46, 255),
							BorderSizePixel = 0,
							Size = UDim2.new(0, 0, 1, 0),
						}, {
							Roact.createElement("Frame", {
								Name = "Stabilizer",
								BackgroundColor3 = Color3.fromRGB(224, 46, 255),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 0.5, 0),
								Size = UDim2.new(1, 0, 0.5, 0),
							})
						})
					}),
					Roact.createElement("Frame", {
						Name = "Miss",
						BackgroundColor3 = Color3.fromRGB(70, 12, 12),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0.839999974, 0),
						Size = UDim2.new(1, 0, 0.166999996, 0),
					}, {
						Roact.createElement("UICorner", {
							CornerRadius = UDim.new(0, 4),
						}),
						Roact.createElement("Frame", {
							Name = "Stabilizer",
							BackgroundColor3 = Color3.fromRGB(70, 12, 12),
							BorderSizePixel = 0,
							Size = UDim2.new(1, 0, 0.5, 0),
						}),
						Roact.createElement("TextLabel", {
							Name = "TotalNumber",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(27, 42, 53),
							BorderSizePixel = 0,
							Position = UDim2.new(0.908163249, 0, 0.499999613, 0),
							Size = UDim2.new(0.0804517642, 0, 0.400000006, 0),
							ZIndex = 2,
							Font = Enum.Font.GothamSemibold,
							Text = "0",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextStrokeTransparency = 0.5,
							TextWrapped = true,
						}),
						Roact.createElement("Frame", {
							Name = "Total",
							BackgroundColor3 = Color3.fromRGB(255, 48, 48),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 0, 1.27077158e-06, 0),
							Size = UDim2.new(0, 0, 0.999998748, 0),
						}, {
							Roact.createElement("Frame", {
								Name = "Stabilizer",
								BackgroundColor3 = Color3.fromRGB(255, 48, 48),
								BorderSizePixel = 0,
								Position = UDim2.new(-1.71650978e-08, 0, -0.0205089822, 0),
								Size = UDim2.new(0.99999994, 0, 0.5, 0),
							}),
							Roact.createElement("UICorner", {
								CornerRadius = UDim.new(0, 4),
							})
						})
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "DataContainer",
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				Position = UDim2.new(0, 0, 0.314999998, 0),
				Size = UDim2.new(1, 0, 0.100000001, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Roact.createElement("Frame", {
					Name = "Accuracy",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.200000003, 0, 1, 0),
				}, {
					Roact.createElement("TextLabel", {
						Name = "Data",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.699999988, 0),
						Size = UDim2.new(0.5, 0, 0.349999994, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "95.47%",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					}),
					Roact.createElement("TextLabel", {
						Name = "Label",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.300000012, 0),
						Size = UDim2.new(0.5, 0, 0.300000012, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "Accuracy",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					})
				}),
				Roact.createElement("Frame", {
					Name = "Score",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.200000003, 0, 1, 0),
				}, {
					Roact.createElement("TextLabel", {
						Name = "Data",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.699999988, 0),
						Size = UDim2.new(0.5, 0, 0.349999994, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "1,000,000",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					}),
					Roact.createElement("TextLabel", {
						Name = "Label",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.300000012, 0),
						Size = UDim2.new(0.5, 0, 0.300000012, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "Score",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					})
				}),
				Roact.createElement("Frame", {
					Name = "Rating",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.200000003, 0, 1, 0),
				}, {
					Roact.createElement("TextLabel", {
						Name = "Data",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.699999988, 0),
						Size = UDim2.new(0.5, 0, 0.349999994, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "57.56",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					}),
					Roact.createElement("TextLabel", {
						Name = "Label",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.300000012, 0),
						Size = UDim2.new(0.5, 0, 0.300000012, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "Rating",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					})
				}),
				Roact.createElement("Frame", {
					Name = "MaxCombo",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.200000003, 0, 1, 0),
				}, {
					Roact.createElement("TextLabel", {
						Name = "Data",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.699999988, 0),
						Size = UDim2.new(0.5, 0, 0.349999994, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "566x",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					}),
					Roact.createElement("TextLabel", {
						Name = "Label",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.300000012, 0),
						Size = UDim2.new(0.5, 0, 0.300000012, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "Max Combo",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					})
				}),
				Roact.createElement("Frame", {
					Name = "Mean",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Size = UDim2.new(0.200000003, 0, 1, 0),
				}, {
					Roact.createElement("TextLabel", {
						Name = "Data",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.699999988, 0),
						Size = UDim2.new(0.5, 0, 0.349999994, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "-11.115ms",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					}),
					Roact.createElement("TextLabel", {
						Name = "Label",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0.5, 0, 0.300000012, 0),
						Size = UDim2.new(0.5, 0, 0.300000012, 0),
						Font = Enum.Font.GothamSemibold,
						Text = "Mean",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 26,
						TextStrokeTransparency = 0.5,
						TextWrapped = true,
					})
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
				Name = "BackButton",
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				Size = UDim2.new(0.19065246, 0, 1, 0),
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
					Text = "Back",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
				}),
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				})
			}),
			Roact.createElement("UIGridLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				CellPadding = UDim2.new(0.00999999978, 0, 0.100000001, 0),
				CellSize = UDim2.new(0.189999998, 0, 1, 0),
			})
		})
	})
end

return ResultsScreenMain
