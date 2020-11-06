local Roact = require(script.Parent.Parent.Parent.ReplicatedStorage.Roact)
local InGameMenuStatDisplayUI = Roact.PureComponent:extend("InGameMenuStatDisplayUI")

function InGameMenuStatDisplayUI:init()
end

function InGameMenuStatDisplayUI:render()
	return Roact.createElement("Frame", {
		Name = "InGameMenuStatDisplayUI",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
	}, {
		Roact.createElement("TextLabel", {
			Name = "ScoreDisplay",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.980000019, 0, 0.0500000007, 0),
			Size = UDim2.new(0.150000006, 0, 0.0500000007, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "0",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 26,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Right,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 32,
				MinTextSize = 20,
			})
		}),
		Roact.createElement("TextLabel", {
			Name = "ChainDisplay",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0.150000006, 0, 0.150000006, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "0",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 26,
			TextWrapped = true,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 50,
				MinTextSize = 20,
			}),
			Roact.createElement("UIAspectRatioConstraint", {
			})
		}),
		Roact.createElement("TextLabel", {
			Name = "TimeLeftDisplay",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.0796915367, 0, 0.939130485, 0),
			Size = UDim2.new(0.075000003, 0, 0.0500000007, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "0",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 26,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 26,
				MinTextSize = 20,
			})
		}),
		Roact.createElement("TextButton", {
			Name = "ExitButton",
			BackgroundColor3 = Color3.fromRGB(255, 53, 53),
			Position = UDim2.new(0.0199999996, 0, 0.0500000007, 0),
			Size = UDim2.new(0.100000001, 0, 0.0500000007, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "Exit",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 22,
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			})
		}),
		Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		Roact.createElement("TextLabel", {
			Name = "GradeDisplay",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.980000019, 0, 0.100000001, 0),
			Size = UDim2.new(0.075000003, 0, 0.0500000007, 0),
			Font = Enum.Font.GothamSemibold,
			Text = "0.00%",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 26,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Right,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 32,
				MinTextSize = 20,
			})
		}),
		Roact.createElement("TextLabel", {
			Name = "JudgementDisplay",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.375, 0),
			Size = UDim2.new(0.150000006, 0, 0.0500000007, 0),
			Visible = false,
			Font = Enum.Font.GothamSemibold,
			Text = "Marvelous",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextScaled = true,
			TextSize = 26,
			TextWrapped = true,
		}, {
			Roact.createElement("UITextSizeConstraint", {
				MaxTextSize = 32,
				MinTextSize = 20,
			})
		}),
		Roact.createElement("Frame", {
			Name = "SpreadDisplay",
			BackgroundColor3 = Color3.fromRGB(22, 22, 22),
			Position = UDim2.new(0.890861213, 0, 0.183254302, 0),
			Size = UDim2.new(0.0955423117, 0, 0.304936826, 0),
		}, {
			Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			Roact.createElement("Frame", {
				Name = "Marvs",
				BackgroundColor3 = Color3.fromRGB(77, 77, 77),
				Size = UDim2.new(1, 0, 0.165714279, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("Frame", {
					Name = "Total",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0,
					Size = UDim2.new(0.504817545, 0, 1.00000024, 0),
					ZIndex = 2,
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "Count",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0.114504747, 0, 0, 0),
					Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = "1086",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Right,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 17,
						MinTextSize = 8,
					})
				})
			}),
			Roact.createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Roact.createElement("Frame", {
				Name = "Perfs",
				BackgroundColor3 = Color3.fromRGB(77, 70, 0),
				Size = UDim2.new(1, 0, 0.165714279, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("Frame", {
					Name = "Total",
					BackgroundColor3 = Color3.fromRGB(255, 238, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0.504817545, 0, 1.00000024, 0),
					ZIndex = 2,
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "Count",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0.114504747, 0, 0, 0),
					Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = "1086",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Right,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 17,
						MinTextSize = 8,
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "Greats",
				BackgroundColor3 = Color3.fromRGB(0, 77, 2),
				Size = UDim2.new(1, 0, 0.165714279, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("Frame", {
					Name = "Total",
					BackgroundColor3 = Color3.fromRGB(35, 255, 1),
					BorderSizePixel = 0,
					Size = UDim2.new(0.504817545, 0, 1.00000024, 0),
					ZIndex = 2,
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "Count",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0.114504747, 0, 0, 0),
					Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = "1086",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Right,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 17,
						MinTextSize = 8,
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "Goods",
				BackgroundColor3 = Color3.fromRGB(2, 0, 74),
				Size = UDim2.new(1, 0, 0.165714279, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("Frame", {
					Name = "Total",
					BackgroundColor3 = Color3.fromRGB(0, 46, 255),
					BorderSizePixel = 0,
					Size = UDim2.new(0.504817545, 0, 1.00000024, 0),
					ZIndex = 2,
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "Count",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0.114504747, 0, 0, 0),
					Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = "1086",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Right,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 17,
						MinTextSize = 8,
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "Bads",
				BackgroundColor3 = Color3.fromRGB(59, 0, 74),
				Size = UDim2.new(1, 0, 0.165714279, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("Frame", {
					Name = "Total",
					BackgroundColor3 = Color3.fromRGB(200, 0, 255),
					BorderSizePixel = 0,
					Size = UDim2.new(0.504817545, 0, 1.00000024, 0),
					ZIndex = 2,
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "Count",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0.114504747, 0, 0, 0),
					Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = "1086",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Right,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 17,
						MinTextSize = 8,
					})
				})
			}),
			Roact.createElement("Frame", {
				Name = "Misses",
				BackgroundColor3 = Color3.fromRGB(74, 0, 1),
				Size = UDim2.new(1, 0, 0.165714279, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("Frame", {
					Name = "Total",
					BackgroundColor3 = Color3.fromRGB(255, 0, 4),
					BorderSizePixel = 0,
					Size = UDim2.new(0.504817545, 0, 1.00000024, 0),
					ZIndex = 2,
				}, {
					Roact.createElement("UICorner", {
						CornerRadius = UDim.new(0, 4),
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "Count",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 11,
					Position = UDim2.new(0.114504747, 0, 0, 0),
					Size = UDim2.new(0.816793919, 0, 1.00000012, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = "1086",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Right,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 17,
						MinTextSize = 8,
					})
				})
			})
		}),
		Roact.createElement("Frame", {
			Name = "MultiListDisplay",
			BackgroundColor3 = Color3.fromRGB(22, 22, 22),
			BackgroundTransparency = 11,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Position = UDim2.new(0.0110025769, 0, 0.274802506, 0),
			Size = UDim2.new(0.233033419, 0, 0.725197434, 0),
		}, {
			Roact.createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Roact.createElement("Frame", {
				Name = "PlayerSlotProto",
				BackgroundColor3 = Color3.fromRGB(18, 18, 18),
				Size = UDim2.new(0.998694479, 0, 0.148615986, 0),
			}, {
				Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				Roact.createElement("TextLabel", {
					Name = "Place",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.0284641981, 0, 0, 0),
					Size = UDim2.new(0.249309003, 0, 0.99999994, 0),
					Font = Enum.Font.SourceSansBold,
					Text = "#1",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 45,
						MinTextSize = 20,
					}),
					Roact.createElement("UIAspectRatioConstraint", {
						AspectRatio = 1.1232451200485,
					})
				}),
				Roact.createElement("TextLabel", {
					Name = "PlayerName",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.240364328, 0, 0, 0),
					Size = UDim2.new(0.439070314, 0, 0.517278731, 0),
					Font = Enum.Font.SourceSansBold,
					Text = "kisperal",
					TextColor3 = Color3.fromRGB(177, 177, 177),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 45,
						MinTextSize = 20,
					}),
					Roact.createElement("UIAspectRatioConstraint", {
						AspectRatio = 4.4673647880554,
					})
				}),
				Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = 5.2631039619446,
				}),
				Roact.createElement("TextLabel", {
					Name = "Data",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.240364328, 0, 0.516012311, 0),
					Size = UDim2.new(0.752382815, 0, 0.483987421, 0),
					Font = Enum.Font.SourceSansBold,
					Text = "Score: 12000 | Accuracy: 98%",
					TextColor3 = Color3.fromRGB(100, 100, 100),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				}, {
					Roact.createElement("UITextSizeConstraint", {
						MaxTextSize = 20,
						MinTextSize = 12,
					})
				})
			})
		})
	})
end

return InGameMenuStatDisplayUI
